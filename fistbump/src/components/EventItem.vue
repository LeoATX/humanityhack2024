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
      
    <h1>{{ this.name }}</h1>
    <h1>{{ this.club }}</h1>
    <h1>{{ this.start.getHours() + ":" + this.start.getMinutes() + " - " + this.end.getHours() + ":" + this.end.getMinutes()}}</h1>
  </div>
</template>


<style>

</style>