/*
 * Project Dashboard - Manage everything about your projects in one app
 * Copyright (C) 2014 Michael Spencer
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0
import Ubuntu.Components.ListItems 1.0 as ListItem
import "../../backend/services"

Page {
    id: sheet

    title: i18n.tr("New Issue")

    property string repo: plugin.name
    property var plugin

    TextField {
        id: nameField
        placeholderText: i18n.tr("Title")
        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
            margins: units.gu(2)
        }
        color: focus ? Theme.palette.normal.overlayText : Theme.palette.normal.baseText

        Keys.onTabPressed: descriptionField.forceActiveFocus()
    }

    TextArea {
        id: descriptionField
        placeholderText: i18n.tr("Description")
        color: focus ? Theme.palette.normal.overlayText : Theme.palette.normal.baseText

        anchors {
            left: parent.left
            right: parent.right
            top: nameField.bottom
            bottom: buttonsRow.top
            margins: units.gu(2)
            topMargin: units.gu(1)
        }
    }

    Item {
        id: buttonsRow
        width: parent.width
        height: childrenRect.height

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: units.gu(2)
        }

        Button {
            objectName: "cancelButton"
            text: i18n.tr("Cancel")

            anchors {
                left: parent.left
                right: parent.horizontalCenter
                rightMargin: units.gu(1)
            }

            color: "gray"

            onTriggered: {
                pageStack.pop()
            }
        }

        Button {
            id: okButton
            objectName: "okButton"

            anchors {
                left: parent.horizontalCenter
                right: parent.right
                leftMargin: units.gu(1)
            }

            text: i18n.tr("Ok")
            enabled: nameField.text !== "" && descriptionField.text !== ""

            onTriggered: {
                pageStack.pop()
                plugin.newIssue(nameField.text, descriptionField.text)
            }
        }
    }
}
