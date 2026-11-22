import QtQuick 2.15

Rectangle {
    id: root
    width: 1280
    height: 720
    color: "#101010"

    property bool isMain: typeof primaryScreen !== "undefined" ? primaryScreen : true
    property int userIndex: Math.max(0, userModel.lastIndex)
    property int sessionIndex: Math.max(0, sessionModel.lastIndex)
    property int tick: 0
    property bool failed: false
    property bool menuOpen: false
    property string timeText: ""
    property string dateText: ""

    function esc(s) {
        return s.replace(/&/g, "&amp;").replace(/</g, "&lt;")
    }

    function userName() {
        var t = root.tick
        var item = users.itemAt(userIndex)
        return item ? item.uname : ""
    }

    function sessionName() {
        var t = root.tick
        var item = sessions.itemAt(sessionIndex)
        return item ? item.sname : ""
    }

    function layoutName() {
        if (!keyboard || keyboard.layouts.length === 0) {
            return ""
        }
        var l = keyboard.layouts[keyboard.currentLayout]
        return l ? l.shortName : ""
    }

    function setUser(i) {
        if (users.count === 0) {
            return
        }
        userIndex = (i + users.count) % users.count
        userInput.text = userName()
    }

    function nextUser() {
        setUser(userIndex + 1)
    }

    function prevUser() {
        setUser(userIndex - 1)
    }

    function pickSession(i) {
        sessionIndex = i
        menuOpen = false
        password.forceActiveFocus()
    }

    function nextLayout() {
        if (keyboard && keyboard.layouts.length > 1) {
            keyboard.currentLayout = (keyboard.currentLayout + 1) % keyboard.layouts.length
        }
    }

    function doLogin() {
        var u = userInput.text.trim()
        if (u === "") {
            u = userName()
        }
        sddm.login(u, password.text, sessionIndex)
    }

    Repeater {
        id: users
        model: userModel
        onItemAdded: function(index, item) {
            root.tick++
            if (index === root.userIndex && userInput.text === "") {
                userInput.text = item.uname
            }
        }
        delegate: Item {
            property string uname: model.name
        }
    }

    Repeater {
        id: sessions
        model: sessionModel
        onItemAdded: function(index, item) {
            root.tick++
        }
        delegate: Item {
            property string sname: model.name
        }
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            root.failed = true
            password.text = ""
            password.forceActiveFocus()
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            var d = new Date()
            root.timeText = Qt.formatDateTime(d, "HH:mm")
            root.dateText = Qt.formatDateTime(d, "dd MMM, ddd.").toLowerCase()
        }
    }

    Image {
        anchors.fill: parent
        source: "background.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.menuOpen = false
            password.forceActiveFocus()
        }
    }

    Item {
        id: mainUi
        anchors.fill: parent
        visible: root.isMain

        Rectangle {
            id: infoBox
            width: 300
            height: 119
            x: (root.width - width) / 2
            y: root.height / 2 - 153.5
            color: "#101010"
            border.width: 1
            border.color: "#252525"

            HLabel {
                x: 10
                y: 16.5 - height / 2
                color: "#afa193"
                font.bold: true
                text: "welcome, " + root.esc(userInput.text) + "!"
            }

            HLabel {
                x: 10
                y: 49.5 - height / 2
                text: "<font color='#afa193'>date: </font>" + root.dateText
            }

            HLabel {
                x: 10
                y: 74.5 - height / 2
                text: "<font color='#afa193'>time: </font>" + root.timeText
            }

            HLabel {
                x: 10
                y: 99.5 - height / 2
                text: "<font color='#afa193'>key:  </font>" + (root.layoutName() !== "" ? root.layoutName() : "-") + (keyboard && keyboard.capsLock ? " [caps]" : "")
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.nextLayout()
                }
            }
        }

        Rectangle {
            id: field
            width: 300
            height: 48
            x: (root.width - width) / 2
            y: root.height / 2 - height / 2
            color: "#101010"
            border.width: 1
            border.color: root.failed ? "#afa193" : "#252525"

            TextInput {
                id: password
                anchors.fill: parent
                anchors.margins: 10
                verticalAlignment: TextInput.AlignVCenter
                horizontalAlignment: TextInput.AlignHCenter
                echoMode: TextInput.Password
                passwordCharacter: "*"
                cursorDelegate: Item {}
                color: "#afa193"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 16
                font.bold: true
                font.preferShaping: false
                clip: true
                focus: true
                KeyNavigation.backtab: userInput
                onAccepted: root.doLogin()
                onTextChanged: root.failed = false
                Keys.onEscapePressed: text = ""
            }

            HLabel {
                anchors.centerIn: parent
                visible: password.text.length === 0
                color: "#afa193"
                font.bold: true
                text: root.failed ? "authentication failed" : "password"
            }
        }

        Rectangle {
            id: controlBox
            width: 300
            height: 84
            x: (root.width - width) / 2
            y: root.height / 2 + 34.5
            color: "#101010"
            border.width: 1
            border.color: "#252525"

            Row {
                x: 10
                y: 17 - height / 2
                spacing: 10

                HLabel {
                    text: "<font color='#afa193'>user:</font>"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.nextUser()
                    }
                }

                TextInput {
                    id: userInput
                    width: 180
                    color: "#f6f1ea"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 16
                    font.preferShaping: false
                    clip: true
                    KeyNavigation.tab: password
                    onAccepted: password.forceActiveFocus()
                    Keys.onUpPressed: root.prevUser()
                    Keys.onDownPressed: root.nextUser()
                }
            }

            HLabel {
                x: 10
                y: 42 - height / 2
                text: "<font color='#afa193'>session: </font>" + root.esc(root.sessionName().toLowerCase()) + " <font color='#afa193'>\u25be</font>"
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.menuOpen = !root.menuOpen
                }
            }

            Row {
                x: 10
                y: 67 - height / 2
                spacing: 16

                HLabel {
                    text: "<font color='#afa193'>power:</font>"
                }

                HLabel {
                    text: "\uf021"
                    color: rebootArea.containsMouse ? "#f6f1ea" : "#afa193"
                    font.pixelSize: 18
                    MouseArea {
                        id: rebootArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: sddm.reboot()
                    }
                }

                HLabel {
                    text: "\uf011"
                    color: poweroffArea.containsMouse ? "#f6f1ea" : "#afa193"
                    font.pixelSize: 18
                    MouseArea {
                        id: poweroffArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: sddm.powerOff()
                    }
                }
            }
        }

        Rectangle {
            id: sessionMenu
            visible: root.menuOpen
            z: 10
            width: 300
            x: controlBox.x
            y: controlBox.y + 56
            height: sessionColumn.height + 2
            color: "#101010"
            border.width: 1
            border.color: "#252525"

            Column {
                id: sessionColumn
                x: 1
                y: 1
                width: parent.width - 2

                Repeater {
                    model: sessionModel
                    delegate: Rectangle {
                        width: sessionColumn.width
                        height: 28
                        color: itemArea.containsMouse ? "#252525" : "#101010"

                        HLabel {
                            x: 9
                            anchors.verticalCenter: parent.verticalCenter
                            color: index === root.sessionIndex ? "#afa193" : "#f6f1ea"
                            text: root.esc(model.name.toLowerCase())
                        }

                        MouseArea {
                            id: itemArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.pickSession(index)
                        }
                    }
                }
            }
        }
    }

    Item {
        id: sideUi
        anchors.fill: parent
        visible: !root.isMain

        Rectangle {
            width: 300
            height: 84
            x: (root.width - width) / 2
            y: (root.height - height) / 2
            color: "#101010"
            border.width: 1
            border.color: "#252525"

            HLabel {
                x: 10
                y: 17 - height / 2
                text: "<font color='#afa193'>host: </font>" + root.esc(sddm.hostName ? sddm.hostName : "")
            }

            HLabel {
                x: 10
                y: 42 - height / 2
                text: "<font color='#afa193'>date: </font>" + root.dateText
            }

            HLabel {
                x: 10
                y: 67 - height / 2
                text: "<font color='#afa193'>time: </font>" + root.timeText
            }
        }
    }

    Component.onCompleted: password.forceActiveFocus()
}
