<script setup lang="ts">
    import { ref } from 'vue'

    const automateStatus = ref(null)
</script>


<template>
    <v-row>
        <v-col cols="12">
        Currently playing: file1.txt<br/>
        timer: 02:10
        <pre class="pt-2">{{ automateStatus }}</pre>
        <div class="d-flex align-center flex-column pa-6">
        </div>
        </v-col>
    </v-row>
    <v-row justify="center">
        <v-col cols="4">
        <v-btn-toggle
                v-model="automateStatus"
                variant="outlined"
                divided>
                <v-btn icon="mdi-play" value="play"></v-btn>
                <v-btn icon="mdi-pause" value="pause"></v-btn>
                <v-btn icon="mdi-stop" value="stop"></v-btn>
                <v-btn icon="mdi-eject" value="eject"></v-btn>
            </v-btn-toggle>
        </v-col>
    </v-row>
</template>
