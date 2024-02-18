<script>
  import MainNavbar from '@/components/MainNavbar.vue'
  import EventItem from '@/components/EventItem.vue'

  import { ref } from 'vue';

  const selection = ref([]);
  const options = [...Array(68).keys()];

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
    },
    methods: {
      getTimeframe() {

      }
    }
  };
</script>

<template>
  <div style="display: grid; gridTemplateColumns: 2fr 5fr;">
    <div style="grid-column: 1; background: white; height: 100vh; background: #FFF9EB;">
      <div>
        <div style="display: flex; flex-wrap: wrap; gap: 35px; justify-content: center;">
          <h3 v-for="day in ['2/17', '2/17', '2/17', '2/17', '2/17']">{{ day }}</h3>
        </div>
        <center><h1>Monday, 2/19</h1></center>
      </div>
      <div class="timeline">
        <div style="margin-right: 15px;">
          <p style="margin-top: 30.5px" v-for="time in ['8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM', '12:00 AM', '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM', '6:00 PM', '7:00 PM', '8:00 PM', '9:00 PM', '10:00 PM', '11:00 PM', '12:00 PM']">
            {{ time }}
          </p>
        </div>
        <drag-select v-model="selection">
          <drag-select-option v-for="item in options" :value="item" :key="item">⠀</drag-select-option>
        </drag-select>
      </div>
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
  .timeline {
    margin-left: 10px;
    display: flex;
    flex-direction: row;
  }

  .drag-select-option {
    width: 350px;
    height: 12px;
    color: #ffffff;
    /* border-top: 1px black solid; */
  }

  .drag-select-option:nth-child(4n) {
    border-top: 1px black solid;
  }

  .drag-select-option--selected:nth-child(4n) {
    border-top: 1px #AFADF1 solid !important; 
  }

  .drag-select-option--selected {
    /* color: #000000; */
    background: #AFADF1;
    
  }
</style>
