<script>
  export default {
    name: "EventItem",
    props: ['event'],
    methods: {
      formatTime(date) {
        // raw values
        let hrsNum = date.getHours();
        let minsNum = date.getMinutes();
        // formatted values
        let hrs = 0;
        let mins = 0;
        let meridiem = '';
        console.log(hrsNum);

        // format hrs
        if (hrsNum == 0) {
          // midnight edge case
          hrs = 12;
          meridiem = 'AM';
        } else if (hrsNum == 12) {
          // noon edge case
          hrs = hrsNum;
          meridiem = 'PM';
        } else if (hrsNum > 12 ) {
          // PM converter
          hrs = hrsNum % 12;
          meridiem = 'PM';
        } else {
          // AM converter
          hrs = hrsNum;
          meridiem = 'AM';
        }

        // format mins
        if (minsNum < 10) {
          mins = `${minsNum}0`;
        } else {
          mins = minsNum;
        }

        return `${hrs}:${mins} ${meridiem}`
      }
    }
  };
</script>


<template>
  <div style="display: block; block-size: 15px; margin: 0 50px 75px;">
    <div style="float: left; display: flex;">
      <img :src="event.imageURL" height="175px" style="border-radius: 10px">
      <div>
        <h1 class="event">{{ event.name }}</h1>
        <h1 class="org">{{ event.organization }}</h1>
      </div>
    </div>
    
    <h1 class="time">{{ this.formatTime(new Date(event.startTime)) }} - {{ this.formatTime(new Date(event.endTime)) }}</h1>
    <img src="@/assets/clock.png"  width="28px" height="28px" style="float: right; margin-right: 10px; margin-top: 15px;">
  </div>  
</template>


<style>
/* @import url('https://fonts.googleapis.com/css2?family=Averia+Serif+Libre:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&family=Smooch+Sans:wght@100..900&display=swap'); */
@import url('https://fonts.googleapis.com/css2?family=Smooch+Sans:wght@100..900&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Averia+Serif+Libre:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&family=Libre+Baskerville:ital,wght@0,400;0,700;1,400&family=Smooch+Sans:wght@100..900&display=swap');

.event{
  font-family: "Libre Baskerville", serif;
  font-size: 24px;
  padding: 7px;
  text-align: left;
  letter-spacing: 2px;
  font-weight: 350;
}

.org{
  font-family: "Smooch Sans", sans-serif;
  margin-left: 10px;
  margin-top: -20px;
  text-align: left;
  font-size: 25px;
  font-weight: 500;
  letter-spacing: 4px;
}

.time{
  font-family: "Smooch Sans", sans-serif;
  float: right;
  margin-top: 10px;
  margin-right: 25px;
  font-weight: 400;

}
</style>