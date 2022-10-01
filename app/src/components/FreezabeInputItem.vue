<script setup lang="ts">
    import { ref } from 'vue'

    const props = defineProps<{
        text: string
    }>()

    let state = ref('saved')
    const text = ref(props.text)
    const showEditable = ref(false)

    const saved = () => {
        state.value = "saved"
        console.log("saved")
    }
    const editable = () => {
        state.value = 'editable'
        console.log("editable")
    }
</script>

<template>
    <input
        id="savableText"
        v-if="state === 'editable'" v-model="text"
        @keyup.enter="saved"
        @blur="saved"
        @focusout="saved"/>

    <div
        v-if="state === 'saved'"
        @click="editable"
        @mouseover="showEditable = true"
        @mouseout="showEditable = false"
        :class="{ clickable: showEditable }">
        {{text}}
    </div>
</template>


<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    .clickable {
        cursor: pointer;
    }
</style>
