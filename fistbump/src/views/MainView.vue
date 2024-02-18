<script>
import MainNavbar from '@/components/MainNavbar.vue'

export default {
  name: "MainView",
  components: {
    MainNavbar,
  }
};
</script>

<template>
  <div style="display: grid; gridTemplateColumns: 25% 75%;">
    <div style="grid-column: 1; background: blue  ; height: 100vh">
      Ligma
    </div>
    <div style="grid-column: 2; background: white; height: 100vh; overflow-y: auto; overflow-x: hidden">
      <MainNavbar />

      <p style="font-size: 500px">Sigma</p>  
      <p style="font-size: 500px">Sigma</p>  
      <p style="font-size: 500px">Sigma</p>     
    </div>
  </div>
  </template>

<style>

</style>