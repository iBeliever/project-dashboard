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
import "../../components"
import "../../qml-extras/listutils.js" as List
import "../../ubuntu-ui-extras"
import "../../model"
import "../../qml-extras/dateutils.js" as DateUtils

PulseItem {
    id: pulseItem

    show: List.length(events) > 0
    title: i18n.tr("Upcoming Events")

    viewAll: plugin ? i18n.tr("View all <b>%1</b> events").arg(List.length(events)) : ""

    property var events: {
        if (plugin) {
            return plugin.upcomingEvents
        } else {
            var events = []

            for (var i = 0; i < backend.projects.count; i++) {
                var project = backend.projects.at(i)
                var p = project.getPlugin('Events')

                if (p) {
                    events = events.concat(p.upcomingEvents)
                }
            }

            events = events.sort(function (a, b) {
                return new Date(a.date) - new Date(b.date)
            })

            return events
        }
    }

    ListItem.Standard {
        text: i18n.tr("No events")
        enabled: false
        visible: List.length(events) === 0
        height: visible ? implicitHeight : 0
    }

    Repeater {
        id: repeater

        model: Math.min(List.length(events), maxItems)
        delegate: SubtitledListItem {
            property Event event: List.getItem(events,index)

            text: event.text
            subText: plugin ? "" : event.parent.parent.name
            value: DateUtils.isToday(event.date) ? i18n.tr("Today") : DateUtils.daysUntilDate(event.date) + " days"

            showDivider: index < repeater.count - 1 || showFooter
        }
    }
}
