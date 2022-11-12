<script setup lang="ts">
    import { ref } from 'vue'

    const props = defineProps<{
        text: string
    }>()

    let state = ref('editable')
    const text = ref(props.text)
    const defaultText = text.value
    const inputElement = ref(null)

    const saved = () => {
        state.value = "saved"
        console.log("saved")
        if (text.value ==='') {
            text.value = defaultText
        }
    }
    const editable = () => {
        state.value = 'editable'
        inputElement.value?.focus()
        console.log("editable")
    }
</script>

<template>
    <v-card
        @click="editable">
        <v-text-field
            ref="inputElement"
            density="compact"
            variant="solo"
            single-line
            label="nom"
            v-model="text"
            hide-details
            :disabled="state === 'saved'"
            @keyup.enter="saved"
            @blur="saved"
        ></v-text-field>
    </v-card>
</template>


<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
