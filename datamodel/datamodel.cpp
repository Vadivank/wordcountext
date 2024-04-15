#include "datamodel.h"

#include <QFile>
#include <QMap>
#include <QVector>

DataModel::DataModel()
    : m_dataReceiver {new DataReceiver}
    , m_timer {new QTimer(this)}
    , m_updateTime {40}
{
  connect(m_timer, &QTimer::timeout,
          this, &DataModel::onUpdateCurrentData);
  connect(m_dataReceiver, &DataReceiver::finished,
          this, &DataModel::onFinishLoading);
  connect(m_dataReceiver, &DataReceiver::progress,
          this, &DataModel::onProgress);
}

QHash<int, QByteArray> DataModel::roleNames() const {
  QHash<int, QByteArray> roles;

  roles[DataModel::INDEX] = "MODEL_INDEX";
  roles[DataModel::WORD] = "MODEL_WORD";
  roles[DataModel::COUNTER] = "MODEL_COUNTER";
  roles[DataModel::COLOR] = "MODEL_COLOR";

  return roles;
}

int DataModel::rowCount(const QModelIndex& parent) const {
  Q_UNUSED(parent)
  return m_container.size();
}

QVariant DataModel::data(const QModelIndex& index, int role) const {
  if (!index.isValid() || (index.row() >= rowCount(index)) ||
      (index.row() < 0)) {
    return {};
  }

  QString word;
  uint64_t counter;
  std::tie(word, counter) = m_container.at(index.row());

  switch (role) {
    case DataModel::Roles::INDEX: {
      return index.row();
    }
    case DataModel::Roles::WORD: {
      return word;
    }
    case DataModel::Roles::COUNTER: {
      return counter;
    }
    case DataModel::Roles::COLOR: {
      return QString("#%1").arg(0xA00000 - 0xFFFF * 4 * index.row(), 6, 16,
                                QLatin1Char('0'));
    }
    default: {
      return {};
    }
  }
}

quint64 DataModel::maxValue() {
  quint64 max{};
  foreach (auto item, m_container) {
    max = item.second > max ? item.second : max;
  }
  return max;
}

qreal DataModel::progress() {
  return m_progress;
}

void DataModel::onStarted(const QString& fileName) {
  onCancel();
  QThread::msleep(20);  // signals processing time
  m_dataReceiver->startReadingData(fileName);
  m_timer->start(m_updateTime);
}

void DataModel::onFinishLoading() {
  m_timer->stop();
  onUpdateCurrentData();
  emit modelUpdated();
}

void DataModel::onPaused() {
  m_dataReceiver->pause();

  if (m_dataReceiver->currentState() == DataReceiver::State::PAUSED) {
    m_timer->stop();
  } else {
    m_timer->start(m_updateTime);
  }
}

void DataModel::onCancel() {
  m_timer->stop();
  m_dataReceiver->cancel();
  m_progress = 0;
  onUpdateCurrentData();
}

void DataModel::onProgress(double value) {
  m_progress = value;
}

void DataModel::onUpdateCurrentData() {
  beginResetModel();
  m_container.clear();
  m_container = m_dataReceiver->currentData();
  emit modelUpdated();
  endResetModel();
}
