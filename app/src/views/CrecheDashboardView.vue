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
    <main>
        <SwitchesItem
            :switches=switches
            @change-inhibition="onChangeInhibition"
            @change-state="onChangeState" />

        <aside v-if="!isConnected" class="mdc-snackbar">
            <div class="mdc-snackbar__surface" role="status" aria-relevant="additions">
                <div class="mdc-snackbar__label" aria-atomic="false">
                    Can't send photo. Retry in 5 seconds.
                </div>
                <div class="mdc-snackbar__actions" aria-atomic="true">
                    <button type="button" class="mdc-button mdc-snackbar__action">
                        <div class="mdc-button__ripple"></div>
                        <span class="mdc-button__label">Retry</span>
                    </button>
                </div>
            </div>
        </aside>
    </main>
</template>
