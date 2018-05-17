import Vue from 'vue/dist/vue.esm.js'
import Vuex from 'vuex'
import axios from 'axios';

Vue.use(Vuex)

const LOGIN = "LOGIN";
const LOGIN_SUCCESS = "LOGIN_SUCCESS";
const LOGOUT = "LOGOUT";

const SIGNUP = "SIGNUP"
const SIGNUP_SUCCESS = "SIGNUP_SUCCESS"

const BASE_URL = "http://localhost:3000/"

export default new Vuex.Store({
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
    signup({ commit }, creds) {

      return new Promise((resolve,reject) => {
        axios.post( BASE_URL + 'auth',{
          email: creds.email,
          password: creds.password,
          password_confirmation: creds.password_confirm
        })
        .then(function (response) {
          console.log(response)
          resolve();
        })
        .catch( (error) => {
          let errors = error.response.data.errors.full_messages;
          reject(errors);
        });
      });
    },
    login({ commit }, creds) {
      commit(LOGIN); // show spinner

      return new Promise((resolve,reject) => {
        axios.post( BASE_URL + 'auth/sign_in',{
          email: creds.email,
          password: creds.password,
        })
        .then(function (response) {
          let token = response.headers['access-token'];
          localStorage.setItem("token", token);
          commit(LOGIN_SUCCESS);
          resolve();
        })
        .catch(function (error) {
          //console.log(error);
          reject(error);
        });
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