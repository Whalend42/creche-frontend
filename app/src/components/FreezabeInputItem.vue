<script setup lang="ts">
    import { ref, onUpdated } from 'vue'

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
        //$refs.
    }
    onUpdated(() => {
        // text content should be the same as current `count.value`
        //document.getElementById('someId').focus()
        //console.log(document.getElementById('someId').textContent)
    })
</script>

<template>
    <label
        class="mdc-text-field mdc-text-field--outlined mdc-text-field--no-label"
        v-if="state === 'editable'"
        @keyup.enter="saved"
        @blur="saved"
        @focusout="saved" >
        <span class="mdc-notched-outline">
            <span class="mdc-notched-outline__leading"></span>
            <span class="mdc-notched-outline__trailing"></span>
        </span>
        <input id="someId" class="mdc-text-field__input" type="text" aria-label="Label" v-model="text">
    </label>

    <div
        class="adjusted-height"
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
    .adjusted-height {
        height: 56px;
        line-height: 56px;
        vertical-align: middle;
    }
</style>
