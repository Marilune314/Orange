cmake_minimum_required(VERSION 3.30)

project(Orange VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Multimedia Gui)

qt_standard_project_setup(REQUIRES 6.9)

qt_add_executable(appOrange)

qt_add_qml_module(appOrange
    URI Orange
    VERSION 1.0
    SOURCES     main.cpp
    QML_FILES   Window.qml
    QML_FILES Actions.qml
    QML_FILES Content.qml
    QML_FILES Player.qml
    QML_FILES SourcesListView.qml
    QML_FILES SetWindow.qml
    QML_FILES ToolButtonListView.qml WindowListView.qml
    SOURCES windowlistmodel.h windowlistmodel.cpp
    QML_FILES NewWindow.qml
    SOURCES screenlistmodel.h screenlistmodel.cpp
    QML_FILES ScreenListView.qml
    QML_FILES SetScreen.qml
    QML_FILES Controller.js
    QML_FILES Dialogs.qml
    SOURCES localplayer.h localplayer.cpp
    SOURCES filehelper.h filehelper.cpp
    SOURCES recorder.h recorder.cpp
    RESOURCES windowId.txt
)

target_compile_features(appOrange PRIVATE cxx_std_23)

target_link_libraries(appOrange
    PRIVATE
        Qt6::Quick
        Qt6::Multimedia
        Qt6::Gui
)

set_target_properties(appOrange PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appOrange
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS appOrange
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)


















































# set(CMAKE_CXX_STANDARD_REQUIRED ON) # Globally preventing the fallback behaviour of C++ standard
#qt_add_executable(Orange)  //Creates and finalizes an application target of a platform-specific type.
#This command performs the following tasks:
#    1. Create a CMake target of the appropriate type for the target platform.
#    2. Link the target to the Qt::Core library.
#    3. Handle finalization of the CMake target.

# set(CMAKE_CXX_STANDARD_REQUIRED ON) # Globally preventing the fallback behaviour of C++ standard

# qt_standard_project_setup()  #set(CMAKE_AUTOUIC ON)  set(CMAKE_AUTOMOC ON)






# cmake_minimum_required(VERSION 3.16)
#
# project(Orange VERSION 0.1 LANGUAGES CXX)
#
# @if !true
# set(CMAKE_AUTOMOC ON)
# @endif
# set(CMAKE_CXX_STANDARD_REQUIRED ON)
#
# find_package(Qt6 REQUIRED COMPONENTS Quick)
#
# @if true
# @if true
# qt_standard_project_setup(REQUIRES 6.9)
# @else
# qt_standard_project_setup()
# @endif
# @endif
#
# qt_add_executable(appOrange
#     main.cpp
# )
#
# qt_add_qml_module(appOrange
#     URI Orange
#     VERSION 1.0
#     QML_FILES
#         Main.qml
# )
#
# # Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# # If you are developing for iOS or macOS you should consider setting an
# # explicit, fixed bundle identifier manually though.
# set_target_properties(appOrange PROPERTIES
# #    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appOrange
#     MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
#     MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
#     MACOSX_BUNDLE TRUE
#     WIN32_EXECUTABLE TRUE
# )
#
# target_link_libraries(appOrange
#     PRIVATE Qt6::Quick
# )
#
# include(GNUInstallDirs)
# install(TARGETS appOrange
#     BUNDLE DESTINATION .
#     LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#     RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
# )
