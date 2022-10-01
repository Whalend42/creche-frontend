<script setup lang="ts">
    import SwitchItem from "./SwitchItem.vue";
    import type Switch from '@/types/Switch';
    const switches = [
        {
            alias: "salut",
            state: "on",
            inhibited: false
        } as Switch,
        {
            alias: "hello",
            state: "off",
            inhibited: true
        } as Switch,
    ]
    const headers = {
        number: '#',
        name: 'Nom',
        status: 'Statut',
        managed: 'Mode manuel',
        actions: 'Actions'
    }
    const index = 0
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
                <SwitchItem :sw=sw :index=index />
            </tr>
        </tbody>
      </table>
</template>