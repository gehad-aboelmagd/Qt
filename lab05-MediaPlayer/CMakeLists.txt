cmake_minimum_required(VERSION 3.16)
set(CMAKE_AUTORCC ON)
project(MediaPlayer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Multimedia)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appMediaPlayer
    main.cpp
)

qt_add_qml_module(appMediaPlayer
    URI MediaPlayer
    QML_FILES
        Main.qml
        RESOURCES
        RESOURCES
        RESOURCES
        RESOURCES
        RESOURCES resources.qrc
        SOURCES audioplayer.h audioplayer.cpp
        RESOURCES
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appMediaPlayer PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appMediaPlayer
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appMediaPlayer
    PRIVATE Qt6::Quick Qt6::Multimedia
)

include(GNUInstallDirs)
install(TARGETS appMediaPlayer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
