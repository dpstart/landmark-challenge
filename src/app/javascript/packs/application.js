/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


import Vue from 'vue/dist/vue.esm.js'
import Router from 'vue-router'
import Vuetify from 'vuetify'
import App from '../components/app.vue'
import BootstrapVue from 'bootstrap-vue'


import Map from '../components/map.vue'
import Home from '../components/home.vue'
import Profile from '../components/profile.vue'
import Login from '../components/login.vue'
import Register from '../components/register.vue'
import Drop from '../components/drop.vue'
import EditProfile from '../components/edit-profile.vue'
import ChangePassword from '../components/change-password.vue'
import Landmark from '../components/landmark.vue'
import AdminDashboard from '../components/admin-dashboard.vue'
import AdminLogin from '../components/admin-login.vue'

import store from './store.js'

const LOGIN_SUCCESS = "LOGIN_SUCCESS";
const LOGIN = "LOGIN";

const router =  new Router({
  routes:  [
    { path: '/', name: "Home", component: Home },
    { path: '/profile', name: "Profile",  component: Profile },
    { path: '/profile/edit', name: "EditProfile",  component: EditProfile },
    { path: '/profile/password/edit', name: "ChangePassword", component: ChangePassword },
    { path: '/login', name: "Login",  component: Login },
    { path: '/register', name: "Register",  component: Register},
    { path: '/drop', name: "Drop",  component: Drop},
    { path: '/landmark/:name', name: "Landmark",  component: Landmark, props: true},
    { path: '/admin', name: "Admin",  component: AdminDashboard},
    { path: '/admin/login', name: "AdminLogin",  component: AdminLogin}
  ]
})


router.beforeEach((to, from, next) => {
  if (to.path === '/auth_token') {
    store.commit(LOGIN);
    localStorage.setItem('token', to.query.token);
    store.commit(LOGIN_SUCCESS);
    console.log("Redirecting...");
    next('/');
  } else next();
})

Vue.component('google-map', Map)
Vue.use(BootstrapVue);
Vue.use(Router)
Vue.use(Vuetify)


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
