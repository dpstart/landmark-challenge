
<template>
  <div id='app'>
    <v-app id="inspire">
    <v-navigation-drawer
      v-model="drawer"
      fixed
      app
    >
      <v-list dense v-if="$route.name in ['Login', 'Register']">
        <v-list-tile :to="{name: 'Home'}" @click="">
          <v-list-tile-action>
            <v-icon>home</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title >Home</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile :to="{name: 'Profile'}" @click="">
          <v-list-tile-action>
            <v-icon>account_circle</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>Profile</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>
    <v-toolbar color="indigo" dark fixed app v-if="$route.name in ['Login', 'Register']">
      <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
      <v-toolbar-title>Landmark Challenge</v-toolbar-title>
       <v-spacer></v-spacer>
        <v-btn :to="{name: 'Profile'}"icon>
            <v-icon style="font-size: 35px;">account_circle</v-icon>
        </v-btn>
       
    </v-toolbar>

      <v-content>
       <router-view></router-view>
      </v-content>

    <v-footer color="indigo" app>
      <span class="white--text">&copy; 2018</span>
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
  }
</script>


