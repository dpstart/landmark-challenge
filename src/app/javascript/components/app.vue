
<template>
  <div id='app'>
    <v-app id="inspire">
    <v-navigation-drawer
      v-model="drawer"
      fixed
      app
    >
      <v-toolbar flat class="transparent" v-if="isLoggedIn">
        <v-list class="pa-0">
          <v-list-tile :to="{name: 'Profile'}" @click.stop="drawer = !drawer" avatar>
            <v-list-tile-avatar>
              <img src="https://randomuser.me/api/portraits/men/85.jpg" >
            </v-list-tile-avatar>
            <v-list-tile-content>
              <v-list-tile-title>{{first_name}} {{last_name}}</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>
      </v-toolbar>
      <v-list dense>
        <v-divider></v-divider>
        <v-list-tile :to="{name: 'Home'}" @click.stop="drawer = !drawer">
          <v-list-tile-action>
            <v-icon>home</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title >Home</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
         <v-list-tile v-if="!isLoggedIn" :to="{name: 'Login'}" @click.stop="drawer = !drawer">
          <v-list-tile-action>
            <v-icon>supervisor_account</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title >Login</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile v-if="!isLoggedIn" :to="{name: 'Register'}" @click.stop="drawer = !drawer">
          <v-list-tile-action>
            <v-icon>supervisor_account</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title >Sign up</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile :to="{name: 'Drop'}" @click.stop="drawer = !drawer" v-if="isLoggedIn">
          <v-list-tile-action>
            <v-icon>cloud_upload</v-icon>
          </v-list-tile-action>
          <v-list-tile-content @click.stop="drawer = !drawer">
            <v-list-tile-title>Upload picture</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile :to="{name: 'Profile'}" @click.stop="drawer = !drawer" v-if="isLoggedIn">
          <v-list-tile-action>
            <v-icon>account_circle</v-icon>
          </v-list-tile-action>
          <v-list-tile-content @click.stop="drawer = !drawer">
            <v-list-tile-title>Profile</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile @click="logout" v-if="isLoggedIn">
          <v-list-tile-action>
            <v-icon>input</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>Logout</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>
    <v-toolbar color="primary" dark fixed app>
      <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
      <v-toolbar-title style="cursor:pointer"><router-link to="/">Landmark Challenge</router-link></v-toolbar-title>
       <v-spacer></v-spacer>
        <v-btn
          class="white--text hidden-sm-and-down"
          v-if="isLoggedIn"
          color="green"
          :to="{name: 'Drop'}"
        >
          Upload picture
          <v-icon right dark>cloud_upload</v-icon>
        </v-btn>
       <v-toolbar-items class="hidden-sm-and-down">
          <v-menu offset-y>
            <v-btn flat slot="activator" dark>
              {{ current.name }}
              <v-icon right dark>arrow_drop_down</v-icon>
              </v-btn>
            <v-list>
              <v-list-tile v-for="(item, index) in cities" :key="index" @click="current=item">
                <v-list-tile-title>{{ item.name }}</v-list-tile-title>
              </v-list-tile>
            </v-list>
          </v-menu>
          <v-btn :to="{name: 'Profile'}" flat v-if="isLoggedIn">
              Profile
          </v-btn>
          <v-btn flat @click="logout" v-if="isLoggedIn">
              Logout
          </v-btn>
          <v-btn :to="{name: 'Login'}" flat v-if="!isLoggedIn">
              Login
          </v-btn>
          <v-btn :to="{name: 'Register'}" flat v-if="!isLoggedIn">
              Signup
          </v-btn>
       </v-toolbar-items>
    </v-toolbar>

      <router-view></router-view>

    <v-footer color="primary" app>
      <span class="white--text footer-body">&copy; 2018</span>
    </v-footer>
  </v-app>
  </div>
</template>

<script>

  export default {
    data: () => ({
      drawer: false,

      cities: [],
      current:  { },

      first_name: '',
      last_name:'',
    }),

    watch: {

    //Watch for changes, then call function to handle map and cards. 
    current: {
      handler:function (newData) {
        this.getLandmarks(this.current.name)
      },
      deep:true
    }
  },

    props: {
      source: String
    },
    methods: {
      logout () {
        this.$store.dispatch('logout');
        this.$router.push('/')
        this.drawer =  false;
      },

      getLandmarks(city) {
        this.$store.dispatch("getLandmarksForCity", {city: city})
        //TODO: handle
        .catch(error => {})
      }
    },
    computed: {
      isLoggedIn () {
        return this.$store.getters.isLoggedIn;
      }
    },
    created () {
      this.$store.dispatch("getCities")
        .then ((response) => {
          this.cities = response;
          this.current = response[0]

          this.getLandmarks(this.current.name)
        })
    },
    updated () {
      /*this.$store.dispatch("profile")
        .then((response) => {
          this.first_name = response.first_name;
          this.last_name = response.last_name;
        }) 
        .catch ( (error)  => {
          //TODO: handle
        })*/
    }
  }
</script>

<style scoped>
  a, .city-btn {
    text-decoration: none;
    color: white;
  }

  .footer-body {
    margin-left: 10px;
  }

</style>


