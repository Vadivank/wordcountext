#ifndef DATAMODEL_H
#define DATAMODEL_H

#include <QAbstractListModel>
#include <QTimer>
#include <QVector>

#include "datareceiver.h"

/**
 * @brief DataModel - класс, представляющий собой модель данных.
 *
 * Данная модель представляет собой стандартный набор методов и параметров.
 */

class DataModel : public QAbstractListModel {
  Q_OBJECT

  /**
   * \brief Свойство вернет максимальное значение из всех содержащихся в
   * контейнере.
   *
   * Используется для выравнивания, чтобы гистограммы не выходили за границы
   * экрана.
   */
  Q_PROPERTY(quint64 maxValue READ maxValue CONSTANT)

  /**
   * \brief Свойство вернет значение прогресса загрзуки файла.
   */
  Q_PROPERTY(qreal progressLoading READ progress NOTIFY modelUpdated)

  enum Roles {
    INDEX = Qt::UserRole + 1,  // otherwise quash
    WORD,
    COUNTER,
    COLOR,
  };

  QList<std::pair<QString, uint64_t>> m_container;
  DataReceiver* m_dataReceiver;
  QTimer* m_timer;
  int m_updateTime;
  double m_progress;

 public:
  /**
   * @brief Конструктор.
   */
  DataModel();

  /**
   * @brief Получить роли модели.
   */
  QHash<int, QByteArray> roleNames() const override;

  /**
   * @brief Получить количество элементов в модели.
   */
  int rowCount(const QModelIndex& parent = {}) const override;

  /**
   * @brief Получить данные модели.
   */
  QVariant data(const QModelIndex& index = {},
                int role = Qt::DisplayRole) const override;

  /**
   * @brief Максимальное значение среди всех элементов модели.
   */
  Q_INVOKABLE quint64 maxValue();

  /**
   * @brief Вернуть значение прогресса чтения файла с данными для модели.
   */
  Q_INVOKABLE qreal progress();

 public slots:
  /**
   * @brief Начать чтение файла, наполняющего модель.
   */
  void onStarted(const QString& fileName);

  /**
   * @brief Произвести действия после окончания чтения файла.
   */
  void onFinishLoading();

  /**
   * @brief Поставить на паузу.
   */
  void onPaused();

  /**
   * @brief Отменить чтение файла.
   */
  void onCancel();

  /**
   * @brief Изменить прогресс чтения файла.
   */
  void onProgress(double value);

 signals:
  /**
   * @brief Сигнал о том, что данные в модели изменились.
   */
  void modelUpdated();

 private slots:
  /**
   * @brief Обновить данные модели.
   */
  void onUpdateCurrentData();
};

#endif  // DATAMODEL_H
