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
    property var farmCount: 2

    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            for(var i = 0; i < farmCount-1; i++) {
                balance += farm_list.get(i).coefficient;
            }
            balance_label.text = "You'r balance is " + Math.round(balance) + "$"
        }
    }

    ListModel {
        id: farm_list
        ListElement{name: "Farm 1"; coefficient: 1}
    }

    Rectangle {
        id: main_container
        anchors.fill: parent

        Rectangle {
            z: 2
            id: info_bar
            width: parent.width
            anchors.top: parent.top
            height: 50
            color: "#3370b9"

            Text {
                id: balance_label
                anchors.centerIn: parent
                text: qsTr("You don't have money yet!")
                font.family: "Liberation Serif"
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 20
                color: "white"
            }
        }

        Rectangle {
                id: farm_field
                anchors.top: info_bar.bottom
                anchors.bottom: new_farm.top
                width: parent.width
                color: "light gray"

                ScrollView {
                    anchors.fill: parent

                    ListView {
                        id: list
                        spacing: 3
                        model: farm_list//3
                        delegate: Rectangle {
                            width: parent.width
                            height: 100
                            color: "steel blue"

                            Text {
                                anchors.fill: parent
                                color: "#ffffff"
                                text: qsTr(name + "\n\nCoefficient: " + coefficient)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 16
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    balance += Math.pow(10, index)
                                    balance_label.text = "You'r balance is " + Math.round(balance) + "$"
                                }
                            }
                        }
                    }
                }
            }

        Rectangle {
            id: new_farm
            anchors.bottom: parent.bottom
            width: parent.width
            height: 150
            color: "#3370b9"

            Text {
                anchors.fill: parent
                color: "#ffffff"
                text: qsTr("Build new farm")
                font.pointSize: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    farm_list.append({"name":"Farm " + farmCount, "coefficient": Math.pow(10, farmCount-1)})
                    farmCount++
                }
            }
        }

    }
}
