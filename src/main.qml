import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts

Window {
    width: 340
    height: 230
    visible: true
    title: qsTr("LinkTree")

    AboutWindow {
        id: aboutWindow
    }

    Dialog {
        id: fullLicensePrompt
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: "External link opened"
        modal: true
        closePolicy: Popup.CloseOnEscape
        property string lgpl3LicenseUrl: "https://www.gnu.org/licenses/lgpl-3.0.html"

        GridLayout {
            rowSpacing: 20

            Text {
                GridLayout.alignment: Qt.AlignCenter
                text: "An external link to full LGPLv3 license is about to be opened."
            }
            Text {
                GridLayout.row: 1
                GridLayout.alignment: Qt.AlignCenter
                text: "Proceed?"
            }
        }

        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: Qt.openUrlExternally(lgpl3LicenseUrl)
    }

    GridLayout {
        anchors.fill: parent
        rowSpacing: 10
        columns: 5
        rows: 5

        MenuBar {
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            Layout.columnSpan: parent.columns
            Menu {
                title: "File"
                MenuItem {
                    text: "Exit"
                    onTriggered: Qt.quit();
                }
            }
            Menu {
                title: "Help"
                MenuItem {
                    text: "Full license"
                    onTriggered: fullLicensePrompt.open()
                }

                MenuItem {
                    text: "About"
                    onTriggered: aboutWindow.show()
                }
            }
        }

        ColumnLayout {
            Layout.row: 1
            Layout.column: 2
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter

            Image {
                id: avatar
                source: "img/avatar"
                Layout.preferredHeight: 120
                Layout.preferredWidth: 120
            }

            Text {
                text: config.name
                font.pointSize: 12
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }
        }

        RowLayout {
            id: linkRow
            Layout.row: 2
            Layout.column: 2
            Layout.columnSpan: 1
            Layout.alignment: Qt.AlignHCenter
            spacing: 15

            function toolTipEvent(element, text)
            {
                if (element.hoverEnabled)
                {
                    ToolTip.show(text, 2000);
                }
            }

            Image {
                id: github_image
                source: "img/github-mark"
                Layout.preferredHeight: 32
                Layout.preferredWidth: 32

                MouseArea {
                    property string url: config.githubUrl
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: Qt.openUrlExternally(url)
                    cursorShape: Qt.PointingHandCursor
                    onHoveredChanged: linkRow.toolTipEvent(this, url)
                }
            }

            Image {
                id: linkedin_logo
                source: "img/linkedin_logo"
                Layout.preferredHeight: 32
                Layout.preferredWidth: 32

                MouseArea {
                    property string url: config.linkedinUrl
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: Qt.openUrlExternally(url)
                    cursorShape: Qt.PointingHandCursor
                    onHoveredChanged: linkRow.toolTipEvent(this, url)
                }
            }

            Image {
                id: email_icon
                source: "img/email_icon"
                Layout.preferredHeight: 32
                Layout.preferredWidth: 32

                MouseArea {
                    property string url: "mailto:" + config.email
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: Qt.openUrlExternally(url)
                    cursorShape: Qt.PointingHandCursor
                    onHoveredChanged: linkRow.toolTipEvent(this, url)
                }
            }
        }
    }
}
