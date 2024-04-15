#include "datareceiver.h"

#include <QByteArray>
#include <QFile>
#include <QTextStream>

DataReceiver::DataReceiver()
    : m_delay {0}  // msec
    , m_places {15}
    , m_state {State::FINISHED}
{
  QObject::connect(&m_thread, &QThread::started, this, &DataReceiver::readFile);
  QObject::connect(&m_thread, &QThread::finished, this, [=]() {
    switch (m_state) {
      case State::FINISHED: {
        emit finished();
        break;
      }
      case State::CANCELLED: {
        emit cancelled();
        break;
      }
      default: {
      }
    }
  });
}

QList<std::pair<QString, uint64_t>> DataReceiver::currentData() {
  QList<std::pair<QString, uint64_t>> data;
  // TODO: compare timing with `mutex lock` vs `lock_guard`
  //  std::lock_guard<std::recursive_mutex> locker(m_lock);
  m_mutex.lock();
  QList<QString> keys{m_container.keys()};
  QList<uint64_t> values{m_container.values()};
  m_mutex.unlock();

  int size;
  if (m_places > 0) {
    size = values.size() < m_places ? values.size() : m_places;
  } else {
    size = values.size();
  }

  for (auto c = 0; c < size; ++c) {
    int iMax = std::distance(values.begin(),
                             std::max_element(values.begin(), values.end()));

    data.push_back({keys.at(iMax), values.at(iMax)});

    keys.removeAt(iMax);
    values.removeAt(iMax);
  }

  return data;
}

bool DataReceiver::startReadingData(const QString& fileName) {
  if (fileName.isEmpty()) {
    return false;
  }
  m_state = State::RUNNING;
  m_fileName = fileName;
  moveToThread(&m_thread);
  m_thread.start();

  return true;
}

void DataReceiver::pause() {
  if (m_state == State::PAUSED) {
    m_state = State::RUNNING;
  } else {
    m_state = State::PAUSED;
  }
}

void DataReceiver::cancel() {
  m_state = State::CANCELLED;
  m_thread.quit();
  clearData();
}

DataReceiver::State DataReceiver::currentState() {
  return m_state;
}

void DataReceiver::clearData() {
  m_fileName.clear();
  m_progress = 0;
  m_container.clear();
  emit progress(m_progress);
}

void DataReceiver::readFile() {
  QString fileName{m_fileName};
  QFile file(fileName);
  file.open(QIODevice::ReadOnly);
  QTextStream textStream(&file);
  textStream.setCodec("UTF-8");

  const double fsize{static_cast<qreal>(file.size())};

  uint64_t counter{};


  while (!textStream.atEnd()) {
    const auto rawString = textStream.readLine();

    counter += strlen(rawString.toStdString().c_str());

    const auto words = rawString.split(QRegExp("\\s+"));

    for (QString word : words) {
      while (m_state == State::PAUSED) {

      }

      if (m_state == State::CANCELLED) {
        return;
      }

      word = word.toLower();
      word.remove(QRegExp("[^a-zA-Zа-яА-Я\\d\\s\\t\\r\\n\\v\\f]"));

      // TODO: compare timing with `mutex lock` vs `lock_guard`
      //      std::lock_guard<std::recursive_mutex> locker(m_lock);
      m_mutex.lock();
      if (!word.isEmpty())
        ++m_container[word];
      m_mutex.unlock();
    }

    // TODO: its very expensive operation -- need to move to other thread
    //    emit progress(textStream.pos() / fsize); // ~10 msec / operation

    // this is a crutch to speed up find cursor instead `textStream.pos()`
    emit progress(counter / fsize);

    if (m_delay)
      QThread::msleep(m_delay);  // imitate long data
  }

  m_state = State::FINISHED;
  emit progress(1);
}
