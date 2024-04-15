#ifndef DATARECEIVER_H
#define DATARECEIVER_H

#include <QMap>
#include <QObject>
#include <QThread>

/**
 * @brief DataReceiver - класс, предназначенный для чтения данных из файла.
 *
 * Поскольку данный проект представляет собой эксперимент, в нем предусмотрена
 * возможность взаимодействия с интерфейсом "изнутри". При инициализации полей в
 * конструкторе класса, в поле `m_delay` можно установить значение, отличное от
 * нуля, и таким образом, задать задержку чтения для лучшего отобржаения
 * анимации чтения. Поле `m_places` отвечает за количество самых часто
 * встречающихся слов в тексте.
 * 
 */

class DataReceiver : public QObject {
  Q_OBJECT

 public:
  /**
   * @brief Перечисление для определения текущего сосотояния сущности.
   */
  enum class State { RUNNING, PAUSED, FINISHED, CANCELLED };

  /**
   * @brief Конструктор.
   */
  DataReceiver();

  /**
   * @brief Вернуть текущее состояние контейнера, в процессе чтения файла.
   */
  QList<std::pair<QString, uint64_t>> currentData();

  /**
   * @brief В методе происходит подготовка к запуску потока чтения файла.
   */
  bool startReadingData(const QString& fileName);

  /**
   * @brief Удалить собранные данные.
   */
  void clearData();

  /**
   * @brief Поставить чтение на паузу.
   */
  void pause();

  /**
   * @brief Отменить процесс чтения.
   */
  void cancel();

  /**
   * @brief Вернуть текущее состояние сущности.
   */
  State currentState();

 signals:
  /**
   * @brief Сигнал о завершении чтения файла.
   */
  void finished();

  /**
     @brief Сигнал об отмене процесса чтения.
   */
  void cancelled();

  /**
   * @brief Сигнал о состоянии прогресса чтения файла.
   */
  void progress(double value);

 private:
  /**
     @brief В методе осуществляется непосредственно чтение файла.
   */
  void readFile();

 private:
  QMap<QString, uint64_t> m_container;
  int m_places;
  QString m_fileName;
  qreal m_progress;
  State m_state;
  int m_delay;
  QThread m_thread;
  std::mutex m_mutex;
  //  mutable std::recursive_mutex m_lock;
};

#endif  // DATARECEIVER_H
