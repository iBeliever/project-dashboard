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
import "../backend"
import "../components"
import "../backend/services"
import "../ubuntu-ui-extras"
import "travis"

Plugin {
    id: plugin

    name: "travis"
    canReload: true

    property var info: doc.get("repo", undefined)
    property var builds: doc.get("builds", [])

    items: PluginItem {
        title: "Continuous Integration"
        icon: "check-circle"
        value: buildStatus(info.last_build_result)

        pulseItem: PulseItem {
            visible: plugin.info ? true : false
            title: i18n.tr("Latest Results from Travis CI")
            BuildListItem {
                number: plugin.info ? plugin.info.last_build_number : 0
                status: plugin.info ? plugin.info.last_build_result : 0
                built_at: plugin.info ? plugin.info.last_build_finished_at : ""
                info: {
                    for (var i = 0; i < builds.length; i++) {
                        if (builds[i].id === plugin.info.last_build_id) {
                            return builds[i]
                        }
                    }

                    return {}
                }

                repo: repo
                message: plugin.info ? info.message ? info.message : "" : ""
            }
        }

        page: PluginPage {
            title: i18n.tr("Build History")

            flickable: listView

            ListView {
                id: listView
                anchors.fill: parent
                model: builds
                delegate: BuildListItem {
                    number: modelData.number
                    message: modelData.message
                    info: modelData
                    status: typeof(modelData.result) == "number" ? modelData.result : -1
                    built_at:  modelData.finished_at != null ? modelData.finished_at : ""
                    repo: repo
                }
                clip: true
            }

            Scrollbar {
                flickableItem: listView
            }
        }
    }

    property string repo:  project.getPlugin("GitHub").repo

    function statusColor(status) {
        if (status === 0)
            return colors["green"]
        else if (status === 1)
            return colors["red"]
        else
            return ""
    }

    function buildStatus(status) {
        return "<font color=\"" + statusColor(status) + "\">" + (status === -1 ? i18n.tr("Pending") : status === 0 ? i18n.tr("Passed") : status === 1 ? i18n.tr("Failed") : i18n.tr("Error")) + "</font>"
    }

    onLoaded: {
        travisCI.getRepo(repo, function(status, response) {
            if (status === 304)
                return
            doc.set("repo", JSON.parse(response))
        })

        travisCI.getBuilds(repo, function(status, response) {
            if (status === 304)
                return
            doc.set("builds", JSON.parse(response))
        })
    }
}
