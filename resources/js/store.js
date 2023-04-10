import Vuex from "vuex";

export default new Vuex.Store({
  state: {
    isLoggedIn: false,
    trip: null,
  },
  mutations: {
    SET_LOGGED_IN(state, isLoggedIn) {
      state.isLoggedIn = isLoggedIn;
    },
    SET_SELECTED_TRIP(state, trip) {
      state.trip = trip;
    },
  },
  actions: {
    checkAuth({ commit }) {
      const token = localStorage.getItem("token");
      if (token) {
        commit("SET_LOGGED_IN", true);
      } else {
        commit("SET_LOGGED_IN", false);
      }
    },
    setSelectedTrip({ commit }, trip) {
      commit("SET_SELECTED_TRIP", trip);
    },
  },
  getters: {
    isLoggedIn(state) {
      return state.isLoggedIn;
    },
    getSelectedTrip: (state) => state.trip,
  },
});
