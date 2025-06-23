import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout{
    property alias startButton:_start
    property alias stopButton:_stop
    property alias resumeButton:_resume
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
        // enabled: false
        Layout.fillWidth:true
        Layout.fillHeight:true
        text:"Pause Recording"
    }
    Button{
        id:_resume
        Layout.fillWidth:true
        Layout.fillHeight:true
        text:"Resume"
    }

    Button{
        id:_stop
        Layout.fillWidth:true
        Layout.fillHeight:true
        text:"Stop Recording"
    }


}
