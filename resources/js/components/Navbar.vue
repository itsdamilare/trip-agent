<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <router-link to="/" class="navbar-brand">
        <img src="../../images/logo.png" alt="Trip Agent Logo" class="logo" />
      </router-link>
      <button
        class="navbar-toggler"
        type="button"
        data-toggle="collapse"
        data-target="#navbarNav"
        aria-controls="navbarNav"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <router-link to="/" class="nav-link">Trips</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/bookings" class="nav-link">Bookings </router-link>
          </li>
        </ul>
        <ul v-if="isLoggedIn" class="navbar-nav">
          <li class="nav-item">
            <div @click="logout" class="nav-link">Logout</div>
          </li>
        </ul>
        <ul v-else class="navbar-nav">
          <li class="nav-item">
            <router-link to="/login" class="nav-link">Login</router-link>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<style scoped>
.logo {
  width: 150px;
  height: auto;
}

.nav-link {
  color: white;
  cursor: pointer;
  font-weight: bold;
}

.navbar {
  margin-bottom: 50px;
  border: 1px solid #666;
  box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
}

.navbar-collapse {
  justify-content: flex-end;
}

@media (max-width: 767px) {
  .navbar-nav {
    flex-direction: column;
  }

  .navbar-nav .nav-item {
    margin-bottom: 10px;
  }

  .navbar-collapse {
    justify-content: center;
  }
}
</style>

<script>
import { mapState } from "vuex";

export default {
  mounted() {
    const navbarToggler = document.querySelector(".navbar-toggler");
    const navbarCollapse = document.querySelector(".navbar-collapse");

    navbarToggler.addEventListener("click", () => {
      navbarCollapse.classList.toggle("show");
    });
    this.$store.dispatch("checkAuth");
  },
  data() {
    return {};
  },
  computed: {
    ...mapState(["isLoggedIn"]),
  },
  methods: {
    logout() {
      axios
        .post("/logout", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("token"),
            "X-CSRF-TOKEN": document
              .querySelector('meta[name="csrf-token"]')
              .getAttribute("content"),
          },
        })
        .then((response) => {
          localStorage.removeItem("user", JSON.stringify(response.data.user));
          localStorage.removeItem("token", response.data.token);
          this.$store.dispatch("checkAuth");
          this.$router.push({ name: "login" });
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>
