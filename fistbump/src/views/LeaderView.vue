<script>
import axios from "axios";
import { baseBackendUrl } from "@/helper";

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
      imageURL: null,
      error: "",
      submitted: false,
    };
  },

  methods: {
    async submit() {
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
        }&startTime=${startTimeEpoch}&endTime=${endTimeEpoch}&imageURL=${this.imageURL}`
      );

      submitted = true;

    },
  },
};
</script>

<template>
  <RouterLink to="/">
    <button class="button" style="float:right;  margin-top: -3px; margin-right:35px; ">
      <img src="@/assets/arrow-left.png" width="13px" height="13px" />
      Back
    </button>
  </RouterLink>
  <div style="margin: 25px">


    <div style="margin-left: 30%">
      <h1 class="addHeader">Add Event</h1>
      <br>
      <div style="width: 550px; display: grid; grid-template-columns: 350px 1fr;">
        <div style="grid-column: 1; display: flex; flex-direction: column; gap: 25px; font-weight: 350;">
          <label class="required">Event Name:</label>
          <label class="required">Start Time:</label>
          <label class="required">End Time:</label>
          <label>Club/Organization:</label>
          <label>Event description:</label>
          <label>URL:</label>
          <label>Image Link:</label>
        </div>
        <div style="grid-column: 2; display: flex; flex-direction: column; gap: 25px;">
          <input v-model="name" class="input" type="text" />
          <input v-model="startTime" class="input" type="datetime-local" />
          <input v-model="endTime" class="input" type="datetime-local" />
          <input v-model="organization" class="input" type="text" />
          <input v-model="description" class="input" type="text" />
          <input v-model="url" class="input" type="text" />
          <input v-model="imageURL" class="input" type="text" />
        </div>
      </div>
      <div style="float: right; margin-right: 30px;">
        <button style="width: 125px; height: 50px;" @click="submit"
          :disabled="(name == null || startTime == null || endTime == null) ? '' : disabled">Submit</button>
        <!-- <p v-if="(name == null || startTime == null || endTime == null) == true">You are missing a required parameter silly
      (name, start time, and end time)</p> -->
        <p v-if="submitted == true">submitted!</p>

        <p style="color: red">{{ error }}</p>
      </div>
    </div>
    <br />
    <br />

  </div>
</template>

<style>
@import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:ital,wght@0,100..800;1,100..800&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap');
/* @import url('https://fonts.googleapis.com/css2?family=Smooch+Sans:wght@100..900&display=swap'); */

label {
  margin-right: 15px;
  font-size: 24px;
}

input {
  height: 26px;
  background-color: #EBEBFF;
  border-color: #3A2E87;
  border-radius: 5px;
  color: #3A2E87;
  text-align: center;
}

.required::after {
  content: "*";
  font-size: 16px;
  vertical-align: top;
  color: red;
}

.addHeader {
  color: #3A2E87;
  margin-left: 18%;
}

* {
  font-family: "JetBrains Mono";
}
</style>
