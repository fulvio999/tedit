#include <QtQml>
#include <QtQml/QQmlContext>
#include "backend.h"
#include "mytype.h"


void BackendPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("EdIt"));

    /* register the c++ object to be available as QML object named FileIO */
    qmlRegisterType<MyType>(uri, 1, 0, "FileIO");
}

void BackendPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}
