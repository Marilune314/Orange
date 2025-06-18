import QtQuick
import QtQuick.Dialogs
import QtCore
Item{
    property alias aboutDialog:_aboutDialog
    property alias checkSourceDialog:_checkSourceDialog
    property alias openDialog :_openDialog
    FileDialog{
        id:_openDialog
        currentFolder:StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
        fileMode: FileDialog.OpenFile
        nameFilters:[("Video files (*.srt *.mkv *.avi *mp4)")]
    }
    MessageDialog{
        id:_aboutDialog
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"This is a simple screen recorder."
        informativeText: qsTr("Orange is a free software, and you can download its source code from www.open-src.com")
        detailedText: "Copyright©2025 HuJunxin WangXinru YangJiayi"
    }
    MessageDialog{
        id:_checkSourceDialog
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"It looks like you haven't added any video sources yet, so you will only be outputting a blank screen. Are you sure you want to do this?"
        informativeText: qsTr("You can add sources by clicking the + icon under the Sources box in the main window at any time.")
    }

}
