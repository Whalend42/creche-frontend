<script setup lang="ts">
    import SwitchItem from "./SwitchItem.vue";
    import type Switch from '@/types/Switch';
    import { ref } from 'vue'
    const switches = ref([
        {
            index: 0,
            state: "on",
            inhibited: false
        } as Switch,
        {
            index: 1,
            state: "off",
            inhibited: true
        } as Switch
    ])
    const headers = {
        number: '#',
        name: 'Nom',
        status: 'Statut',
        managed: 'Mode manuel',
        actions: 'Actions'
    }

    const changeInhibition = (sw: Switch) => {
        console.log("in switches, inhibition: "+sw.inhibited)
    }
    const changeState = (sw: Switch) => {
        console.log("in switches, state: "+sw.state)
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


</template>
