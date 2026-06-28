cmake_minimum_required(VERSION 3.16)

set(PROJECT_NAME AppChrome)
set(QML_MODULE AppChromeModule)

project(${PROJECT_NAME} VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(PLATFORM_SOURCES)
set(PLATFORM_QML_FILES)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(${PROJECT_NAME}
    main.cpp
)

target_compile_definitions(${PROJECT_NAME} PRIVATE
    QML_MODULE="${QML_MODULE}"
)

if(WIN32)
    list(APPEND PLATFORM_SOURCES
        platform/ui/appmainwindow/windowsplatform/WindowsPlatform.h
        platform/ui/appmainwindow/windowsplatform/WindowsPlatform.cpp
        platform/ui/appmainwindow/windowsplatform/utils/WindowsUtils.h
        platform/ui/appmainwindow/windowsplatform/utils/WindowsUtils.cpp
    )

    list(APPEND PLATFORM_QML_FILES
        qml/appmainwindow/appcaption/windows/AppCaption.qml
    )

elseif(APPLE)
    list(APPEND PLATFORM_SOURCES
        platform/ui/appmainwindow/macplatform/MacPlatform.h
        platform/ui/appmainwindow/macplatform/MacPlatform.mm
        platform/ui/appmainwindow/macplatform/utils/MacUtils.h
        platform/ui/appmainwindow/macplatform/utils/MacUtils.cpp
    )

    list(APPEND PLATFORM_QML_FILES
        qml/appmainwindow/appcaption/mac/AppCaption.qml
    )

elseif(UNIX)
    list(APPEND PLATFORM_SOURCES
        platform/ui/appmainwindow/linuxplatform/LinuxPlatform.h
        platform/ui/appmainwindow/linuxplatform/LinuxPlatform.cpp
    )

    list(APPEND PLATFORM_QML_FILES
        qml/appmainwindow/appcaption/linux/AppCaption.qml
    )
endif()

qt_add_qml_module(${PROJECT_NAME}
    URI ${QML_MODULE}

    QML_FILES
        Main.qml

        qml/views/AppChrome.qml

        qml/appmainwindow/controls/buttons/CaptionButton.qml
        qml/appmainwindow/appcaption/BaseCaption.qml

        ${PLATFORM_QML_FILES}

    SOURCES
        application/Application.h

        platform/ui/appmainwindow/AppMainWindow.h

        platform/ui/appmainwindow/appcaption/AppCaption.h
        platform/ui/appmainwindow/appcaption/AppCaption.cpp

        platform/ui/appmainwindow/appwindowcontroller/AppWindowController.h
        platform/ui/appmainwindow/appwindowcontroller/AppWindowController.cpp

        ${PLATFORM_SOURCES}
)

target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/platform
    ${CMAKE_CURRENT_SOURCE_DIR}/platform/ui
    ${CMAKE_CURRENT_SOURCE_DIR}/platform/ui/appmainwindow
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE Qt6::Quick
)

install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)