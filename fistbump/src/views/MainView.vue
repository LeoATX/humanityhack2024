<script>
  import MainNavbar from '@/components/MainNavbar.vue'
  import EventItem from '@/components/EventItem.vue'

  import { ref } from 'vue';

  const selection = ref([]);
  const options = [...Array(95).keys()];

  export default {
    name: "MainView",
    components: {
      MainNavbar,
      EventItem,
    },
    data: () =>  {
      return {
        "options": options
      }
    }
  };
</script>

<template>
  <div style="display: grid; gridTemplateColumns: 2fr 5fr;">
    <div style="grid-column: 1; background: white; height: 100vh">
      <drag-select v-model="selection">
        <drag-select-option v-for="item in options" :value="item" :key="item">⠀</drag-select-option>
      </drag-select>
    </div>
    <div style="grid-column: 2; background: white; height: 100vh; overflow-y: auto; overflow-x: hidden">
      <MainNavbar />
      <div style="margin-top:100px; display: flex; flex-direction: column; flex-wrap: nowrap; gap: 125px">
        <EventItem />
        <EventItem />

      </div>  
    </div>
  </div>
  </template>

<style>
  .drag-select-option {
    width: 100px;
    height: 5x;
    color: #ffffff;
    background: #E37E26;
  }

  .drag-select-option--selected {
    color: #000000;
    background: #5fdddc;
  }
</style>
