import QtQuick
import QtQuick.Controls

Item {
    property alias show:_show
    property alias about:_about
    property alias add:_add
    property alias displayCapture:_displayCapture
    property alias windowCapture:_windowCapture
    property alias audioInputCapture:_audioInputCapture
    property alias audioOutputCapture:_audioOutputCapture

    Action{
        id:_show
        icon.name: "multimedia-playback-play"
        text:"Play(existing files)"
    }
    Action{
        id:_about
        icon.name:"help-about"
        text:"About"
    }
    Action{
        id:_add
        icon.name:"document-open"
        text:"add"
        onTriggered:contextMenu.popup()
    }
    Menu{
           id: contextMenu
           MenuItem { action:_displayCapture }
           MenuItem { action:_windowCapture}
           MenuItem { action:_audioInputCapture }
           MenuItem { action:_audioOutputCapture}
    }
    Action{
        id:_displayCapture
        text:"Display Capture"
    }
    Action{
        id:_windowCapture
        text:"Window Capture"
    }
    Action{
        id:_audioInputCapture
        text:"Audio Input Capture"
    }
    Action{
        id:_audioOutputCapture
        text:"Audio Output Capture"
    }

}
