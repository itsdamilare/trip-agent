<template>
  <div class="container mt-5 pb-5">
    <div v-if="!booked" class="row content">
      <h1 class="text-center mb-3">{{ trip ? trip.title : "" }}</h1>
      <div v-if="trip" class="trip-content">
        <div class="card bg-dark text-white">
          <img :src="trip.image_url" class="card-img-top" alt="Trip Image" />
          <div class="card-body">
            <p class="card-text">{{ trip.description }}</p>
            <div class="d-flex justify-content-between align-items-center mb-3">
              <p class="card-text mb-0">{{ trip.date }}</p>
              <p class="card-text mb-0 fw-bold">${{ trip.price }}</p>
            </div>
            <div class="d-flex justify-content-between align-items-center">
              <p class="card-text mb-0">Available Seats:{{ availableSeats }}</p>
            </div>
          </div>
        </div>
      </div>

      <form @submit.prevent="submitForm">
        <div class="form-group">
          <label for="name">Name</label>
          <input
            type="text"
            class="form-control"
            id="name"
            v-model="form.name"
            required
          />
        </div>
        <div class="form-group">
          <label for="email">Email</label>
          <input
            type="email"
            class="form-control"
            id="email"
            v-model="form.email_address"
            required
          />
        </div>
        <div class="form-group">
          <label for="phone">Phone Number</label>

          <input
            type="tel"
            class="form-control"
            id="phone"
            v-model="form.phone_number"
            required
            pattern="^\+(?:[0-9]●?){6,14}[0-9]$"
            @input="validatePhone"
          />
          <div v-if="!validPhone">Please enter a valid phone number.</div>
        </div>
        <div class="form-group">
          <label for="message">Number of Tickets</label>
          <select
            id="bookedSeats"
            class="form-control"
            v-model="form.booked_seats"
            required
          >
            <option v-for="i in availableOptions" :key="i" :value="i">
              {{ i }}
            </option>
          </select>
        </div>
        <button type="submit" class="btn btn-primary">Book</button>
      </form>
    </div>
    <div class="container mt-5 pb-5" v-else>
      <div class="row content">
        <h1 class="text-center mb-3">{{ trip ? trip.title : "" }}</h1>
        <div v-if="trip" class="trip-content">
          <div class="card bg-dark text-white">
            <img :src="trip.image_url" class="card-img-top" alt="Trip Image" />
            <div class="fs-4 card-body">Booking successful!</div>

            <router-link to="/">
              <button class="fw-bold btn btn-primary mb-5">
                Back to Trips
              </button>
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        name: "",
        email_address: "",
        phone_number: "",
        booked_seats: 1,
        id: "",
      },
      validPhone: true,
      booked: false,
      trip: null,
    };
  },
  computed: {
    id() {
      return this.$route.params.id;
    },
    availableSeats() {
      return this.trip?.total_seats - this.trip?.booked_seats || 0;
    },
    availableOptions() {
      const maxOptions = 10;
      const maxAvailable = Math.min(this.availableSeats, maxOptions);
      return Array.from({ length: maxAvailable }, (_, i) => i + 1);
    },
  },

  methods: {
    submitForm() {
      if (this.validPhone) {
        this.makeBooking();
      }
    },
    validatePhone() {
      if (!this.form.phone_number.match(/^\+(?:[0-9]●?){6,14}[0-9]$/)) {
        this.validPhone = false;
      } else {
        this.validPhone = true;
      }
    },
    getTripData() {
      axios
        .get(`/api/packages/${this.id}`, {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("token"),
            "X-CSRF-TOKEN": document
              .querySelector('meta[name="csrf-token"]')
              .getAttribute("content"),
          },
        })
        .then((response) => {
          this.trip = response.data;
        })
        .catch((error) => {
          console.log(error.response);
        });
    },
    makeBooking() {
      axios
        .post(
          `/api/bookings`,
          {
            ...this.form,
            price: this.trip.price * this.form.booked_seats,
            package_id: this.id,
          },
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("token"),
              "X-CSRF-TOKEN": document
                .querySelector('meta[name="csrf-token"]')
                .getAttribute("content"),
            },
          }
        )
        .then((response) => {
          this.booked = true;
        })
        .catch((error) => {
          console.log(error.response);
        });
    },
  },
  mounted() {
    this.getTripData();
  },
};
</script>

<style scoped>
/* Add custom styles for this component here */
</style>

<style scoped>
.content {
  background-color: #343a40;
  border: none;
  color: #fff;
  border-radius: 0.25rem;
  max-width: 600px;
  padding: 20px;
  margin: 20px auto;
}

.trip-content {
  margin: 0 auto;
}
.btn-primary {
  margin-top: 20px;
  background-color: #ff7f50;
  border-color: #ff7f50;
}

.btn-primary:hover {
  background-color: #ff6347;
  border-color: #ff6347;
}

.form-control {
  background-color: #fff;
  color: #212529;
  border: none;
  border-radius: 0.25rem;
}

.form-group {
  margin: 30px 0px;
  text-align: left;
}

.form-control:focus {
  background-color: #fff;
  color: #212529;
  border-color: #fff;
  box-shadow: none;
}

.card-img-top {
  max-height: 350px;
}
</style>
