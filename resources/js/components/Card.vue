<template>
  <div class="card bg-dark text-white">
    <img :src="trip.image_url" class="card-img-top" alt="Trip Image" />
    <div class="card-body">
      <h5 class="card-title">{{ trip.title }}</h5>
      <p class="card-text">{{ trip.description }}</p>
      <div class="d-flex justify-content-between align-items-center mb-3">
        <p class="card-text mb-0">{{ trip.date }}</p>
        <p class="card-text mb-0 fw-bold">${{ trip.price }}</p>
      </div>
      <div class="d-flex justify-content-between align-items-center">
        <p class="card-text mb-0">
          Available Seats: {{ trip.total_seats - trip.booked_seats }}
        </p>
        <router-link
          :to="'/book/' + trip.id"
          class="btn btn-primary"
          @click="setSelectedTrip(trip)"
          >Book Now</router-link
        >
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from "vuex";
export default {
  methods: {
    ...mapActions(["setSelectedTrip"]),
  },
  props: {
    trip: Object, // specify the type of the prop
  },
};
</script>

<style scoped>
.card {
  border: none;
  border-radius: 10px;
  box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);

  transition: all 0.3s ease-in-out;
}

.card:hover {
  transform: translateY(-5px);
  box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
}

.card-title {
  font-weight: 600;
  font-size: 1.2rem;
}

.card-text {
  font-size: 0.9rem;
}

.btn-primary {
  background-color: #ff7f50;
  border-color: #ff7f50;
}

.btn-primary:hover {
  background-color: #ff6347;
  border-color: #ff6347;
}

.card-body {
  padding: 1rem;
}

.card-img-top {
  max-height: 200px;
}
</style>
