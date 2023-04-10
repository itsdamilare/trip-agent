<template>
  <div class="container">
    <h1>All Bookings</h1>
    <table class="table">
      <thead>
        <tr>
          <th>Booking ID</th>
          <th>Package Name</th>
          <th>Booked Seats</th>
          <th>Price</th>
          <th>Name</th>
          <th>Phone Number</th>
          <th>Email Address</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr
          class="text-light"
          v-for="(booking, index) in bookings"
          :key="booking.id"
        >
          <td>{{ index + 1 }}</td>
          <td>
            {{ packages.find((x) => x.id === booking.package_id).title }}
          </td>
          <td>{{ booking.booked_seats }}</td>
          <td>{{ booking.price }}</td>
          <td>{{ booking.name }}</td>
          <td>{{ booking.phone_number }}</td>
          <td>{{ booking.email_address }}</td>
          <td>
            <router-link class="link px-3 py-2" :to="'/edit/' + booking.id">
              Edit
            </router-link>
            <span class="link p-2" @click="deleteBooking(booking.id)">
              Delete
            </span>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  data() {
    return {
      bookings: [],
      packages: [],
    };
  },
  beforeRouteEnter(to, from, next) {
    if (!localStorage.getItem("token")) {
      window.location.href = "/login";
    }
    let bookings = [];
    axios
      .get("/api/bookings", {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("token"),
          "X-CSRF-TOKEN": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
      })
      .then((response) => {
        bookings = response.data;
      })
      .catch((error) => {
        console.log(error.response);
      });
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
          vm.packages = response.data;
          vm.bookings = bookings;
        });
      })
      .catch((error) => {
        console.log(error.response);
      });
  },

  methods: {
    deleteBooking(id) {
      axios
        .delete(`/api/bookings/${id}`, {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("token"),
            "X-CSRF-TOKEN": document
              .querySelector('meta[name="csrf-token"]')
              .getAttribute("content"),
          },
        })
        .then((response) => {
          this.bookings.splice(
            this.bookings.findIndex((x) => x.id === id),
            1
          );
        })
        .catch((error) => {
          console.log(error.response);
        });
    },
  },
};
</script>

<style scoped>
.container,
.table,
.text-light {
  color: #fff !important;
}

.link {
  color: #fff !important;
  text-decoration: underline;
  cursor: pointer;
}
</style>
