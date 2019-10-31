QT      += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET  = mere-about
TEMPLATE= app

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        src/main.cpp \
        src/mereaboutapp.cpp \
        src/mereaboutwin.cpp

HEADERS += \
        src/mereaboutapp.h \
        src/mereaboutwin.h

RESOURCES += \
    res/about.qrc

#TRANSLATIONS += \
#    i18n/mere-about_bn.ts \
#    i18n/mere-about_en.ts

#DISTFILES += \
#    i18n/mere-about_bn.ts \
#    i18n/mere-about_en.ts
#    README.md

#
# Generate TS file
#
LANGUAGES = en bn
defineReplace(prependAll) {
    for(a, $$1): result += $$2$${a}$$3
    return($$result)
}
TRANSLATIONS = $$prependAll(LANGUAGES, i18n/mere-about_, .ts)
qtPrepareTool(LUPDATE, lupdate)
command = $$LUPDATE mere-about.pro
system($$command)|error("Failed to run: $$command")

#
# Generate QM file from TS file, and
# Copy to the resource bundle
#
TRANSLATIONS_FILES =
qtPrepareTool(LRELEASE, lrelease)
for(tsfile, TRANSLATIONS) {
    qmfile = $$tsfile
    qmfile ~= s,.ts,.qm

    command = $$LRELEASE -removeidentical $$tsfile -qm $$qmfile
    system($$command)|error("Failed to run: $$command")
    TRANSLATIONS_FILES += $$qmfile
}

#
# Install
#
unix{
    i18n.path = /usr/local/share/mere/about/i18n
    i18n.files = $$TRANSLATIONS_FILES
    INSTALLS += i18n

    target.path = /usr/local/bin
    INSTALLS += target
}


