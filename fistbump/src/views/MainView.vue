<script>
  import { baseBackendUrl } from "@/helper";
  import MainNavbar from '@/components/MainNavbar.vue'
  import EventItem from '@/components/EventItem.vue'
  import axios from 'axios'
  import { ref } from 'vue';

  let getMidnightEpochPST = (date) => { return (Date.parse(date) - (Date.parse(date) % 86400000)) + 86400000 - 57600000}
  let getAllDayEvents = async (midnightEpochPST) => { return (await axios.get(`${baseBackendUrl}/getEvents?startTime=${midnightEpochPST}&endTime=${midnightEpochPST + 86400000}`)).data.events;
 }

  const options = [...Array(65).keys()];

  export default {
    name: "MainView",
    components: {
      MainNavbar,
      EventItem,
    },
    async mounted() {
      let todayMidnightEpochPST = getMidnightEpochPST(this.daySelected);
      this.events = await getAllDayEvents(todayMidnightEpochPST);
    },
    data: () =>  {
      return {
        "selection": [],
        "options": options,
        "daySelected": new Date(),
        "events": [],
        "dateMapper": {
          0: 'Sunday',
          1: 'Monday',
          2: 'Tuesday',
          3: 'Wednesday',
          4: 'Thursday',
          5: 'Friday',
          6: 'Saturday'
        },
        "dateSelector": [
          new Date(Date.parse(new Date()) - (2 * 86400000)),
          new Date(Date.parse(new Date()) - 86400000),
          new Date(),
          new Date(Date.parse(new Date()) + 86400000),
          new Date(Date.parse(new Date()) + (2 * 86400000)),
        ]
      }
    },
    methods: {
      applyBorders(top, bottom) {
        const times = document.getElementsByClassName("timeline-item");
        console.log(top, bottom)
        times[top].classList.add('top-border')
        times[bottom].classList.add('bottom-border')
      },
      async dayLeft() {
        this.daySelected = new Date(Date.parse(new Date(this.daySelected)) -  86400000);
        this.updateDateSelector()
      },
      async dayRight() {
        this.daySelected = new Date(Date.parse(new Date(this.daySelected)) + 86400000);
        this.updateDateSelector()
      },
      async setDate(day) {
        this.daySelected = new Date(Date.parse(new Date(day)));
        this.updateDateSelector()
      },
      async updateDateSelector() {
        this.dateSelector = [
          new Date(Date.parse(new Date(this.daySelected)) - (2 * 86400000)),
          new Date(Date.parse(new Date(this.daySelected)) -  86400000),
          new Date(this.daySelected),
          new Date(Date.parse(new Date(this.daySelected)) + 86400000),
          new Date(Date.parse(new Date(this.daySelected)) + (2 * 86400000)),
        ]
        this.events = [];
        if (this.selection.length > 0) {
          this.press();
        } else {
          let todayMidnightEpochPST = getMidnightEpochPST(this.daySelected);
          this.events = await getAllDayEvents(todayMidnightEpochPST);
        }
      },
      async press() {
        let getPSTEpochTimeFromIndex = (index) => {
          let midnightEpochPST = getMidnightEpochPST(new Date(this.daySelected));
          // midnight + 8 am offset + 15 min offset
          return (midnightEpochPST + 28800000 + (index * 900000));
        }

        let selectionArr = [...this.selection];
        let startTimeEpoch = getPSTEpochTimeFromIndex(selectionArr[0]);
        let endTimeEpoch = getPSTEpochTimeFromIndex(selectionArr[selectionArr.length - 1] + 1);

        this.applyBorders(selectionArr[0], selectionArr[selectionArr.length - 1]);
        this.events = (await axios.get(`${baseBackendUrl}/getEvents?startTime=${startTimeEpoch}&endTime=${endTimeEpoch}`)).data.events;
      },
      async unselect() {
        Array.from(document.getElementsByClassName("timeline-item")).forEach(
          function(element, index, array) {
            element.classList.remove('drag-select-option--selected');
            element.classList.remove('top-border');
            element.classList.remove('bottom-border');
        });

        let todayMidnightEpochPST = getMidnightEpochPST(this.daySelected);
        this.events = await getAllDayEvents(todayMidnightEpochPST);
        this.selection = [];
      },
    }
  };
</script>

<template>
  <div style="display: grid; gridTemplateColumns: 2fr 5fr; grid-auto-rows: auto;">
    <div style="grid-column: 1; grid-row: 1 / 3 background: white; height: 100vh; background: var(--yellow);">
      <!-- <button @click="press()"></button> -->
      <div style="margin-top: max(2.5vh, 15px);">
        <div style="display: flex; flex-wrap: no-wrap; gap: 35px; justify-content: center;">
          <img class="arrow" @click="this.dayLeft()" src="@/assets/arrow-left.png" width="25px" height="25px">
          <div style="width: 60%; display: flex; flex-wrap: no-wrap; gap: 35px; justify-content: center;">
            <span v-for="day in this.dateSelector" @click="setDate(day)" class="dateSelector">{{ (new Date(day).getMonth() + 1) + "/" + new Date(day).getDate() }}</span>
          </div>
          <img class="arrow" @click="this.dayRight()" src="@/assets/arrow-right.png" width="25px" height="25px">
        </div>
        <center>
          <h1> {{ this.dateMapper[new Date(this.daySelected).getDay()] + " " + (new Date(this.daySelected).getMonth() + 1) + "/" + new Date(this.daySelected).getDate() }} </h1>
        </center>
      </div>
      <div class="timeline">
        <div style="margin-right: 15px; margin-top: -20px;">
          <p style="margin-bottom: 3.1vh; font-size: 1.2vh" v-for="time in ['8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM', '12:00 AM', '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM', '6:00 PM', '7:00 PM', '8:00 PM', '9:00 PM', '10:00 PM', '11:00 PM', '12:00 AM']">
            {{ time }}
          </p>
        </div>
        <drag-select v-model="selection" clickBlankToClear="True" @click="press()">
          <drag-select-option v-for="item in options" :value="item" data="hello" :key="item" class="timeline-item"></drag-select-option>
        </drag-select>
      </div>
      <center>
        <button @click="this.unselect()" style="width: 100px; height: 40px">Reset</button>
      </center>
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
    transition: 0.15s;
  }

  .dateSelector:hover {
    cursor: pointer;
    transform: scale(1.05);
    transition: 0.15s;
  }

  .timeline {
    margin-left: 10px;
    display: flex;
    flex-direction: row;
  }

  .drag-select-option {
    width: 350px;
    height: 1.15vh;
    color: #ffffff;
    /* border-top: 1px black solid; */
  }

  .drag-select-option:nth-child(4n + 1) {
    border-top: 1px black solid;
  }

  .drag-select-option--selected:nth-child(4n + 1) {
    border-top: 1px var(--border) solid !important; 
  }

  .drag-select-option--selected {
    background: var(--purple);
    border-left: 2px var(--border) solid !important; 
    border-right: 2px var(--border) solid !important; 
  }

  .drag-select-option--selected.top-border {
    box-shadow: inset 0 2px 0px var(--border);
    /* border-top-left-radius: 10px;
    border-top-right-radius: 10px; */
  }

  .drag-select-option--selected.bottom-border {
    box-shadow: inset 0 -2px 0px var(--border);
    /* border-bottom-left-radius: 10px;
    border-bottom-right-radius: 10px; */
  }

  .drag-select-option--selected.bottom-border.top-border {
    box-shadow: inset 0 -2px 0px var(--border), inset 0 2px 0px var(--border) !important;
  }

</style>
