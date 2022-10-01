<script setup lang="ts">
    import { reactive } from 'vue'
    import type Switch from '@/types/Switch';
    const sw = reactive({
        alias: "salut",
        state: "on",
        inhibited: false,
    })
    const index = 0
    const props = defineProps<{
        sw: Switch
        index: Number
    }>()
    /*
export default {
  name: 'Switches',
  props: {
    switches: Array
  },
  data () {
    return {
        index: 0,
        switch: {
            alias: "salut",
            state: "on",
            inhibited: false,
        },
    };
  },
  methods: {
    onChangeState(sw) {
      // console.log(sw)
      if (sw.state) {
        this.$emit('turnOn', sw)
      } else {
        this.$emit('turnOff', sw)
      }
    },
    onChangeInhibit: function (sw) {
      // console.log(sw)
      if (sw.inhibited) {
        this.$emit('inhibit', sw)
      } else {
        this.$emit('free', sw)
      }
    }
  }
}*/
</script>

<template>
    <td>{{props.index}}</td>
    <td>{{props.sw.alias}}</td>
    <td>
        <i class="fas fa-lightbulb" v-bind:class="{on: props.sw.state}"></i>
    </td>
    <td>
        <toggle-button 
            :labels="true" 
            v-model="props.sw.inhibited"/>
    </td>
    <td>
        <toggle-button 
            :labels="true" 
            v-model="props.sw.state"
            :disabled="!props.sw.inhibited"/>
    </td>
</template>