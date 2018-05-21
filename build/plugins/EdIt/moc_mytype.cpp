/****************************************************************************
** Meta object code from reading C++ file 'mytype.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.4.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../plugins/EdIt/mytype.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mytype.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.4.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_MyType_t {
    QByteArrayData data[19];
    char stringdata[169];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_MyType_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_MyType_t qt_meta_stringdata_MyType = {
    {
QT_MOC_LITERAL(0, 0, 6), // "MyType"
QT_MOC_LITERAL(1, 7, 17), // "helloWorldChanged"
QT_MOC_LITERAL(2, 25, 0), // ""
QT_MOC_LITERAL(3, 26, 5), // "write"
QT_MOC_LITERAL(4, 32, 6), // "source"
QT_MOC_LITERAL(5, 39, 4), // "data"
QT_MOC_LITERAL(6, 44, 4), // "read"
QT_MOC_LITERAL(7, 49, 6), // "rename"
QT_MOC_LITERAL(8, 56, 8), // "fileName"
QT_MOC_LITERAL(9, 65, 6), // "remove"
QT_MOC_LITERAL(10, 72, 11), // "getFileName"
QT_MOC_LITERAL(11, 84, 9), // "getSuffix"
QT_MOC_LITERAL(12, 94, 11), // "getFullName"
QT_MOC_LITERAL(13, 106, 6), // "exists"
QT_MOC_LITERAL(14, 113, 10), // "isWritable"
QT_MOC_LITERAL(15, 124, 16), // "getLocalFileList"
QT_MOC_LITERAL(16, 141, 4), // "path"
QT_MOC_LITERAL(17, 146, 11), // "getHomePath"
QT_MOC_LITERAL(18, 158, 10) // "helloWorld"

    },
    "MyType\0helloWorldChanged\0\0write\0source\0"
    "data\0read\0rename\0fileName\0remove\0"
    "getFileName\0getSuffix\0getFullName\0"
    "exists\0isWritable\0getLocalFileList\0"
    "path\0getHomePath\0helloWorld"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_MyType[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
       1,  110, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   74,    2, 0x06 /* Public */,

 // methods: name, argc, parameters, tag, flags
       3,    2,   75,    2, 0x02 /* Public */,
       6,    1,   80,    2, 0x02 /* Public */,
       7,    2,   83,    2, 0x02 /* Public */,
       9,    1,   88,    2, 0x02 /* Public */,
      10,    1,   91,    2, 0x02 /* Public */,
      11,    1,   94,    2, 0x02 /* Public */,
      12,    1,   97,    2, 0x02 /* Public */,
      13,    1,  100,    2, 0x02 /* Public */,
      14,    1,  103,    2, 0x02 /* Public */,
      15,    1,  106,    2, 0x02 /* Public */,
      17,    0,  109,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Bool, QMetaType::QString, QMetaType::QString,    4,    5,
    QMetaType::QString, QMetaType::QString,    4,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString,    4,    8,
    QMetaType::Bool, QMetaType::QString,    4,
    QMetaType::QString, QMetaType::QString,    4,
    QMetaType::QString, QMetaType::QString,    4,
    QMetaType::QString, QMetaType::QString,    4,
    QMetaType::Bool, QMetaType::QString,    4,
    QMetaType::Bool, QMetaType::QString,    4,
    QMetaType::QStringList, QMetaType::QString,   16,
    QMetaType::QString,

 // properties: name, type, flags
      18, QMetaType::QString, 0x00495103,

 // properties: notify_signal_id
       0,

       0        // eod
};

void MyType::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        MyType *_t = static_cast<MyType *>(_o);
        switch (_id) {
        case 0: _t->helloWorldChanged(); break;
        case 1: { bool _r = _t->write((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 2: { QString _r = _t->read((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 3: { bool _r = _t->rename((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 4: { bool _r = _t->remove((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 5: { QString _r = _t->getFileName((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 6: { QString _r = _t->getSuffix((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 7: { QString _r = _t->getFullName((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 8: { bool _r = _t->exists((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 9: { bool _r = _t->isWritable((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 10: { QStringList _r = _t->getLocalFileList((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = _r; }  break;
        case 11: { QString _r = _t->getHomePath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (MyType::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MyType::helloWorldChanged)) {
                *result = 0;
            }
        }
    }
}

const QMetaObject MyType::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_MyType.data,
      qt_meta_data_MyType,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *MyType::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MyType::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_MyType.stringdata))
        return static_cast<void*>(const_cast< MyType*>(this));
    return QObject::qt_metacast(_clname);
}

int MyType::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 12)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 12;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 12)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 12;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = helloWorld(); break;
        default: break;
        }
        _id -= 1;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setHelloWorld(*reinterpret_cast< QString*>(_v)); break;
        default: break;
        }
        _id -= 1;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 1;
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        if (_id < 1)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 1;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void MyType::helloWorldChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, Q_NULLPTR);
}
QT_END_MOC_NAMESPACE
