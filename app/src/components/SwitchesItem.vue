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
        console.log("in switchES, inhibition: "+sw.status.isInhibited)
        emit('change-inhibition', sw) // simply pass on the event
    }

    const onChangeState = (sw: Switch) => {
        console.log("in switchES, state: "+sw.status.isOn)
        emit('change-state', sw) // simply pass on the event
    }


</script>

<template>
    <v-table>
        <thead>
            <tr>
                <th>{{headers.number}}</th>
                <th>{{headers.name}}</th>
                <th>{{headers.status}}</th>
                <th>{{headers.managed}}</th>
                <th>{{headers.actions}}</th>
            </tr>
        </thead>
        <tbody>
            <tr
                v-for="(sw, index) in switches" :key="index">
                <SwitchItem
                    :sw=sw
                    @change-inhibition="onChangeInhibition"
                    @change-state="onChangeState" />
            </tr>
        </tbody>
    </v-table>
</template>
