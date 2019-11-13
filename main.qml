import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    color: "light gray"
    property var balance: 0

    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            balance += income_coefficient.coefficient
            balance_label.text = "You'r balance is " + Math.round(balance) + "$"
        }
    }

    ScrollView {
        anchors.fill: parent

        Column {
            spacing: 10

            Rectangle {
                id: info_bar
                width: root.width
                height: 50
                color: "steel blue"

                Text {
                    id: balance_label
                    anchors.centerIn: parent
                    text: qsTr("You don't have money yet!")
                    color: "white"
                }
            }

            Repeater {
                model: 4
                delegate: Rectangle {
                    width: root.width
                    height: 100
                    color: "steel blue"

                    Text {
                        id: fill_text
                        anchors.centerIn: parent
                        text: qsTr("Farm NN")
                        color: "white"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            balance += 1000
                            balance_label.text = "You'r balance is " + Math.round(balance) + "$"
                        }
                    }
                }
            }

            Rectangle {
                id: action_bar
                width: root.width
                height: 150
                color: "steel blue"

                Column {
                    spacing: 5

                    Button {
                        id: income_button
                        width: action_bar.width
                        text: "Get more money!"

                        onClicked: {
                            balance += income_coefficient.coefficient
                            balance_label.text = "You'r balance is " + Math.round(balance) + "$"
                        }
                    }

                    Slider {
                        id: income_coefficient
                        width: action_bar.width
                        value: 0

                        property var coefficient: 1

                        onValueChanged: coefficient = value > 0 ? value * 100 : 1
                    }

                }
            }
        }
    }
}
