import Vue from 'vue/dist/vue.esm.js'
import Vuex from 'vuex'
import axios from 'axios';

Vue.use(Vuex)

const LOGIN = "LOGIN"
const LOGIN_SUCCESS = "LOGIN_SUCCESS"
const LOGIN_ERROR = "LOGIN_ERROR"
const LOGOUT = "LOGOUT"

const SIGNUP = "SIGNUP"
const SIGNUP_SUCCESS = "SIGNUP_SUCCESS"

const RETRIEVE_LANDMARKS = "RETRIEVE_LANDMARKS"

const BASE_URL = "http://localhost:3000/"

function setHeaders(response){
  //let token = response.headers['access-token'];
  let uid = response.headers['uid'];
  let client = response.headers['client'];
  //let expiry = response.headers['expiry'];
 // localStorage.setItem("token", token);
  localStorage.setItem("uid", uid);
  localStorage.setItem("client", client);
  //localStorage.setItem("expiry", expiry);
}

export default new Vuex.Store({
  
  state: {
    isLoggedIn: !!localStorage.getItem("token"),
    pending: false,
    landmarks: []
  },

  mutations: {
    [LOGIN] (state) {
      state.pending = true;
    },
    [LOGIN_SUCCESS] (state) {
      state.isLoggedIn = true;
      state.pending = false;
    },
    [LOGOUT] (state) {
      state.isLoggedIn = false;
    },
    [LOGIN_ERROR] (state) {
      state.pending = false;
    },
    [RETRIEVE_LANDMARKS] (state, data) {
      state.landmarks = data;
    }

  },
  actions: {

    profile({commit}) {
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + 'profiles?email=' + localStorage.getItem("uid"),
        { headers: { 
          'access-token':  localStorage.getItem("token"),
          uid:    localStorage.getItem("uid"),
          client: localStorage.getItem("client"),
          expiry: localStorage.getItem("expiry"),
          } 
        })
        .then(function (response) {
          setHeaders(response)
          resolve(response.data);
        })
        .catch(function (error) {
          reject(error);
        });
      });
    },
    getVisited({commit}) {
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + "landmarks/visited", 
        { headers: { 
          'access-token':  localStorage.getItem("token"),
          uid:    localStorage.getItem("uid"),
          client: localStorage.getItem("client"),
          expiry: localStorage.getItem("expiry"),
          }
        })
          .then(function (response) {
            setHeaders(response)
            resolve(response.data.landmarks)
          })
          .catch(function (error) {
            reject(error)
          });
      })
    },
    getCities({commit} ) {
        return new Promise((resolve,reject) => {
          axios.get( BASE_URL + "citys")
            .then(function (response) {
              resolve(response.data)
            })
            .catch(function (error) {
              reject(error)
            });
        })
    },
    getLandmarksForCity({commit}, data) {
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + "landmarks?city=" + data.city)
          .then(function (response) {
            commit(RETRIEVE_LANDMARKS, response.data) 
            resolve(response.data)
          })
          .catch(function (error) {
            reject(error)
          });
      })
    },
    signup({ commit }, creds) {

      return new Promise((resolve,reject) => {
        axios.post( BASE_URL + 'auth',{
          email: creds.email,
          password: creds.password,
          password_confirmation: creds.password_confirm,
          first_name: creds.first_name,
          last_name: creds.last_name
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
          
          commit(LOGIN_SUCCESS);
          let token = response.headers['access-token'];
          let uid = response.headers['uid'];
          let client = response.headers['client'];
          let expiry = response.headers['expiry'];
          localStorage.setItem("token", token);
          localStorage.setItem("uid", uid);
          localStorage.setItem("client", client);
          localStorage.setItem("expiry", expiry);
          resolve();
        })
        .catch(function (error) {
          commit(LOGIN_ERROR);
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
     },
     isPending: state => {
      return state.pending
     },
     getLandmarks: state => {
       return state.landmarks
     }
  }
});  