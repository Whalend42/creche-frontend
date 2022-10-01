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
    <table class="table">
        <thead class="thead-light">
          <tr>
            <th>{{headers.number}}</th>
            <th>{{headers.name}}</th>
            <th>{{headers.status}}</th>
            <th>{{headers.managed}}</th>
            <th>{{headers.actions}}</th>
          </tr>
        </thead>
        <tbody>
            <tr v-for="(sw, index) in switches" :key="index">
                <SwitchItem 
                    :sw=sw
                    @change-inhibition="changeInhibition(sw)"
                    @change-state="changeState(sw)" />
            </tr>
        </tbody>
      </table>
</template>
