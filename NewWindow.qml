import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
ApplicationWindow{
    property int chooseType
    signal completed(string deviceName,var captureObj)
    id:root
    visible: true
    width: 300;height:280
    title: qsTr("Create a source")
    Item {
        anchors.fill: parent
        //focus: true
        Keys.onReturnPressed: okButton.clicked()
    ColumnLayout{

        ColumnLayout{
            CheckBox{
                id:newButton
                enabled: checkBox.checked?false:true
                text: qsTr("New")
                }
            TextField{
                id:_edit
                enabled: newButton.enabled
                text:qsTr("New Device")
                Layout.fillWidth:true
                Layout.leftMargin:5
                Layout.rightMargin:5
                focus:true
                Component.onCompleted:  {
                           if (focus) {
                               _edit.selectAll();
                           }
                    //_edit.selectAll();
                       }
            }

        ColumnLayout{
            CheckBox{
                enabled: newButton.checked?false:true
                id:checkBox
                text:qsTr("add existing...")
            }
            Rectangle{
                implicitWidth:280
                implicitHeight:100
                Layout.leftMargin:5
                Layout.rightMargin:5
                Layout.fillWidth:true
                Layout.fillHeight:true
                color:"white"
                    }
            CheckBox{
                text:qsTr("make source visible")
            }

        }
        RowLayout{
            Layout.alignment: Qt.AlignRight
            Button{
                id:okButton
                text:qsTr("Ok")
                onClicked: {
                    switch(chooseType){
                    case 1:
                        loadScreenDevice.source="SetScreen.qml";
                        break;
                    case 2:
                        loadWindowDevice.source="SetWindow.qml"
                        break;
                    default:
                        completed(_edit.text,null)
                    }
                }
            }
            Button{
                  text:qsTr("Cancel")
                  onClicked: {
                  close();
                            }

                        }

        }

    }
    Loader{
        id:loadScreenDevice
        onLoaded:{
            item.screenSelected.connect(function(selectedScreen){
                completed(_edit.text,selectedScreen);
                close();
            });
            item.closing.connect(function() {
                                    loadScreenDevice.source = ""
                                })
        }
    }

    Loader{
        id:loadWindowDevice
        onLoaded: {
            item.windowSelected.connect(function(selectedWindow) {
                            completed(_edit.text, selectedWindow);
                            close();
                        });
            item.closing.connect(function() {
                                    loadWindowDevice.source = ""
                                })
        }
    }
}
}}

