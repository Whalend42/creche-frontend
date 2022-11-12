<script setup lang="ts">
    import SwitchesItem from "../components/SwitchesItem.vue";
    import type Switch from '@/types/Switch';
    import { reactive, ref, onMounted } from 'vue'
    import { stringifyQuery } from "vue-router";

    const defaultSwitches = [
        {
            index: 0,
            isOn: true,
            isInhibited: false
        } as Switch,
        {
            index: 1,
            isOn: false,
            isInhibited: true
        } as Switch
    ]

    // some reactive variable

    const switches = ref(defaultSwitches)
    const isConnected = ref(false)

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
        console.log("in parent, inhibition: "+sw.isInhibited)
    }

    const onChangeState = (sw: Switch) => {
        console.log("in parent, state: "+sw.isOn)
        const cmd = {
            action: "off",
            index: sw.index
        }
        if (sw.isOn) {
            cmd.action = "on"
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

<v-alert
    v-if="!isConnected"
    icon="mdi-flash"
    title="Hors ligne"
    type="error">
    Impossible d'établire la connexion avec le serveur
</v-alert>

<v-card height="50px"></v-card>

<SwitchesItem
    :switches=switches
    @change-inhibition="onChangeInhibition"
    @change-state="onChangeState" />
</template>
