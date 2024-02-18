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
      if (this.name == null || this.startTime == null || this.endTime == null) {
        this.error =
          "You are missing a required parameter silly (name, start time, and end time)";
        return;
      }
      this.error = "";

      await axios.get(
        `${baseBackendUrl}/addEvent?name=${this.name}&organization=${
          this.organization
        }&description=${this.description}&url=${
          this.url
        }&startTime=${Date.parse(this.startTime)}&endTime=${Date.parse(
          this.endTime
        )}`
      );
    },
  },
};
</script>

<template>
  <div>
    <h1>Add Event</h1>
    <label>Name: </label>
    <input v-model="name" class="input" type="text" placeholder="Text input" />

    <br />
    <label>Club/Organization: </label>
    <input
      v-model="organization"
      class="input"
      type="text"
      placeholder="Text input"
    />
    
    <br />
    <label>Event description </label>
    <input
      v-model="description"
      class="input"
      type="text"
      placeholder="Text input"
    />

    <br />
    <label>Start Time: </label>
    <input v-model="startTime" class="input" type="datetime-local" />

    <br />
    <label>End Time: </label>
    <input v-model="endTime" class="input" type="datetime-local" />
    <button @click="submit">Submit</button>

    <br />
    <label>URL/Links</label>
    <input
      v-model="url"
      class="input"
      type="text"
      placeholder="www.scu.edu"
    />

    <p style="color: red">{{ error }}</p>
  </div>
</template>

<style>
</style>
