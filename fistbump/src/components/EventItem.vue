<script>
export default {
  name: "EventItem",
  data: () => {
    return {
      name: "Hack For Humanity",
      club: "ACM",
      start: new Date('2011-05-11T10:20:30Z'),
      end: new Date('2011-05-11T12:20:30Z')
    }
  }
};
</script>


<template>
  <div style="display: block; block-size: 15px; margin-left: 10px">
    <div style="float: left">
      <h1 class="event">{{this.name }}</h1>
      <h1 class="org">{{ this.club }}</h1>
    </div>
    <h1 class="time">{{ this.start.getHours() + ":" + this.start.getMinutes() + " - " + this.end.getHours() + ":" + this.end.getMinutes()}}</h1>
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
  letter-spacing: 3px;
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
  margin-right: 45px;
  font-weight: 400;

}
</style>