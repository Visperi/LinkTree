import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts

Window {
    width: 350
    height: 280
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

    MenuBar {
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
}
