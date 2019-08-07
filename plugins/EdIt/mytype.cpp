#include "mytype.h"

MyType::MyType(QObject *parent) :
    QObject(parent),
    m_message("")
{

}

MyType::~MyType() {

}

/* write provided content to a new file or exisitng one */
bool MyType::write(QString source, const QString &data)
{
  if (source.isEmpty())
      return false;

    if(source.startsWith("file://"))
      source.remove("file://");

    QDir dir = QFileInfo(source).absoluteDir();
    if(!dir.exists())
        dir.mkdir(dir.absolutePath());

    QFile file(source);
    if (!file.open(QFile::ReadWrite))
        return false;

    QTextStream out(&file);
    out << data;
    file.close();
    return true;
}

QString MyType::read(QString source)
{
    if (source.isEmpty())
        return "";

    if(source.startsWith("file://"))
        source.remove("file://");

    QFile file(source);
    if (!file.open(QFile::ReadOnly | QFile::Truncate))
        return "";

    QString data = file.readAll();
    return data;
}

/* Return the size of the file in bytes */
qint64 MyType::getSize(QString source)
{
  if (source.isEmpty())
      return 0;

  if(source.startsWith("file://"))
      source.remove("file://");

  QFileInfo fi(source);
  if(fi.exists())
  {
      return fi.size();
  }else {
    return 0;
  }
}

/* Return the creation time of the file */
QDateTime  MyType::getFileLastModified(QString source){

  if(source.startsWith("file://"))
      source.remove("file://");

      QFileInfo fi(source);

      return fi.lastModified();  
}


bool MyType::rename(QString source, const QString &fileName)
{
    if (source.isEmpty())
        return false;

    if(source.startsWith("file://"))
        source.remove("file://");

    QFile file(source);
    return file.rename(fileName);
}

bool MyType::remove(QString source)
{
    if (source.isEmpty())
        return false;

    if(source.startsWith("file://"))
        source.remove("file://");

    QFile file(source);
    return file.remove();
}

QString MyType::getFileName(QString source)
{
    if (source.isEmpty())
        return "";

    if(source.startsWith("file://"))
        source.remove("file://");

    QFileInfo fi(source);
    QString name = fi.completeBaseName();
    QRegularExpression rx("\((\\d+)\)");
    QRegularExpressionMatch match = rx.match(name);
    if(match.hasMatch())
        name.remove(match.capturedStart(0)-1,match.capturedLength(0)+2);
    return name;

}

QString MyType::getSuffix(QString source)
{
    if (source.isEmpty())
        return "";

    if(source.startsWith("file://"))
        source.remove("file://");

    QFileInfo fi(source);
    return fi.suffix();
}

QString MyType::getFullName(QString source)
{
    if (source.isEmpty())
        return "";

    if(source.startsWith("file://"))
        source.remove("file://");

    QFileInfo fi(source);
    return fi.fileName();
}

bool MyType::exists(QString source)
{
    if (source.isEmpty())
        return false;

    if(source.startsWith("file://"))
        source.remove("file://");

    QFileInfo fi(source);
    return fi.exists();
}

bool MyType::isWritable(QString source)
{
    if (source.isEmpty())
        return false;

    if(source.startsWith("file://"))
        source.remove("file://");

    QFileInfo fi(source);
    return fi.isWritable();
}

QStringList MyType::getLocalFileList(QString path)
{
    QStringList list;

    if (path.isEmpty())
        return list;

    if(path.startsWith("file://"))
        path.remove("file://");

    QDir dir(path);
    list = dir.entryList(QDir::Files);

    return list;
}

QString MyType::getHomePath()
{
    return QDir::homePath();
}

//void MyType::writeAsRoot(QString source, QString dest, QString password)
//{
//    if(source.startsWith("file://"))
//        source.remove("file://");

//    if(dest.startsWith("file://"))
//        dest.remove("file://");

//    system(QString("echo " + password + " | sudo -S mv " + source + " " + dest).toStdString().c_str());
//}
