<script setup lang="ts">
    //import { reactive } from 'vue'
    import FreezabeInputItem from "./FreezabeInputItem.vue";
    import type Switch from '@/types/Switch'
    import { ref } from 'vue'
    //const state = reactive({value: true})

    const props = defineProps<{
        sw: Switch
    }>()
    let alias = ref(String(props.sw.index))
    //const alias = reactive([{text: String(props.sw.index)}])

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
    <td> <FreezabeInputItem v-model:text="alias"/> </td>
    <td>
        <i class="fas fa-lightbulb" :class="{on: props.sw.isOn}"></i>
    </td>
    <td>
        <v-switch
            v-model="props.sw.isInhibited"
            @click:append="onChangeInhibition(sw)"
            :label="props.sw.isInhibited ? 'on' : 'off'"
            inset
            color="primary"/>
    </td>
    <td>
        <v-switch
            v-model="props.sw.isOn"
            :disabled="!props.sw.isInhibited"
            @click:append="onChangeState(sw)"
            :label="props.sw.isOn ? 'on' : 'off'"
            inset
            color="primary" />
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
    .centered {
        text-align: center;
    }
</style>
