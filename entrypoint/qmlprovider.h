#ifndef QMLPROVIDER_H
#define QMLPROVIDER_H

#include <QApplication>
#include <QGuiApplication>
#include <QObject>

/**
 * \brief QmlProvider - класс, представлюящий собой масштабируемый
 * слой-прокладку между QML и C++ логикой.
 *
 * Поскольку приложение обладает довольно простым набором контроля и для
 * простоты реализации, коннекты метаобъектной системы Qt помщенны в данном
 * классе, а не в отдельном.
 */

class QmlProvider : public QObject {
  Q_OBJECT

 public:
  /**
   * \brief Конструктор.
   */
  explicit QmlProvider(QObject* parent = nullptr);

  /**
   * \brief Произвести инициализацию QML и запустить приложение.
   */
  int runApplication(QGuiApplication& guiApp);

 signals:
  /**
   * \brief В UI нажата кнопка Старт.
   */
  void start(const QString fileName);

  /**
   * \brief В UI нажата кнопка Пауза.
   */
  void pause();

  /**
   * \brief В UI нажата кнопка Отмена.
   */
  void cancel();
};

#endif  // QMLPROVIDER_H
