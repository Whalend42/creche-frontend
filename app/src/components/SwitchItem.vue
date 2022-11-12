<script setup lang="ts">
    //import { reactive } from 'vue'
    import FreezabeInputItem from "./FreezabeInputItem.vue";
    import type Switch from '@/types/Switch'
    import { ref, computed } from 'vue'
    //const state = reactive({value: true})

    const props = defineProps<{
        sw: Switch
    }>()
    let label = ref(String(props.sw.index))

    const lightBubleColor = computed(() => {
        return props.sw.isOn ? 'yellow-accent-2' : 'grey-lighten-1'
    })

    const emit = defineEmits<{
        (e: 'change-inhibition', value: Switch): void
        (e: 'change-state', value: Switch): void
    }>()

    const onChangeInhibition = (sw: Switch) => {
        console.log("in switch, inhibition: "+sw.isInhibited)
        emit('change-inhibition', sw)
    }

    const onChangeState = (sw: Switch) => {
        console.log("in switch, state: "+sw.isOn)
        // user can change the value of a switch only if it is "inhibited". i.e. if the automation cannot modify it
        if (sw.isInhibited) {
            emit('change-state', sw)
        }
    }
</script>

<template>
    <td>{{props.sw.index}}</td>
    <td>
        <FreezabeInputItem v-model:text="label"/>
    </td>
    <td>
        <v-btn
            variant="outlined"
            size="large"
            icon
            color="grey-lighten-1">
            <v-icon
                size="x-large"
                icon="mdi-lightbulb"
                :color="lightBubleColor">
            </v-icon>
        </v-btn>
    </td>
    <td>
        <v-switch
            v-model="props.sw.isInhibited"
            @click="onChangeInhibition(sw)"
            :label="props.sw.isInhibited ? 'on' : 'off'"
            inset
            color="primary"/>
    </td>
    <td>
        <v-switch
            v-model="props.sw.isOn"
            :disabled="!props.sw.isInhibited"
            @click="onChangeState(sw)"
            :label="props.sw.isOn ? 'on' : 'off'"
            inset
            color="primary" />
    </td>
</template>


<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
