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
<style src="@vueform/toggle/themes/default.css"></style>

<template>
    <td>{{props.sw.index}}</td>
    <td> <FreezabeInputItem v-model:text="alias"/> </td>
    <td>
        <i class="fas fa-lightbulb" :class="{on: props.sw.isOn}"></i>
    </td>
    <td>
        <Toggle
            v-model="props.sw.isInhibited"
            @change="onChangeInhibition(sw)"
            on-label="on"
            off-label="Off" />
    </td>
    <td>
        <Toggle
            v-model="props.sw.isOn"
            :disabled="!props.sw.isInhibited"
            @change="onChangeState(sw)"
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
    .centered {
        text-align: center;
    }
</style>
