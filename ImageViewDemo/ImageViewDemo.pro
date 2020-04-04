QT += quick

CONFIG += c++11

TARGET  = ImageViewDemo

DESTDIR = $$PWD/bin

SOURCES += \
        KImageView.cpp \
        KInterface.cpp \
        KManager.cpp \
        main.cpp

RESOURCES += qml.qrc

HEADERS += \
    KImageView.h \
    KInterface.h \
    KManager.h
