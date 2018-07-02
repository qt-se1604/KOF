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
            }
        }
    }

signals:
    void xChanged(double x);
    void yChanged(double y);
    void fireChanged(bool isFire);

};

#endif // JSONANALYSIS_HPP
