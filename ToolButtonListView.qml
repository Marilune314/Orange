import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout{
    property alias startButton:_start
    property alias stopButton:_stop
    property alias exitButton:_exit
    property alias pauseButton:_pause

    Label{
        text:"Controls"
        Layout.alignment: Qt.AlignTop
    }
    Button{
        id:_start
        Layout.fillWidth:true
        Layout.fillHeight:true
        text:"Start Recording"
    }
    Button{
        id:_pause
        Layout.fillWidth:true
        Layout.fillHeight:true
        text:"Pause Recording"
    }

    Button{
        id:_stop
        Layout.fillWidth:true
        Layout.fillHeight:true
        text:"Stop Recording"
    }
    Button{
        id:_exit
        Layout.fillWidth:true
        Layout.fillHeight:true
        text:"Exit"
        onClicked: Qt.exit(0)
    }
}
