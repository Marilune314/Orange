// Written by WXR HJX YJY
// date 2025-7-9
// window.qml of the Screen Recorder application
import QtQuick
import QtQuick.Controls

ApplicationWindow{
    property bool recording: false
    property int elapsedSeconds: 0
    property string timeString: "00:00:00"
    property bool showFooterMessage: false
    property string outputFormat: "mp4"
    property string userMaxVideoSize: ""
    property string selected: ""
    Component.onCompleted: {
        userMaxVideoSize=content.recorder.getVideoSize()
       // recorder.setVideoSize(selected)
        selected = userMaxVideoSize
        content.recorder.setVideoSize(selected)
    }

    property var allViedioSizes: [
        "3840x2160",
        "2560x1600",
        "2560x1440",
        "2048x1536",
        "2048x1152",
        "1920x1440",
        "1920x1200",
        "1920x1080",
        "1680x1050",
        "1600x1200",
        "1600x900",
        "1440x810",
        "1400x1050",
        "1400x900",
        "1368x768",
        "1280x1024",
        "1280x960",
        "1280x800",
        "1280x720",
        "1024x768",
        "1024x576",
        "960x720",
        "960x600",
        "800x600",
        "640x360"
    ]
    property var videoSizeList: {
        var idx = allViedioSizes.indexOf(userMaxVideoSize);
        if (idx === -1) return [];

        var end = Math.min(idx + 3, allViedioSizes.length);
        return allViedioSizes.slice(idx, end);
    }
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
            MenuItem{action:actions.exit}
        }
        Menu{
            id:settings
            title:qsTr("Settings")
            Menu{
                id:videoSize
                title:qsTr("Select Video-size")
                Instantiator{
                    model:videoSizeList
                    delegate:MenuItem{
                        text: modelData
                                   onTriggered: {
                                       console.log("set videoSize:", modelData)
                                       selected = modelData
                                       content.recorder.setVideoSize(selected)

                                   }
                               }
                               onObjectAdded: (index, item) => videoSize.insertItem(index, item)
                               onObjectRemoved: (index, item) => videoSize.removeItem(item)
                           }
                       }
            Menu{
                id:outputType
                title: qsTr("type")
                    MenuItem {
                        id:mp4
                        text: "MP4/H.264 - Video "
                        checkable: true
                        checked:gif.checked?false:true
                        onToggled: {
                            if (checked)
                                winodw.outputFormat = "mp4"
                            //console.log("MP4/H.264 - Video :", checked)
                     }
                    }
                    MenuItem {
                        id:gif
                        text: "GIF - Animated image "
                        checkable: true
                        checked: mp4.checked?false:true
                        onToggled: {
                            //console.log("GIF - Animated image :", checked)
                            if(checked)
                                winodw.outputFormat="gif"
                         }
            }
        }

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
        toolButtonListView.pauseButton.onClicked: {
            recordTimer.stop()
        }
        toolButtonListView.resumeButton.onClicked: {
            recordTimer.start()
        }

        dialogs.openDialog.onAccepted: {
            var path=content.dialogs.openDialog.selectedFile.toString().replace("file://","");
            console.log(path);
            localPlayer.startPlay("ffplay",path)
        }

    }


}
