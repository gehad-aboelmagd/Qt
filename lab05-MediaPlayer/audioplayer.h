// #ifndef AUDIOPLAYER_H
// #define AUDIOPLAYER_H

// #include <QObject>
// #include <QMediaPlayer>
// #include <QAudioOutput>

// class AudioPlayer : public QObject
// {
//     Q_OBJECT
//     Q_PROPERTY(bool playing READ getPlayingState WRITE togglePlayPuase NOTIFY playingChanged FINAL)
//     Q_PROPERTY(qint64 position READ getPosition WRITE setPosition NOTIFY positionChanged FINAL)
//     Q_PROPERTY(qint64 duration READ getDuration WRITE setDuration NOTIFY durationChanged FINAL)
//     Q_PROPERTY(bool muted READ getMute WRITE toggleMute NOTIFY mutedChanged FINAL)
//     Q_PROPERTY(float volume READ getVolume WRITE setVolume NOTIFY volumeChanged FINAL)

// public:
//     explicit AudioPlayer(QObject *parent = nullptr);

//     // Getters
//     bool getPlayingState();
//     qint64 getPosition();
//     qint64 getDuration();
//     bool getMute();

//     // Setters
//     void setPosition();
//     void setDuration();
//     void toggleMute();

//     Q_INVOKABLE void setAudioSource(const QString &file);
//     Q_INVOKABLE void togglePlayPause();
//     Q_INVOKABLE void stop();


// signals:
//     void playingChanged();
//     void positionChanged();
//     void durationChanged();
//     void muteChanged();

// private:
//     QMediaPlayer * m_mediaPlayer;
//     QAudioOutput * m_audioOutput;

// };

// #endif // AUDIOPLAYER_H


#ifndef AUDIOPLAYER_H
#define AUDIOPLAYER_H

#include <QObject>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QMediaMetaData>

class AudioPlayer : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool playing READ playing NOTIFY playingChanged FINAL)
    Q_PROPERTY(qint64 position READ position WRITE setPosition NOTIFY positionChanged FINAL)
    Q_PROPERTY(qint64 duration READ duration NOTIFY durationChanged FINAL)
    Q_PROPERTY(bool muted READ muted WRITE setMuted NOTIFY mutedChanged FINAL)
    Q_PROPERTY(qreal volume READ volume WRITE setVolume NOTIFY volumeChanged FINAL)

    Q_PROPERTY(QString title READ title NOTIFY metaDataChanged FINAL)
    Q_PROPERTY(QString artist READ artist NOTIFY metaDataChanged FINAL)
    Q_PROPERTY(QString genre READ genre NOTIFY metaDataChanged FINAL)

public:
    explicit AudioPlayer(QObject *parent = nullptr);

    // Getters
    bool playing() const;
    qint64 position() const;
    qint64 duration() const;
    bool muted() const;
    qreal volume() const;

    QString title() const;
    QString artist() const;
    QString genre() const;

    // Setters
    void setPosition(qint64 pos);
    void setMuted(bool mute);
    void setVolume(qreal vol);

    // Invokable API for QML
    Q_INVOKABLE void setAudioSource(const QString &file);
    Q_INVOKABLE void togglePlayPause();
    Q_INVOKABLE void stop();
    Q_INVOKABLE void playPrevStation();
    Q_INVOKABLE void playNextStation();
    Q_INVOKABLE void setRadioSource(int index);

signals:
    void playingChanged();
    void positionChanged();
    void durationChanged();
    void mutedChanged();
    void volumeChanged();

    void metaDataChanged();

private:
    QMediaPlayer *m_mediaPlayer;
    QAudioOutput *m_audioOutput;

    QStringList m_radioNames;
    QStringList m_radioStations;
    int m_radioIndex;
};

#endif // AUDIOPLAYER_H
