/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


import Vue from 'vue/dist/vue.esm.js'
import Vuex from 'vuex'
import Router from 'vue-router'
import Vuetify from 'vuetify'
import App from '../components/app.vue'

import Map from '../components/map.vue'
import Home from '../components/home.vue'
import Profile from '../components/profile.vue'
import Login from '../components/login.vue'
import Register from '../components/register.vue'

Vue.use(Router)


const router =  new Router({
  routes:  [
    { path: '/', name: "Home", component: Home },
    { path: '/profile', name: "Profile",  component: Profile },
    { path: '/login', name: "Login",  component: Login },
    { path: '/register', name: "Register",  component: Register}
  ]
})

Vue.component('google-map', Map)

Vue.use(Vuetify)
Vue.use(Vuex)



const LOGIN = "LOGIN";
const LOGIN_SUCCESS = "LOGIN_SUCCESS";
const LOGOUT = "LOGOUT";

const store = new Vuex.Store({
  state: {
    isLoggedIn: !!localStorage.getItem("token")
  },
  mutations: {
    [LOGIN] (state) {
      state.pending = true;
    },
    [LOGIN_SUCCESS] (state) {
      state.isLoggedIn = true;
      state.pending = false;
    },
    [LOGOUT](state) {
      state.isLoggedIn = false;
    }
  },
  actions: {
    login({ commit }, creds) {
      commit(LOGIN); // show spinner
      return new Promise(resolve => {
        setTimeout(() => {
          localStorage.setItem("token", "JWT");
          commit(LOGIN_SUCCESS);
          resolve();
        }, 1000);
      });
    },
    logout({ commit }) {
      localStorage.removeItem("token");
      commit(LOGOUT);
    }
  },
  getters: {
    isLoggedIn: state => {
      return state.isLoggedIn
     }
  }
});  

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'))

  
  const app = new Vue({
    el: 'app',
    router,
    store,
    template: '<App/>',
    components: { App }, 
  render: h => h(App)
  })
})
