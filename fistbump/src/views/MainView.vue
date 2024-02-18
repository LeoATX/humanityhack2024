<script>
  import { baseBackendUrl } from "@/helper";
  import MainNavbar from '@/components/MainNavbar.vue'
  import EventItem from '@/components/EventItem.vue'
  import axios from 'axios'

  import { ref } from 'vue';

  const selection = ref([]);
  const options = [...Array(65).keys()];

  export default {
    name: "MainView",
    components: {
      MainNavbar,
      EventItem,
    },
    data: () =>  {
      return {
        "options": options,
        "daySelected": Date.parse(Date()),
        "currentDay": new Date(),
        "events": [],
        "dateMapper": {
          0: 'Sunday',
          1: 'Monday',
          2: 'Tuesday',
          3: 'Wenesday',
          4: 'Thursday',
          5: 'Friday',
          6: 'Saturday'
        }
      }
    },
    async mounted() {
      this.daySelected = this.dateMapper[new Date().getDay()] + " " + (new Date().getMonth() + 1) + "/" + new Date().getDate();
    },
    methods: {
      getTimeframe() {
        const times = document.getElementsByClassName("timeline-item");
        let first = -1;
        let last = -1;
        for (let i = 0; i < 65; i++) {
          const classes = times[i].classList;
          if (first == -1 && classes.contains("drag-select-option--selected")) {
            first = i
          }
          if (classes.contains("drag-select-option--selected")) {
            last = i
          }
        }
        times[first].classList.add('top-border')
        times[last].classList.add('bottom-border')
        return {'start': first, 'end': last}
      },
      nextDay() {
        this.daySelected += 86400000;
      },
      prevDay() {
        this.daySelected -= 86400000;
      },
      floorDate(epoch) {
        let remainder = epoch % 86400000;
        return epoch - remainder;
      },
      dayLeft() {
        this.currentDay.setDate(this.currentDay.getDate() - 1);
      },
      dayRight() {
        this.currentDay.setDate(this.currentDay.getDate() + 1);
      },
      async press() {
        let timeframe = this.getTimeframe();

        let getPSTEpochTimeFromIndex = (date, index) => {
          // floor to get GMT midnight, sub to get PST, add to get 8 am offset, add multiple by selected index to get time at select
          return ((((Math.floor(Date.parse(date) / 86400000 )) * 86400000) - 57600000 + 28800000) + (index * 3600000));
        }

        let startTimeEpoch = getPSTEpochTimeFromIndex(this.currentDay, timeframe.start);
        let endTimeEpoch = getPSTEpochTimeFromIndex(this.currentDay, timeframe.end);

        this.events = (await axios.get(`${baseBackendUrl}/getEvents?startTime=${startTimeEpoch}&endTime=${endTimeEpoch}`)).data.events;
      },
    }
  };
</script>

<template>
  <div style="display: grid; gridTemplateColumns: 2fr 5fr; grid-auto-rows: auto;">
    <div style="grid-column: 1; grid-row: 1 / 3 background: white; height: 100vh; background: #FFF9EB;">
      <button @click="press()"></button>
      <div>
        <div style="display: flex; flex-wrap: no-wrap; gap: 35px; justify-content: center;">
          <img class="arrow" @click="this.dayLeft()" src="@/assets/arrow-left.png" width="25px" height="25px">
          <span v-for="day in ['2/17', '2/17', '2/17', '2/17', '2/17']">{{ day }}</span>
          <img class="arrow" @click="this.dayRight()" src="@/assets/arrow-right.png" width="25px" height="25px">
        </div>
        <center>^</center>
        <center><h1> {{ this.daySelected }} </h1></center>
      </div>
      <div class="timeline">
        <div style="margin-right: 15px; margin-top: -25px;">
          <p style="margin-bottom: 30.25px" v-for="time in ['8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM', '12:00 AM', '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM', '6:00 PM', '7:00 PM', '8:00 PM', '9:00 PM', '10:00 PM', '11:00 PM', '12:00 AM']">
            {{ time }}
          </p>
        </div>
        <drag-select v-model="selection" clickBlankToClear="True" @click="press()">
          <drag-select-option v-for="item in options" :value="item" data="hello" :key="item" class="timeline-item"></drag-select-option>
        </drag-select>
      </div>
    </div>
    <div style="grid-column: 2; grid-row: 1; background: white; height: 100vh;">
      <MainNavbar />
    </div>
    <div style="grid-column: 2; grid-row: 1 / 3; margin-top: 10vh; background: white; height: 90vh; width: 100%; overflow-y: auto; overflow-x: hidden">
      <div style=" display: flex; flex-direction: column; flex-wrap: nowrap; gap: 125px">
        <EventItem v-for="event in events" :key="event.name" :event="event"/>
      </div>  
    </div>
  </div>
  </template>

<style>
  .arrow:hover {
    cursor: pointer;
    transform: scale(1.1);
  }

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

  .drag-select-option:nth-child(4n + 1) {
    border-top: 1px black solid;
  }

  .drag-select-option--selected:nth-child(4n + 1) {
    border-top: 1px #AFADF1 solid !important; 
  }

  .drag-select-option--selected {
    background: #AFADF1;
    border-left: 2px #908deb solid !important; 
    border-right: 2px #908deb solid !important; 
  }

  .top-border {
    box-shadow: inset 0 2px 0px #908deb;
  }

  .bottom-border {
    box-shadow: inset 0 -2px 0px #908deb;
  }

  .bottom-border.top-border {
    box-shadow: inset 0 -2px 0px #908deb, inset 0 2px 0px #908deb !important;
  }

</style>
