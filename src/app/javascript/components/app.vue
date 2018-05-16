
<template>
  <div id='app'>
    <v-app id="inspire">
    <v-navigation-drawer
      v-model="drawer"
      fixed
      app
    >
      <v-list dense>
        <v-list-tile :to="{name: 'Home'}" >
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
            <v-icon>account_circle</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>Logout</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>
    <v-toolbar color="indigo" dark fixed app>
      <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
      <v-toolbar-title style="cursor:pointer"><router-link to="/">Landmark Challenge</router-link></v-toolbar-title>
       <v-spacer></v-spacer>
       <v-toolbar-items class="hidden-sm-and-down">
          <v-btn :to="{name: 'Profile'}" icon v-if="isLoggedIn">
              <v-icon style="font-size: 35px;">account_circle</v-icon>
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

      <v-content>
       <router-view></router-view>
      </v-content>

    <v-footer color="indigo" app>
      <span class="white--text footer-body">&copy; 2018</span>
    </v-footer>
  </v-app>
  </div>
</template>

<script>


  export default {
    data: () => ({
      drawer: false
    }),
    props: {
      source: String
    },
    methods: {
      logout () {
        this.$store.dispatch('logout');
        this.drawer =  false;
      }
    },
    computed: {
      isLoggedIn () {
        return this.$store.getters.isLoggedIn;
      }
    }
  }
</script>

<style scoped>
  a {
    text-decoration: none;
    color: white;
  }

  .footer-body {
    margin-left: 10px;
  }

</style>


