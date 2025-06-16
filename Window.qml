import QtQuick
import QtQuick.Controls

ApplicationWindow{
    id:winodw
    width:640
    height:480
    visible:true
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
    // footer:ToolBar{
    // }

    Actions{
        id:actions

    }

    Content{
        id:content
        anchors.fill:parent
    }
}
