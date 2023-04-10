import { createRouter, createWebHistory } from "vue-router";
import Trips from "./views/Trips.vue";
import Login from "./views/Login.vue";
import Register from "./views/Register.vue";
import Book from "./views/Book.vue";
import Edit from "./views/Edit.vue";
import Bookings from "./views/Bookings.vue";

const routes = [
  {
    path: "/",
    name: "trips",
    component: Trips,
  },
  {
    path: "/login",
    name: "login",
    component: Login,
  },
  {
    path: "/register",
    name: "register",
    component: Register,
  },
  {
    path: "/book/:id",
    name: "book",
    component: Book,
  },
  {
    path: "/edit/:id",
    name: "edit",
    component: Edit,
  },
  {
    path: "/bookings",
    name: "bookings",
    component: Bookings,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
