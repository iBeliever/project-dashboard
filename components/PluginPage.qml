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
import "../ubuntu-ui-extras"
import "../ui/project_page"

PageView {
    id: page

    property var tabs: []
    property int selectedIndex: 0
    property var selectedTab: tabs[selectedIndex]

    //property string title

    property list<Action> actions

    property Flickable flickable

    clip: true

//    property int loading: plugin.loading

//    onLoadingChanged: {
//        if (loading > 0) {
//            header.show()
//        }
//    }

//    Item {
//        anchors.fill: parent
//        anchors.bottomMargin: header.height - header.__styleInstance.contentHeight
//        parent: header

//        ActivityIndicator {
//            anchors {
//                right: parent.right
//                verticalCenter: parent.verticalCenter
//                rightMargin: (parent.height - height)/2
//            }

//            height: units.gu(4)
//            width: height
//            running: visible
//            visible: loading > 0
//        }
//    }

//    tools: ToolbarItems {
//        opened: wideAspect
//        locked: wideAspect

//        onLockedChanged: opened = locked

//        Repeater {
//            model: page.actions
//            delegate: ToolbarButton {
//                id: toolbarButton
//                action: modelData
//                visible: action.visible
//                function trigger(value) { action.triggered(toolbarButton) }
//            }
//        }
//    }
}
