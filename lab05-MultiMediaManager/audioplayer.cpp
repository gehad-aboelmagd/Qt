// #include "audioplayer.h"

// AudioPlayer::AudioPlayer(QObject *parent)
//     : QObject{parent}
// {
//     m_mediaPlayer = new QMediaPlayer(this);
//     m_audioOutput = new QAudioOutput(this);
//     m_mediaPlayer->setAudioOutput(m_audioOutput);

//     connect(m_mediaPlayer, &QMediaPlayer::playingChanged, this, &AudioPlayer::playingChanged);
//     connect(m_mediaPlayer, &QMediaPlayer::positionChanged, this, &AudioPlayer::positionChanged);
//     connect(m_mediaPlayer, &QMediaPlayer::playingChanged, this, &AudioPlayer::playingChanged);
//     connect(m_mediaPlayer, &QMediaPlayer::positionChanged, this, &AudioPlayer::positionChanged);

// }

// bool AudioPlayer::getPlayingState()
// {
//     // return m_mediaPlayer->isPlaying;
// }

// qint64 AudioPlayer::getDuration()
// {

// }

#include "audioplayer.h"
#include <QDebug>
#include <QUrl>

AudioPlayer::AudioPlayer(QObject *parent)
    : QObject(parent)
{
    m_mediaPlayer = new QMediaPlayer(this);
    m_audioOutput = new QAudioOutput(this);

    m_mediaPlayer->setAudioOutput(m_audioOutput);

    // Proper signal forwarding
    connect(m_mediaPlayer, &QMediaPlayer::playbackStateChanged,
            this, &AudioPlayer::playingChanged);

    connect(m_mediaPlayer, &QMediaPlayer::positionChanged,
            this, &AudioPlayer::positionChanged);

    connect(m_mediaPlayer, &QMediaPlayer::durationChanged,
            this, &AudioPlayer::durationChanged);

    connect(m_audioOutput, &QAudioOutput::volumeChanged,
            this, &AudioPlayer::volumeChanged);

    connect(m_audioOutput, &QAudioOutput::mutedChanged,
            this, &AudioPlayer::mutedChanged);

    connect(m_mediaPlayer, &QMediaPlayer::metaDataChanged,
            this, &AudioPlayer::metaDataChanged);

    m_radioNames = {
        "Quran Cairo", "Quran Makkah", "Quran Madinah"
    };

    m_radioStations = {
        "https://stream.radiojar.com/8s5u5tpdtwzuv",
        "http://live.mp3quran.net:8008/;",
        "http://live.mp3quran.net:8002/;"
    };

    m_radioIndex = 0;
}

// ================= GETTERS =================

bool AudioPlayer::playing() const
{
    return m_mediaPlayer->playbackState() == QMediaPlayer::PlayingState;
}

qint64 AudioPlayer::position() const
{
    return m_mediaPlayer->position();
}

qint64 AudioPlayer::duration() const
{
    return m_mediaPlayer->duration();
}

bool AudioPlayer::muted() const
{
    return m_audioOutput->isMuted();
}

qreal AudioPlayer::volume() const
{
    return m_audioOutput->volume();
}

QString AudioPlayer::title() const
{
    return m_mediaPlayer->metaData().stringValue(QMediaMetaData::Title);
}

QString AudioPlayer::artist() const
{
    return m_mediaPlayer->metaData().stringValue(QMediaMetaData::ContributingArtist);
}

QString AudioPlayer::genre() const
{
    return m_mediaPlayer->metaData().stringValue(QMediaMetaData::Genre);
}

// ================= SETTERS =================

void AudioPlayer::setPosition(qint64 pos)
{
    m_mediaPlayer->setPosition(pos);
}

void AudioPlayer::setMuted(bool mute)
{
    m_audioOutput->setMuted(mute);
}

void AudioPlayer::setVolume(qreal vol)
{
    m_audioOutput->setVolume(vol);
}

// ================= API =================

void AudioPlayer::setAudioSource(const QString &file)
{
    m_mediaPlayer->setSource(QUrl::fromLocalFile(file));
}

void AudioPlayer::togglePlayPause()
{
    if (m_mediaPlayer->playbackState() == QMediaPlayer::PlayingState)
        m_mediaPlayer->pause();
    else
        m_mediaPlayer->play();
}

void AudioPlayer::stop()
{
    m_mediaPlayer->stop();
}

void AudioPlayer::playPrevStation()
{
    m_radioIndex = (m_radioIndex - 1 + m_radioStations.size()) % m_radioStations.size();
    m_mediaPlayer->setSource(m_radioStations[m_radioIndex]);
    m_mediaPlayer->play();
    qDebug() << m_radioIndex;

}

void AudioPlayer::playNextStation()
{
    m_radioIndex = (m_radioIndex + 1) % m_radioStations.size();
    m_mediaPlayer->setSource(m_radioStations[m_radioIndex]);
    m_mediaPlayer->play();
    qDebug() << m_radioIndex;
}

void AudioPlayer::setRadioSource(int index)
{
    m_radioIndex = index;
    m_mediaPlayer->setSource(m_radioStations[m_radioIndex]);
    m_mediaPlayer->play();
    qDebug() << m_radioIndex;

}
