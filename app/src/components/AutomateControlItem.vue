<script setup lang="ts">
    import { ref, reactive, computed } from 'vue'
    import type AutomateStatus from '@/types/AutomateStatus'

    const automateStatus = reactive(
        {
            lastAction: null,
            track: null,
            time: null
        } as AutomateStatus
    )
    const file = ref<File | null>();

    const toggle = reactive({value: null})

    const isPlayable = computed(() => {
        return (
            automateStatus.track !== null &&
            automateStatus.lastAction !== 'play'
        )
    })
    const isPausable = computed(() => {
        return (
            automateStatus.lastAction === 'play'
        )
    })
    const isStoppable = computed(() => {
        return (
            automateStatus.lastAction === 'play'||
            automateStatus.lastAction === 'pause'
        )
    })
    const isLoadable = computed(() => {
        return (
            automateStatus.lastAction === 'stop'||
            automateStatus.lastAction === 'load'||
            automateStatus.lastAction === null
        )
    })

    // events thrown

    const emit = defineEmits<{
        (e: 'play'): void
        (e: 'pause'): void
        (e: 'stop'): void
        (e: 'load', value: string): void
    }>()

    // trigger

    const play = () => {
        if (
            automateStatus.track !== null &&
            (
                automateStatus.lastAction !== 'play'
            )
        ) {
            console.log("play")
            emit('play')
            automateStatus.lastAction = 'play'
        }
    }

    const pause = () => {
        if (
            automateStatus.track !== null &&
            (
                automateStatus.lastAction === 'play' ||
                automateStatus.lastAction === null
            )
        ) {
            console.log("pause")
            emit('pause')
            automateStatus.lastAction = 'pause'
        }
    }

    const stop = () => {
        if (
            automateStatus.track !== null &&
            (
                automateStatus.lastAction === 'play' ||
                automateStatus.lastAction === 'pause' ||
                automateStatus.lastAction === null
            )
        ) {
            console.log("stop")
            emit('stop')
            automateStatus.lastAction = 'stop'
            toggle.value = null
        }
    }

    const load = ($event: Event) => {
        if (
            automateStatus.lastAction === 'stop' ||
            automateStatus.lastAction === 'load' ||
            automateStatus.lastAction === null
        ) {
            console.log("load")
            const target = $event.target as HTMLInputElement;
            if (target && target.files) {
                file.value = target.files[0];
                automateStatus.track = file.value.name
                emit('load', automateStatus.track)
                automateStatus.lastAction = 'load'
                console.log(automateStatus.track)
            }
        }
    }

    const unload = () => {
        automateStatus.lastAction = null
        automateStatus.track = null
        toggle.value = null
    }


</script>


<template>
    <v-row>
        <v-col cols="3">
            Partition
        </v-col>
    </v-row>
    <v-row>
        <v-col cols="4">
            <v-file-input
                :disabled="!isLoadable"
                density="compact"
                label="File input"
                @change="load($event)"
                @click:clear="unload">
            </v-file-input>
        </v-col>
    </v-row>
    <v-row>
        <v-col cols="12">
        Currently playing: {{automateStatus.track}}<br/>
        timer: {{automateStatus.time}}
        <pre class="pt-2">last action: {{ automateStatus.lastAction }}</pre>
        <pre class="pt-2">toggle: {{ toggle.value }}</pre>
        <div class="d-flex align-center flex-column pa-6">
        </div>
        </v-col>
    </v-row>
    <v-row justify="center">
        <v-col cols="4">
            <v-btn-toggle
                v-model="toggle.value"
                variant="outlined"
                mandatory
                divided>
                <v-btn
                    :disabled="!isPlayable"
                    icon="mdi-play"
                    value="play"
                    @click="play"></v-btn>
                <v-btn
                    :disabled="!isPausable"
                    icon="mdi-pause"
                    value="pause"
                    @click="pause"></v-btn>
                <v-btn
                    :disabled="!isStoppable"
                    icon="mdi-stop"
                    value="stop"
                    @click="stop"></v-btn>
            </v-btn-toggle>
        </v-col>
    </v-row>
</template>

<style>
    /* small enphasis when button disabled but active */
    button:disabled.v-btn--active {
        background-color: #BDBDBD;
    }
</style>
