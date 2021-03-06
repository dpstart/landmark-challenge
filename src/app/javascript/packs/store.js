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
  let expiry = response.headers['expiry'];
  let client = response.headers['client'];
  let token = response.headers['token'];
  let uid = response.headers['uid'];
  //let expiry = response.headers['expiry'];
 // localStorage.setItem("token", token);
  
  if (token)
    localStorage.setItem("token", token);
  if (expiry)
    localStorage.setItem("expiry", expiry);
  if (client)
    localStorage.setItem("client", client);
  if (uid)
    localStorage.setItem("uid", uid);
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
    updateProfile({commit}, data) {
      return new Promise((resolve,reject) => {        
        axios({ method: 'post', url: BASE_URL + 'profiles/edit',data:{
            email: localStorage.getItem("uid"),
            first_name: data.first_name,
            last_name: data.last_name,
            bio: data.bio
          },
          headers: { 
              'access-token':  localStorage.getItem("token"),
              uid:    localStorage.getItem("uid"),
              client: localStorage.getItem("client"),
              expiry: localStorage.getItem("expiry"),
            } 
          })
        .then(function(response) {
          setHeaders(response)
          resolve(response.data)
        })
        .catch(function(error) {
          reject(error)
        })
      })
    },
    changePassword({commit}, data) {
      return new Promise((resolve,reject) => {        
        axios({ method: 'put', url: BASE_URL + 'auth/',data:{
            password: data.password,
            password_confirmation: data.password_confirmation
          },
          headers: { 
              'access-token':  localStorage.getItem("token"),
              uid:    localStorage.getItem("uid"),
              client: localStorage.getItem("client"),
              expiry: localStorage.getItem("expiry"),
            } 
          })
        .then(function(response) {
          setHeaders(response)
          resolve(response.data)
        })
        .catch(function(error) {
          reject(error)
        })
      })
    },
    resetPassword({commit}, data) {
      return new Promise((resolve,reject) => {        
        axios({ method: 'post', url: BASE_URL + 'auth/password',data:{
            email: data.email,
            redirect_url: 'http://localhost:3000/'
          },
          headers: { 
            } 
          })
        .then(function(response) {
          resolve(response.data)
        })
        .catch(function(error) {
          reject(error)
        })
      })
    },
    deleteAccount({commit}) {
      return new Promise((resolve,reject) => {
        axios.post( BASE_URL + 'profiles/delete?email=' + localStorage.getItem("uid") ,
          { headers: {
            'access-token':  localStorage.getItem("token"),
            uid:    localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
            expiry: localStorage.getItem("expiry"),
          }
          })
        .then(function(response) {
          console.log("Account deleted")
          setHeaders(response)
          resolve(response.data)
        })
        .catch(function(error) {
          reject(error)
        })
      })
    },
    getVisited({commit}) {
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + "landmarks/visited?email=" + localStorage.getItem("uid"), 
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
    getEarned({commit}) {
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + "profiles/achievements?email=" + localStorage.getItem("uid"), 
        { headers: { 
          'access-token':  localStorage.getItem("token"),
          uid:    localStorage.getItem("uid"),
          client: localStorage.getItem("client"),
          expiry: localStorage.getItem("expiry"),
          }
        })
          .then(function (response) {
            setHeaders(response)
            resolve(response.data.achievements)
          })
          .catch(function (error) {
            reject(error)
          });
      })
    },
    getGoals({commit}) {
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + "profiles/goals?email=" + localStorage.getItem("uid"), 
        { headers: { 
          'access-token':  localStorage.getItem("token"),
          uid:    localStorage.getItem("uid"),
          client: localStorage.getItem("client"),
          expiry: localStorage.getItem("expiry"),
          }
        })
          .then(function (response) {
            setHeaders(response)
            resolve(response.data.goals)
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
    getStats({commit}){
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + "administration/stats")
          .then(function (response) {
            resolve(response.data)
          })
          .catch(function (error) {
            reject(error)
          });
      })
    },
    getUsers({commit}){
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + "administration/users")
          .then(function (response) {
            resolve(response.data)
          })
          .catch(function (error) {
            reject(error)
          });
      })
    },
    getAdmins({commit}){
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + "administration/admins")
          .then(function (response) {
            resolve(response.data)
          })
          .catch(function (error) {
            reject(error)
          });
      })
    },
    getCities({commit}){
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + "administration/cities")
          .then(function (response) {
            resolve(response.data)
          })
          .catch(function (error) {
            reject(error)
          });
      })
    },
    getLandmarks({commit}){
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + "administration/landmarks")
          .then(function (response) {
            resolve(response.data)
          })
          .catch(function (error) {
            reject(error)
          });
      })
    },
    newCity({commit}, data){
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + "administration/new_city?name=" + data.name + "&country=" + data.country)
          .then(function (response) {
            console.log(response)
            resolve(response.data)
          })
          .catch(function (error) {
            reject(error)
          });
      })
    },
    newAdmin({commit}, data){
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + "administration/new_admin?email=" + data.email + "&password=" + data.password)
          .then(function (response) {
            console.log(response)
            resolve(response.data)
          })
          .catch(function (error) {
            reject(error)
          });
      })
    },
    newLandmark({commit}, data){
      return new Promise((resolve,reject) => {
        axios.get( BASE_URL + 
          "administration/new_landmark?name=" + data.name + "&description=" + data.description + "&city=" + data.city +
          "&latitude=" + data.latitude + "&longitude=" + data.longitude)
          .then(function (response) {
            console.log(response)
            resolve(response.data)
          })
          .catch(function (error) {
            reject(error)
          });
      })
    },
    loginAdmin({ commit }, creds) {
      commit(LOGIN); // show spinner

      return new Promise((resolve,reject) => {
        axios.post( BASE_URL + 'admin/auth/sign_in',{
          email: creds.email,
          password: creds.password,
        })
        .then(function (response) {
          
          commit(LOGIN_SUCCESS);
          let token = response.headers['access-token'];
          let uid = response.headers['uid'];
          let client = response.headers['client'];
          let expiry = response.headers['expiry'];
          localStorage.setItem("admin-token", token);
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
    },
    delete_user({commit},email){
      axios.post(BASE_URL + 'profiles/delete',{email: email})
      .then(function (response) {
        console.log(response)
        resolve(response.data)
      })
      .catch(function (error) {
        reject(error)
      });
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