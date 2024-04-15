#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "qmlprovider.h"

int main(int argc, char *argv[]) {
  Q_INIT_RESOURCE(resource);

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

  QGuiApplication::setAttribute(Qt::AA_UseSoftwareOpenGL);
  QGuiApplication app(argc, argv);

  // TODO: create backend and pass link it with ui

  QmlProvider *ui = new QmlProvider(/* here can be backend logic ptr */);

  int finish{ui->runApplication(app)};

  // TODO: remove backend

  return finish;
}
