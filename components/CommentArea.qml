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
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

UbuntuShape {
    id: comment
    color: Theme.palette.normal.field//Qt.rgba(0,0,0,0.2)
    width: parent.width
    height: childrenRect.height

    property string author
    property string date
    property string text

    Item {
        id: titleItem
        height: label.height + units.gu(2)
        width: parent.width
        clip: true

        UbuntuShape {
            color: Qt.rgba(0,0,0,0.2)
            height: comment.height
            width: parent.width
        }

        Label {
            id: label
            text: i18n.tr("<b>%1</b> commented %2").arg(author).arg(friendsUtils.createTimeString(date))
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: units.gu(1)
            }
        }
    }

    ListItem.ThinDivider {
        id: divider
        anchors.top: titleItem.bottom
    }

    Item {
        id: commentArea
        anchors.top: divider.bottom
        width: parent.width
        height: contents.implicitHeight + units.gu(2.1)

        Label {
            id: contents
            anchors.fill: parent
            anchors.margins: units.gu(1)
            text: comment.text
            textFormat: Text.RichText
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }
    }
}