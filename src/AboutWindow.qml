import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls

Window {
    id: aboutDialog
    title: "About"
    flags: Qt.Dialog
    height: aboutDialogGrid.implicitHeight
    width: aboutDialogGrid.implicitWidth
    minimumHeight: height
    minimumWidth: width
    maximumHeight: height
    maximumWidth: width
    modality: Qt.WindowModal

    GridLayout {
        id: aboutDialogGrid
        columnSpacing: 10
        rowSpacing: 10

        TextArea {
            GridLayout.row: 0
            GridLayout.column: 0
            Layout.alignment: Qt.AlignCenter
            readOnly: true
            text: "LinkTree 1.0"
        }

        TextArea {
            GridLayout.row: 1
            GridLayout.column: 0
            Layout.alignment: Qt.AlignHCenter
            readOnly: true
            text: "Copyright (C) 2023 Niko Mätäsaho\nThis program is licensed under LGPLv3"
        }
        TextArea {
            Text {
                id: repoHyperlink
                property string url: "https://github.com/Visperi/GithubBrowser"
                property string hyperlink: "GitHub"
                text: "<a href=" + url + ">" + hyperlink  + "</a>"
                visible: false
            }

            GridLayout.row: 2
            GridLayout.column: 0
            Layout.alignment: Qt.AlignCenter
            textFormat: Qt.RichText
            readOnly: true
            text: "Repository for this program can be found from " + repoHyperlink.text
            onHoveredLinkChanged: if (hoveredLink)
                                  {
                                      ToolTip.show(repoHyperlink.url, 2000);
                                  }

            MouseArea {
                anchors.fill: parent
                cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                onClicked: if (parent.hoveredLink)
                           {
                               Qt.openUrlExternally(repoHyperlink.url);
                           }
            }
        }
    }
}
