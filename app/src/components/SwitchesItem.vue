<script setup lang="ts">
    import SwitchItem from "./SwitchItem.vue";
    import type Switch from '@/types/Switch';
    import { reactive, ref, onMounted } from 'vue'

    // some constants

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
    const headers = {
        number: '#',
        name: 'Nom',
        status: 'Statut',
        managed: 'Mode manuel',
        actions: 'Actions'
    }

    // some reactive variable

    const switches = ref(defaultSwitches)

    // some functions

    function setDefaultSwitches() {
        switches.value = defaultSwitches
    }
    function setSwitchesFromData(data: string) {
      const resp = JSON.parse(data)
      switches.value = resp
    }
    function changeInhibition(sw: Switch) {
        console.log("in switches, inhibition: "+sw.isInhibited)
    }
    function changeState (sw: Switch) {
        console.log("in switches, state: "+sw.isOn)
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
      const cmd = {
        action: "status"
      }
      connection.send(JSON.stringify(cmd));
    }
    connection.onclose = function(event) {
        setDefaultSwitches()
    }
    connection.onerror = function(event) {
        setDefaultSwitches()
    }
</script>

<template>
    <div class="mdc-data-table">
        <div class="mdc-data-table__table-container">
            <table class="mdc-data-table__table" aria-label="Dessert calories">
                <thead>
                    <tr class="mdc-data-table__header-row">
                        <th class="mdc-data-table__header-cell mdc-data-table__header-cell--numeric" role="columnheader" scope="col">{{headers.number}}</th>
                        <th class="mdc-data-table__header-cell" role="columnheader" scope="col">{{headers.name}}</th>
                        <th class="mdc-data-table__header-cell" role="columnheader" scope="col">{{headers.status}}</th>
                        <th class="mdc-data-table__header-cell" role="columnheader" scope="col">{{headers.managed}}</th>
                        <th class="mdc-data-table__header-cell" role="columnheader" scope="col">{{headers.actions}}</th>
                    </tr>
                </thead>
                <tbody class="mdc-data-table__content">

                    <tr
                        class="mdc-data-table__row"
                        v-for="(sw, index) in switches" :key="index">
                        <SwitchItem
                            :sw=sw
                            @change-inhibition="changeInhibition(sw)"
                            @change-state="changeState(sw)" />
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- <aside class="mdc-snackbar">
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
    </aside> -->

</template>
