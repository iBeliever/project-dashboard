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
import Ubuntu.Components.Pickers 1.0 as Picker
import "events"
import "../ui"
import "../components"
import "../ubuntu-ui-extras"
import "../model"
import "."

PluginView {
    id: clickPlugin

    type: "Events"
    title: i18n.tr("Events")
    icon: "calendar"

    items: [
        PluginItem {
            title: i18n.tr("Events")
            icon: "calendar"
            pulseItem: EventsPulseItem {}

            page: EventsPage {}

            action: Action {
                id: addAction
                text: i18n.tr("Add Event")
                description: i18n.tr("Add an event to your project's calendar")
                onTriggered: PopupUtils.open(Qt.resolvedUrl("events/AddEventDialog.qml"), undefined, {plugin: value})
            }
        }
    ]
}
