#include "qmlprovider.h"

#include <QDebug>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QStyle>

#include "datamodel/datamodel.h"

QmlProvider::QmlProvider(QObject* parent)
  : QObject(parent)
{

}

int QmlProvider::runApplication(QGuiApplication& guiApp) {
  qInfo() << "Compiled with Qt Version:" << QT_VERSION_STR;

  guiApp.setApplicationName(tr("Программа подсчета вхождений слов"));
  guiApp.setWindowIcon(QIcon(":/images/logo.svg"));
  guiApp.setOrganizationName("Vadim Ivankov");
  guiApp.setOrganizationDomain("https://ivank.ru/");

  QQmlApplicationEngine engine;

  engine.rootContext()->setContextProperty("provider", this);

  DataModel* myDataModel = new DataModel;
  connect(this, &QmlProvider::start, myDataModel, &DataModel::onStarted);
  connect(this, &QmlProvider::pause, myDataModel, &DataModel::onPaused);
  connect(this, &QmlProvider::cancel, myDataModel, &DataModel::onCancel);

  engine.rootContext()->setContextProperty("myDataModel", myDataModel);

  const QUrl url(QStringLiteral("qrc:/main.qml"));
  engine.addImportPath(":/");

  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &guiApp,
      [url](QObject* obj, const QUrl& objUrl) {
        if (!obj && url == objUrl)
          QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);

  engine.load(url);

  return guiApp.exec();
}
