<template>
  <div class="container">
    <div class="row justify-content-center">
      <div
        class="col-lg-3 col-md-4 col-sm-6 col-12 mb-4"
        v-for="trip in trips"
        :key="trip.id"
      >
        <Card :trip="trip" />
      </div>
    </div>
  </div>
</template>

<script>
import Card from "../components/Card.vue";
export default {
  created() {
    if (!localStorage.getItem("token")) {
      this.$router.push({ name: "login" });
    }
  },
  data() {
    return {
      trips: [],
    };
  },
  components: { Card },

  beforeRouteEnter(to, from, next) {
    if (!localStorage.getItem("token")) {
      window.location.href = "/login";
    }
    axios
      .get("/api/packages", {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("token"),
          "X-CSRF-TOKEN": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
      })
      .then((response) => {
        next((vm) => {
          vm.trips = response.data;
        });
      })
      .catch((error) => {
        console.log(error.response);
      });
  },
};
</script>
