import QtQuick 2.15

Rectangle {
    id: root
    width: 1280
    height: 720
    color: "#101010"

    property int userIndex: Math.max(0, userModel.lastIndex)
    property int sessionIndex: Math.max(0, sessionModel.lastIndex)
    property int tick: 0
    property bool failed: false
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

    function nextSession() {
        if (sessions.count > 0) {
            sessionIndex = (sessionIndex + 1) % sessions.count
        }
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
        onClicked: password.forceActiveFocus()
    }

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
            text: "<font color='#afa193'>session: </font>" + root.esc(root.sessionName().toLowerCase()) + (sessions.count > 1 ? " <font color='#afa193'>(" + (root.sessionIndex + 1) + "/" + sessions.count + ")</font>" : "")
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.nextSession()
            }
        }

        Row {
            id: powerRow
            x: 10
            y: 67 - height / 2
            spacing: 16

            HLabel {
                text: "<font color='#afa193'>power:</font>"
            }

            HLabel {
                text: "reboot"
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: sddm.reboot()
                }
            }

            HLabel {
                text: "poweroff"
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: sddm.powerOff()
                }
            }
        }
    }

    Component.onCompleted: password.forceActiveFocus()
}
