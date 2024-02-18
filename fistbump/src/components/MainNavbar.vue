<script>
export default {
  name: "MainNavbar",
};

</script>

<template>
  <nav style="position: fixed; width: 74.05%; background: white; display: block">
    <div style="float: left; display: flex; margin-top: 10px; margin-left: 10px;">
      <img src="@\assets\Logo.png" width="75px" height="75px">
      <h1 class="logo">fist<b>bump</b></h1>
    </div>
    <div style="float: right; margin-top: 20px; margin-right: 80px;">
      <RouterLink to="/leader">
        <button class="button">
          Manage
        </button>
      </RouterLink>
    </div>
  </nav>
</template>

<style>
@import url('https://fonts.googleapis.com/css2?family=Smooch+Sans:wght@100..900&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Averia+Serif+Libre:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&family=Smooch+Sans:wght@100..900&display=swap');

.logo {
  font-family: "Smooch Sans", sans-serif;
  font-size: 48px;
  margin: auto;
  padding: 7px;
  text-align: center;
  letter-spacing: 3px;
  font-weight: 350;
}

.button {
  font-family: "Averia Serif Libre", serif;
  margin: 2px;
  padding: 10px;
  padding-left: 40px;
  padding-right: 40px;
  font-size: 19px;
  background: #FFD464;
  border: none;
  border-radius: 5px;
  transition: 0.4s;
}

.button:hover {
  cursor: pointer;
  background: var(--purple);
}
</style>