#ifndef MYTYPE_H
#define MYTYPE_H

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QFileInfo>
#include <QRegularExpression>
#include <QDir>

class MyType : public QObject
{
    Q_OBJECT
    Q_PROPERTY( QString helloWorld READ helloWorld WRITE setHelloWorld NOTIFY helloWorldChanged )

public:
    explicit MyType(QObject *parent = 0);
    ~MyType();

    Q_INVOKABLE bool write(QString source, const QString& data);
    Q_INVOKABLE QString read(QString source);
    Q_INVOKABLE bool rename(QString source, const QString& fileName);
    Q_INVOKABLE bool remove(QString source);
    Q_INVOKABLE QString getFileName(QString source);
    Q_INVOKABLE QString getSuffix(QString source);
    Q_INVOKABLE QString getFullName(QString source);
    Q_INVOKABLE bool exists(QString source);
    Q_INVOKABLE bool isWritable(QString source);
    Q_INVOKABLE QStringList getLocalFileList(QString path);
    Q_INVOKABLE QString getHomePath();
//    Q_INVOKABLE void writeAsRoot(QString source, QString dest, QString password);


Q_SIGNALS:
    void helloWorldChanged();

protected:
    QString helloWorld() { return m_message; }
    void setHelloWorld(QString msg) { m_message = msg; Q_EMIT helloWorldChanged(); }

    QString m_message;
};

#endif // MYTYPE_H

