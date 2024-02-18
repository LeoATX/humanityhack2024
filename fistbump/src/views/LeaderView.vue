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
      validInput: this.name == null || this.startTime == null || this.endTime == null,
    };
  },

  methods: {
    async submit() {
      if (this.name == null || this.startTime == null || this.endTime == null) {
        this.error =
          "You are missing a required parameter silly (name, start time, and end time)";
        return;
      }

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

    <br />
    <button v-if="validInput" @click="submit">Submit</button>
    <p v-else>Fill out required fields!</p>

    <p style="color: red">{{ error }}</p>
  </div>
</template>

<style>
* {
  font-family: "JetBrains Mono";
}

@font-face {
  font-family: "JetBrains Mono";
  src: url("fistbump/assets/jetbrains-mono/JetBrainsMono-Regular.woff2") format("woff2");
}
</style>
