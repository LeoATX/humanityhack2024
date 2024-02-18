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
  <div>
    <h1 class="event">{{this.name }}</h1>
    <h1>{{ this.club }}</h1>
    <h1>{{ this.start.getHours() + ":" + this.start.getMinutes() + " - " + this.end.getHours() + ":" + this.end.getMinutes()}}</h1>
  </div>
</template>


<style>
@import url('https://fonts.googleapis.com/css2?family=Averia+Serif+Libre:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&family=Smooch+Sans:wght@100..900&display=swap');
.event{
  font-family: "Averia Serif Libre", serif;
  margin-top: 20px;
  font-size: 24px;
}
</style>