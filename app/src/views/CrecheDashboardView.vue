<script setup lang="ts">
    import SwitchesItem from "../components/SwitchesItem.vue";
    import AutomateControlItem from "../components/AutomateControlItem.vue";
    import type Switch from '@/types/Switch';
    import { reactive, ref, onMounted } from 'vue';
    import { stringifyQuery } from "vue-router";

    const defaultSwitches = [
        {
            index: 0,
            status:
            {
                isOn: true,
                isInhibited: false
            }
        } as Switch,
        {
            index: 1,
            status:
            {
                isOn: false,
                isInhibited: true
            }
        } as Switch
    ]

    // some reactive variable

    const switches = ref(defaultSwitches)
    const isConnected = ref(false)
    const automateStatus = ref(null)

    // some functions

    function setDefaultSwitches() {
        switches.value = defaultSwitches
    }
    function setSwitchesFromData(data: string) {
      const resp = JSON.parse(data)
      switches.value = resp
    }

    // trigger

    const onChangeInhibition = (sw: Switch) => {
        console.log("in parent, inhibition: "+sw.status.isInhibited)
        const cmd = {
            action: "inhibit",
            index: sw.index
        }
        if (sw.status.isInhibited) {
            cmd.action = "release"
        }
        console.log(cmd)
        if (isConnected) {
            connection.send(JSON.stringify(cmd))
        }
    }

    const onChangeState = (sw: Switch) => {
        console.log("in parent, state: "+sw.status.isOn)
        const cmd = {
            action: "on",
            index: sw.index
        }
        if (sw.status.isOn) {
            cmd.action = "off"
        }
        console.log(cmd)
        if (isConnected) {
            connection.send(JSON.stringify(cmd))
        }
    }

    // Connection to websocket api

    const connection = new WebSocket('ws://localhost:9999')
    connection.onmessage = function(event) {
      console.log("message");
      console.log(event);
      setSwitchesFromData(event.data)
    }
    connection.onopen = function(event) {
      console.log("Successfully connected to the echo websocket server...")
      isConnected.value = true
      const cmd = {
        action: "status"
      }
      connection.send(JSON.stringify(cmd));
    }
    connection.onclose = function(event) {
        isConnected.value = false
        console.log("ON close?")
        setDefaultSwitches()
    }
    connection.onerror = function(event) {
        isConnected.value = false
        console.log("on errror?")
        setDefaultSwitches()
    }
</script>

<template>

<v-container>
    <v-row>
        <v-col cols="12">
            <v-alert
                v-if="!isConnected"
                icon="mdi-flash"
                title="Hors ligne"
                type="error">
                Impossible d'établire la connexion avec le serveur
            </v-alert>
        </v-col>
    </v-row>

    <v-row>
        <v-col cols="12">
            <v-card
                title="Automate"
                subtitle="Pour charger et jouer des partitions"
                variant="tonal">
                <v-card-item>
                    <AutomateControlItem>
                    </AutomateControlItem>
                </v-card-item>
            </v-card>
        </v-col>
    </v-row>

    <v-row>
        <v-col cols="12">
            <v-card
                title="Etat et controle de la crèche"
                subtitle="Pour voir le status de la crèche et controller manuellement les interupteurs"
                variant="tonal">
                <v-card-item>
                    <SwitchesItem
                        :switches=switches
                        @change-inhibition="onChangeInhibition"
                        @change-state="onChangeState" />
                </v-card-item>
            </v-card>
        </v-col>
    </v-row>
</v-container>

</template>
