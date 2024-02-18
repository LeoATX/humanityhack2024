<script>
export default {
  name: "EventItem",
  props: ['event'],
  methods: {
    formatMinutes(minutes) {
      console.log(typeof minutes)
      if (minutes < 10) {
        return "0" + minutes;
      }
      return minutes;
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
    
    <h1 class="time">{{ (new Date(event.startTime)).getHours() + ":" + this.formatMinutes((new Date(event.startTime)).getMinutes()) + " - " + (new Date(event.endTime)).getHours() + ":" + this.formatMinutes((new Date(event.endTime)).getMinutes()) }}</h1>
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