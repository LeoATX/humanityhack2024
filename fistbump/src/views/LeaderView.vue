<script>
import axios from "axios";

const baseBackendUrl = "http://localhost:8080";

export default {
  name: "LeaderView",

  data: () => {
    return {
      name: null, // required
      organization: null,
      description: null,
      url: null,
      startTime: null, // required
      endTime: null, // required
      error: "",
    };
  },

  methods: {
    async submit() {
        var date = new Date();
        // floor to get GMT midnight, sub to get PST, add to get 8 am offset, add multiple by selected index to get time at select
        console.log(((((Math.floor(Date.parse(date) / 86400000 )) * 86400000) - 57600000 + 28800000) + (index * 3600000)))
      if (this.name == null || this.startTime == null || this.endTime == null) {
        this.error =
          "You are missing a required parameter silly (name, start time, and end time)";
        return;
      }

      // this converts to PST
      const startTimeEpoch = Date.parse(this.startTime);
      const endTimeEpoch = Date.parse(this.endTime);
      if (startTimeEpoch >= endTimeEpoch) {
        this.error = "The end time has to be after the start time silly!"
        return;
      }

      this.error = "";

      await axios.get(
        `${baseBackendUrl}/addEvent?name=${this.name}&organization=${this.organization
        }&description=${this.description}&url=${this.url
        }&startTime=${startTimeEpoch}&endTime=${endTimeEpoch}`
      );
    },
  },
};
</script>

<template>
  <title>Add Event</title>
  <br>
  <div style="margin:0 auto;">

    <label>Name: </label>
    <input v-model="name" class="input" type="text" placeholder="Text input" />

    <br />
    <label>Club/Organization: </label>
    <input v-model="organization" class="input" type="text" placeholder="Text input" />

    <br />
    <label>Event description: </label>
    <input v-model="description" class="input" type="text" placeholder="Text input" />

    <br />
    <label>URL: </label>
    <input v-model="url" class="input" type="text" placeholder="www.scu.edu" />

    <br />
    <label>Start Time: </label>
    <input v-model="startTime" class="input" type="datetime-local" />

    <br />
    <label>End Time: </label>
    <input v-model="endTime" class="input" type="datetime-local" />

    <br /><br>
    <button @click="submit"
      :disabled="(name == null || startTime == null || endTime == null) ? '' : disabled">Submit</button>
    <p v-if="(name == null || startTime == null || endTime == null) == true">You are missing a required parameter silly
      (name, start time, and end time)</p>

    <p style="color: red">{{ error }}</p>
  </div>
</template>

<style>
@import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:ital,wght@0,100..800;1,100..800&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap');

* {
  font-family: "JetBrains Mono";
}
</style>
