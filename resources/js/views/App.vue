<template>
  <div id="app" class="bg-dark">
    <Navbar />
    <router-view />
  </div>
</template>

<script>
import { defineComponent } from "vue";
import Navbar from "../components/Navbar.vue";

export default defineComponent({
  name: "App",
  components: { Navbar },
  mounted() {
    // Do something on component mount
  },
});
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  min-height: 100vh;
}
</style>
