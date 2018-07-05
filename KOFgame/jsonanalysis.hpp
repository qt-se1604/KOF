#ifndef JSONANALYSIS_HPP
#define JSONANALYSIS_HPP

#include <QObject>
#include <QByteArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QVariant>
#include <QDebug>

class JsonAnalysis : public QObject {
    Q_OBJECT

public:
    JsonAnalysis() {}

    template<typename ValueType>
    QByteArray makeJson(QString key, ValueType value)
    {
        QJsonObject json;
        json.insert(key, value);

        QJsonDocument document;
        document.setObject(json);
        return document.toJson(QJsonDocument::Compact);
    }

    void jsonAnalyze(QByteArray jsonMessage)
    {
        QJsonParseError jsonError;
        QJsonDocument document = QJsonDocument::fromJson(jsonMessage, &jsonError);
        if(!document.isNull() && (jsonError.error == QJsonParseError::NoError))
        {
            if(document.isObject())
            {
                QJsonObject object = document.object();
                if(object.contains("x"))
                {
                    QJsonValue value = object.value("x");
                    if(value.isDouble())
                    {
                        double x = value.toVariant().toDouble();
                        emit xChanged(x);
                    }
                }
                if(object.contains("y"))
                {
                    QJsonValue value = object.value("y");
                    if(value.isDouble())
                    {
                        double y = value.toVariant().toDouble();
                        emit yChanged(y);
                    }
                }
                if(object.contains("fire"))
                {
                    QJsonValue value = object.value("fire");
                    if(value.isBool())
                    {
                        bool fire = value.toVariant().toBool();
                        emit fireChanged(fire);
                    }
                }
                if(object.contains("time"))
                {
                    QJsonValue value = object.value("time");
                    if(value.isDouble())
                    {
                        double time = value.toVariant().toInt();
                        emit timeChanged(time);
                    }
                }
                if(object.contains("music"))
                {
                    QJsonValue value = object.value("music");
                    if(value.isDouble())
                    {
                        double music = value.toVariant().toInt();
                        emit musicChanged(music);
                    }
                }
                if(object.contains("background"))
                {
                    QJsonValue value = object.value("background");
                    if(value.isDouble())
                    {
                        double background = value.toVariant().toInt();
                        emit backgroundChanged(background);
                    }
                }
                if(object.contains("findgame"))
                {
                    QJsonValue value = object.value("findgame");
                    if(value.isBool())
                    {
                        bool findgame = value.toVariant().toBool();
                        emit findgameChanged(findgame);
                    }
                }
                if(object.contains("jump"))
                {
                    QJsonValue value = object.value("jump");
                    if(value.isBool())
                    {
                        bool jump = value.toVariant().toBool();
                        emit jumpChanged(jump);
                    }
                }
				if(object.contains("quitRoom"))
				{
					QJsonValue value = object.value("quitRoom");
					if(value.isBool())
					{
						bool quitRoom = value.toVariant().toBool();
						emit quitRoomChanged(quitRoom);
					}
				}
                if(object.contains("attack"))
                {
                    QJsonValue value = object.value("attack");
                    if(value.isBool())
                    {
                        bool attack = value.toVariant().toBool();
                        emit closeattackChanged(attack);
                    }
                }
            }
        }
    }

signals:
    void xChanged(double x);
    void yChanged(double y);
    void fireChanged(bool isFire);
    void timeChanged(double time);
    void musicChanged(double music);
    void backgroundChanged(double background);
    void findgameChanged(bool findgame);
    void jumpChanged(bool jump);
	void quitRoomChanged(bool isQuitRoom);
    void closeattackChanged(bool isattack);
};

#endif // JSONANALYSIS_HPP
