TEMPLATE = app

QT += qml quick
CONFIG += c++11


win32{
    CONFIG += debug_and_release
    CONFIG(release, debug|release) {
            DIR_COMPILEMODE = Debug
            target_path = build_/release
            TARGET  = /release/QMLBaseCompoments
        } else {
            DIR_COMPILEMODE = Release
            target_path = build_/debug
            TARGET  = /debug/QMLBaseCompoments
        }
        DESTDIR = $$PWD/Bin
        MOC_DIR = $$target_path/moc
        RCC_DIR = $$target_path/rcc
        UI_DIR  = $$target_path/ui
        OBJECTS_DIR = $$target_path/obj
}

DEPENDPATH += $$PWD/Bin

SOURCES += main.cpp

#RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)


