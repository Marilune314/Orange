import QtQuick
import QtQuick.Controls

ApplicationWindow{
    property bool recording: false
    property int elapsedSeconds: 0
    property string timeString: "00:00:00"
    property bool showFooterMessage: false
    id:winodw    
    width:640
    height:480
    visible:true
    title:qsTr("Orange")
    menuBar:MenuBar{
        Menu{
            id:file
            title:qsTr("File")
            MenuItem{action:actions.show}
        }
        Menu{
            id:help
            title:qsTr("Help")
            MenuItem{action:actions.about}
        }
    }
    footer:ToolBar{
        Text{
            id:hintText
            visible: pathText.visible
            anchors.left: parent.left;
            text:"Click to Play: "
            color:Qt.styleHints.colorScheme === Qt.Light ? "black" : "white"

        }

        Text {
            id:pathText
            visible: showFooterMessage
            anchors.left:hintText.right
            text: content.path.toString().replace("file://","")
            font.underline: true
            color: "blue"
            TapHandler{
                onTapped:{
                    content.localPlayer.startPlay("ffplay",pathText.text);
                }
            }
        }

        Timer {
            id:showpathtimer
            running: showFooterMessage
            interval: 10000
            repeat: false
            onTriggered: showFooterMessage = false
        }
        Timer {
               id: recordTimer
               interval: 1000
               repeat: true
               onTriggered: {
                   elapsedSeconds += 1
                   var h = Math.floor(elapsedSeconds / 3600)
                   var m = Math.floor((elapsedSeconds % 3600) / 60)
                   var s = elapsedSeconds % 60
                    timeString =
                           String(h).padStart(2, "0") + ":" +
                           String(m).padStart(2, "0") + ":" +
                           String(s).padStart(2, "0");
               }
           }
        Text {
                text: recording ? "Recording:" + timeString : "Ready"
                color:"grey"
                font.pixelSize: 18
                anchors.right:parent.right
               }
    }

    Actions{
        id:actions
        about.onTriggered: {
            content.dialogs.aboutDialog.open()
        }
        show.onTriggered: {
            content.dialogs.openDialog.open()
        }

    }

    Content{
        id:content
        anchors.fill:parent
        toolButtonListView.startButton.onClicked:{
            if (content.tryStartRecording()) {
                recording = true;
                elapsedSeconds = 0;
                recordTimer.start();
            }
            showFooterMessage=false

        }
        toolButtonListView.stopButton.onClicked: {
            showFooterMessage=true
            recording = false
            recordTimer.stop()
        }
        dialogs.openDialog.onAccepted: {
            var path=content.dialogs.openDialog.selectedFile.toString().replace("file://","");
            console.log(path);
            localPlayer.startPlay("ffplay",path)
        }

    }


}
