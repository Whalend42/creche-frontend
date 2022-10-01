<script setup lang="ts">
    //import { reactive } from 'vue'
    import FreezabeInputItem from "./FreezabeInputItem.vue";
    import type Switch from '@/types/Switch'
    import Toggle from '@vueform/toggle'
    import { ref } from 'vue'
    //const state = reactive({value: true})

    const props = defineProps<{
        sw: Switch
    }>()
    let alias = ref(String(props.sw.index))
    //const alias = reactive([{text: String(props.sw.index)}])

    const emit = defineEmits<{
        (e: 'change-inhibition', value: boolean): void
        (e: 'change-state', value: string): void
    }>()

    const onChangeInhibition = (sw: Switch) => {
        console.log("in switch, inhibition: "+sw.inhibited)
        emit('change-inhibition', !sw.inhibited)
    }

    const onChangeState = (sw: Switch) => {
        console.log("in switch, state: "+sw.inhibited)
        // user can change the value of a switch only if it is "inhibited". i.e. if the automation cannot modify it
        if (sw.inhibited) {
            emit('change-state', sw.state == "on" ? "off" : "on")
        }
    }
</script>
<style src="@vueform/toggle/themes/default.css"></style>

<template>
    <td>{{props.sw.index}}</td>
    <td> <FreezabeInputItem v-model:text="alias"/> </td>
    <td>
        <i class="fas fa-lightbulb" :class="[props.sw.state === 'on' ? 'on' : '']"></i>
    </td>
    <td>
        <Toggle
            v-model="props.sw.inhibited"
            @change="onChangeInhibition(sw)"
            on-label="on"
            off-label="Off" />
    </td>
    <td>
        <Toggle
            v-model="props.sw.state"
            :disabled="!props.sw.inhibited"
            @change="onChangeState(sw)"
            true-value="on"
            false-value="off"
            on-label="on"
            off-label="Off" />
    </td>
</template>


<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    .fas.fa-lightbulb {
      font-size: 25px;
      color: lightblue;
    }
    .fas.fa-lightbulb.on {
      color: yellow;
    }
</style>
