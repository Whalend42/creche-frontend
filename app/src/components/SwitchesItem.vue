<script setup lang="ts">
    import SwitchItem from "./SwitchItem.vue";
    import type Switch from '@/types/Switch';
    import { reactive, ref, onMounted } from 'vue'

    // some constants

    const headers = {
        number: '#',
        name: 'Nom',
        status: 'Statut',
        managed: 'Mode manuel',
        actions: 'Actions'
    }

    // received values

    const props = defineProps<{
        switches: Switch[]
    }>()

    // events thrown

    const emit = defineEmits<{
        (e: 'change-inhibition', value: Switch): void
        (e: 'change-state', value: Switch): void
    }>()

    // trigger

    const onChangeInhibition = (sw: Switch) => {
        console.log("in switchES, inhibition: "+sw.isInhibited)
        emit('change-inhibition', sw) // simply pass on the event
    }

    const onChangeState = (sw: Switch) => {
        console.log("in switchES, state: "+sw.isOn)
        emit('change-state', sw) // simply pass on the event
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
                            @change-inhibition="onChangeInhibition"
                            @change-state="onChangeState" />
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</template>
