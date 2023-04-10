<template>
  <div class="login-page">
    <div class="container">
      <form form method="POST" @submit.prevent="login" class="card p-4">
        <h2 class="text-center mb-4">Login</h2>
        <div class="form-group">
          <label for="email">Email address</label>
          <input
            type="email"
            class="form-control"
            id="email"
            v-model="form.email"
            required
          />
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input
            type="password"
            class="form-control"
            id="password"
            v-model="form.password"
            required
          />
        </div>
        <button type="submit" class="btn btn-primary submit-btn btn-block">
          Sign in
        </button>
        <div class="mt-3">
          <router-link class="link" to="/register">Register</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        email: "",
        password: "",
        remember: false,
      },
    };
  },

  methods: {
    login() {
      axios
        .post("/login", this.form, {
          headers: {
            "X-CSRF-TOKEN": document
              .querySelector('meta[name="csrf-token"]')
              .getAttribute("content"),
          },
        })
        .then((response) => {
          localStorage.setItem("user", JSON.stringify(response.data.user));
          localStorage.setItem("token", response.data.token);
          this.$store.dispatch("checkAuth");
          this.$router.push({ name: "trips" });
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>

<style scoped>
.link {
  color: #ff7f50;
  text-decoration: underline;
}

.link:hover {
  color: white;
  text-decoration: none;
}

.login-page {
  background-color: #212529;
  color: #fff;
}

.card {
  background-color: #343a40;
  border: none;
  border-radius: 0.25rem;
  max-width: 800px;
  margin: 0 auto;
}

.card h2 {
  color: #fff;
}

.form-control {
  background-color: #fff;
  color: #212529;
  border: none;
  border-radius: 0.25rem;
}

.form-group {
  margin: 10px 0px;
}

.form-control:focus {
  background-color: #fff;
  color: #212529;
  border-color: #fff;
  box-shadow: none;
}
.btn-primary {
  background-color: #ff7f50;
  border-color: #ff7f50;
}

.btn-primary:hover {
  background-color: #ff6347;
  border-color: #ff6347;
}

.submit-btn {
  margin: 20px 0px;
}
</style>
