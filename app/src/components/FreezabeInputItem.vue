<script setup lang="ts">
    import { ref } from 'vue'

    const props = defineProps<{
        text: string
    }>()

    let state = ref('editable')
    const text = ref(props.text)
    const defaultText = text.value
    const inputElement = ref<HTMLFormElement|null>(null)

    const saved = () => {
        state.value = "saved"
        console.log("saved")
        if (text.value ==='') {
            text.value = defaultText
        }
    }
    const editable = () => {
        state.value = 'editable'
        // wait for the text-field to become enabled again
        // then set focus to it
        setTimeout(() => {
            inputElement.value?.focus()
        }, 2, inputElement)
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
