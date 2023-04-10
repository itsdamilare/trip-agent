<template>
  <div class="container mt-5 pb-5">
    <div class="row content">
      <form @submit.prevent="submitForm">
        <div class="form-group">
          <label for="name">Name</label>
          <input
            type="text"
            class="form-control"
            id="name"
            v-model="form.name"
            disabled
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
          <input
            type="number"
            id="booked_seats"
            class="form-control"
            v-model="form.booked_seats"
            required
            disabled
          />
        </div>
        <button type="submit" class="btn btn-primary">Book</button>
      </form>
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
      response: null,
      validPhone: true,
      booked: false,
      trip: null,
      price: 0,
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
        this.editBooking();
      }
    },
    validatePhone() {
      if (!this.form.phone_number.match(/^\+(?:[0-9]●?){6,14}[0-9]$/)) {
        this.validPhone = false;
      } else {
        this.validPhone = true;
      }
    },
    editBooking() {
      axios
        .put(
          `/api/bookings/${this.id}`,
          { ...this.form, package_id: this.id },
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
          this.$router.push({ name: "bookings" });
        })
        .catch((error) => {
          console.log(error.response);
        });
    },
  },

  beforeRouteEnter(to, from, next) {
    if (!localStorage.getItem("token")) {
      window.location.href = "/login";
    }

    axios
      .get(`/api/bookings/${to.params.id}`, {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("token"),
          "X-CSRF-TOKEN": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
      })
      .then((response) => {
        next((vm) => {
          vm.form = response.data[0];
        });
      })
      .catch((error) => {
        console.log(error.response);
      });
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
