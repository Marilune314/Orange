import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
ApplicationWindow{
    property int chooseType
    signal completed(string deviceName,var windowObj)
    id:root
    visible: true
    width: 300;height:280

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
                text:qsTr("Ok")
                onClicked: {
                    switch(chooseType){
                    case 1:
                        //待实现
                        // loaderScreenDevice.source="SetScreen.qml";
                        break;
                    case 2:
                        loaderWindowDevice.source="SetWindow.qml"
                        // console.log("load SetWidow.qml")
                        break;
                    default:
                        completed(_edit.text,null)
                    }
                }
            }
            Button{
                text:qsTr("Cancel")
                onClicked: {
                    root.visible=false;
                }
            }

        }

    }
    Loader{
        id:loaderScreenDevice
        onLoaded:{
            //
        }
    }

    Loader{
        id:loaderWindowDevice
        onLoaded: {
            item.windowSelected.connect(function(selectedWindow) {
                            completed(_edit.text, selectedWindow);
                            close();
                        })
        }
    }

}
