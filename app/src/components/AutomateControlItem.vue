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

    const toggle = ref(null)

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
        }
    }

    const load = () => {
        if (
            automateStatus.lastAction === 'stop' ||
            automateStatus.lastAction === null
        ) {
            console.log("load")
            automateStatus.track = "salut"
            emit('load', automateStatus.track)
            automateStatus.lastAction = 'load'
        }
    }

</script>


<template>
    <v-row>
        <v-col cols="12">
        Currently playing: {{automateStatus.track}}<br/>
        timer: {{automateStatus.time}}
        <pre class="pt-2">{{ automateStatus.lastAction }}</pre>
        <div class="d-flex align-center flex-column pa-6">
        </div>
        </v-col>
    </v-row>
    <v-row justify="center">
        <v-col cols="4">
            <v-btn-toggle
                v-model="toggle"
                variant="outlined"
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
                <v-btn
                    :disabled="!isLoadable"
                    icon="mdi-eject"
                    value="eject"
                    @click="load"></v-btn>
            </v-btn-toggle>
        </v-col>
    </v-row>
</template>
