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
    property var farm_count: 2

    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            for(var i = 0; i < farm_count-1; i++) {
                balance += farm_list.get(i).coefficient;
            }

            balance_label.text = "You'r balance is " + Math.round(balance) + "$"
        }
    }

    ListModel {
        id: farm_list
        ListElement{farm_id: 0; name: "Farm 1"; coefficient: 1; max_level: 10; level: 1; lvlup_cost: 10}
    }

    Rectangle {
        id: main_container
        anchors.fill: parent

        Rectangle {
            z: 100
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
                        spacing: 10
                        model: farm_list
                        delegate: Rectangle {
                            width: parent.width
                            height: width / 10 * 3 + 35
                            color: "steel blue"

                            Text {
                                anchors.fill: parent
                                color: "#ffffff"
                                text: qsTr(name + "\n\nCoefficient: " + coefficient + "\nLevel: " + level)
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

                            Row {
                                anchors.fill: parent
                                anchors.centerIn: parent
                                spacing: 5

                                Column {
                                    width: parent.width/5
                                    height: parent.height
                                    spacing: 5
                                    padding: 5

                                    Button {
                                        text: qsTr("Level up for " + farm_list.get(index).lvlup_cost)

                                        onClicked: {
                                            if(balance > farm_list.get(index).lvlup_cost) {
                                                balance -= farm_list.get(index).lvlup_cost
                                                level++
                                                lvlup_cost = level * Math.pow(10, index) * 10
                                                coefficient = level * Math.pow(10, index)
                                                if(level == max_level) {
                                                    visible = false
                                                } else {
                                                    text: qsTr("Level up for " + farm_list.get(index).lvlup_cost)
                                                }
                                            }
                                        }
                                    }
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
                    farm_list.append({"farm_id":farm_count-1,
                                      "name":"Farm " + farm_count,
                                      "coefficient": Math.pow(10, farm_count-1),
                                      "max_level":10,
                                      "level": 1,
                                      "lvlup_cost": Math.pow(10, farm_count)})
                    farm_count++
                }
            }
        }

    }
}
