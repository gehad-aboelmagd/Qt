// #include <QGuiApplication>
// #include <QQmlApplicationEngine>

// int main(int argc, char *argv[])
// {
//     qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

//     QGuiApplication app(argc, argv);

//     QQmlApplicationEngine engine;
//     QObject::connect(
//         &engine,
//         &QQmlApplicationEngine::objectCreationFailed,
//         &app,
//         []() { QCoreApplication::exit(-1); },
//         Qt::QueuedConnection);
//     engine.loadFromModule("MediaPlayer", "Main");

//     return app.exec();
// }


#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "audioplayer.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    AudioPlayer player;
    engine.rootContext()->setContextProperty("audioPlayer", &player);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("MediaPlayer", "Main");

    return app.exec();
}
