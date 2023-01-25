import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import QtQuick.Dialogs

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


        Text {
            text: "An external link to LGPL license is about to be opened. Proceed?"
        }

        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: Qt.openUrlExternally("https://www.gnu.org/licenses/lgpl-3.0.html")
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
