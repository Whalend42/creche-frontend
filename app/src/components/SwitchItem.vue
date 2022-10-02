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
        console.log("in switch, inhibition: "+sw.isInhibited)
        emit('change-inhibition', !sw.isInhibited)
    }

    const onChangeState = (sw: Switch) => {
        console.log("in switch, state: "+sw.isInhibited)
        // user can change the value of a switch only if it is "inhibited". i.e. if the automation cannot modify it
        if (sw.isInhibited) {
            emit('change-state', sw.isOn ? "on" : "off")
        }
    }
</script>
<style src="@vueform/toggle/themes/default.css"></style>

<template>
    <td class="mdc-data-table__cell mdc-data-table__cell--numeric">{{props.sw.index}}</td>
    <td class="mdc-data-table__cell"> <FreezabeInputItem v-model:text="alias"/> </td>
    <td class="mdc-data-table__cell centered">
        <i class="fas fa-lightbulb" :class="{on: props.sw.isOn}"></i>
    </td>
    <td class="mdc-data-table__cell centered">
        <Toggle
            v-model="props.sw.isInhibited"
            @change="onChangeInhibition(sw)"
            on-label="on"
            off-label="Off" />
    </td>
    <td class="mdc-data-table__cell centered">
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
