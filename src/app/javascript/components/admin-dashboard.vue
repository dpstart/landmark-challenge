<template>
  <v-app id="inspire">
    <v-content>
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs5 fluid class="text-xs-center">
            <v-card>
              <v-card-title><h4>Stats</h4></v-card-title>
              <v-divider></v-divider>
              <v-list dense>
                <v-list-tile>
                  <v-list-tile-content><b>Users</b></v-list-tile-content>
                  <v-list-tile-content class="align-end">{{ stats.users }}</v-list-tile-content>
                </v-list-tile>
                <v-list-tile>
                  <v-list-tile-content><b>Admin</b></v-list-tile-content>
                  <v-list-tile-content class="align-end">{{ stats.admins }}</v-list-tile-content>
                </v-list-tile>
                <v-list-tile>
                  <v-list-tile-content><b>Landmarks</b></v-list-tile-content>
                  <v-list-tile-content class="align-end">{{ stats.landmarks }}</v-list-tile-content>
                </v-list-tile>
                <v-list-tile>
                  <v-list-tile-content><b>Achievements</b></v-list-tile-content>
                  <v-list-tile-content class="align-end">{{ stats.achievements }}</v-list-tile-content>
                </v-list-tile>
                <v-list-tile>
                  <v-list-tile-content><b>Cities</b></v-list-tile-content>
                  <v-list-tile-content class="align-end">{{ stats.cities }}</v-list-tile-content>
                </v-list-tile>
              </v-list>
          </v-card>
          <br>
          <v-card>
              <div>
                  <v-alert v-model="addCityError" type="error" dismissible>
                  Error.
                  </v-alert>
                  <v-alert v-model="addCitySuccess" type="success" dismissible>
                  Success.
                  </v-alert>
                </div>
              <v-toolbar dark color="primary">
                <v-toolbar-title>Add city</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form ref="form" lazy-validation>
                  <v-text-field   
                    type="text"
                    label="Name" 
                    required v-model="city.name" 
                    >
                  </v-text-field>
                  <v-text-field   
                    type="text"
                    label="Country" 
                    required v-model="city.country" 
                    >
                  </v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-btn @click="addCity({ city })" color="primary">Add</v-btn>
              </v-card-actions>
            </v-card>
            <br>
          <v-card>
              <div>
                  <v-alert v-model="addAdminError" type="error" dismissible>
                  Error.
                  </v-alert>
                  <v-alert v-model="addAdminSuccess" type="success" dismissible>
                  Success.
                  </v-alert>
                </div>
              <v-toolbar dark color="primary">
                <v-toolbar-title>Add admin</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form ref="form" lazy-validation>
                  <v-text-field   
                    type="text"
                    label="Email" 
                    required v-model="admin.email" 
                    >
                  </v-text-field>
                  <v-text-field   
                    type="password"
                    label="Password" 
                    required v-model="admin.password" 
                    >
                  </v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-btn @click="addAdmin({ admin })" color="primary">Add</v-btn>
              </v-card-actions>
            </v-card>
            <br>
            <v-card>
                <div>
                  <v-alert v-model="addLandmarkError" type="error" dismissible>
                  Error.
                  </v-alert>
                  <v-alert v-model="addLandmarkSuccess" type="success" dismissible>
                  Success.
                  </v-alert>
                </div>
                <v-toolbar dark color="primary">
                  <v-toolbar-title>Add landmark</v-toolbar-title>
                </v-toolbar>
                <v-card-text>
                  <v-form ref="form" lazy-validation>
                    <v-text-field   
                      type="text"
                      label="Name" 
                      required v-model="landmark.name" 
                      >
                    </v-text-field>
                    <v-text-field   
                      type="text"
                      label="Description" 
                      required v-model="landmark.description" 
                      >
                    </v-text-field>
                    <v-text-field   
                      type="text"
                      label="City" 
                      required v-model="landmark.city" 
                      >
                    </v-text-field>
                    <v-text-field   
                      type="text"
                      label="Latitude" 
                      required v-model="landmark.latitude" 
                      >
                    </v-text-field>
                    <v-text-field   
                      type="text"
                      label="Longitude" 
                      required v-model="landmark.longitude" 
                      >
                    </v-text-field>
                  </v-form>
                </v-card-text>
                <v-card-actions>
                  <v-btn @click="addLandmark({ landmark })" color="primary">Add</v-btn>
                </v-card-actions>
              </v-card>
          </v-flex>
          <v-flex xs5 offset-xs1 fluid class="text-xs-center">
            <v-card>
              <v-card-title><h4>Users</h4></v-card-title>
              <v-divider></v-divider>
              <v-list dense>
                <v-list-tile v-for="(item, index) in users">
                  <v-list-tile-content><b>{{item.email}}</b></v-list-tile-content>
                  <v-layout row justify-center>
                    <v-btn color="primary" dark @click.native.stop="dialog = true">Delete User</v-btn>
                    <v-dialog v-model="dialog" max-width="290">
                      <v-card>
                        <v-card-title class="headline">Are you sure you want delete this user?</v-card-title>
                        <v-card-actions>
                          <v-spacer></v-spacer>
                          <v-btn color="green darken-1" flat="flat" @click.native="dialog = false">No</v-btn>
                          <v-btn color="green darken-1" flat="flat" @click.native="yes(item.email)">Yes</v-btn>
                        </v-card-actions>
                      </v-card>
                    </v-dialog>
                  </v-layout>
                </v-list-tile>
              </v-list>
            </v-card>
          <br>
            <v-card>
              <v-card-title><h4>Admins</h4></v-card-title>
              <v-divider></v-divider>
              <v-list dense>
                <v-list-tile v-for="(item, index) in admins">
                  <v-list-tile-content><b>{{item.email}}</b></v-list-tile-content>
                </v-list-tile>
              </v-list>
            </v-card>
            <br>
            <v-card>
              <v-card-title><h4>Landmarks</h4></v-card-title>
              <v-divider></v-divider>
              <v-list dense>
                <v-list-tile v-for="(item, index) in landmarks">
                  <v-list-tile-content><b>{{item.name}}</b></v-list-tile-content>
                  <v-list-tile-content class="align-end"><i>{{ item.latitude }} - {{item.longitude}}</i></v-list-tile-content>
                </v-list-tile>
              </v-list>
            </v-card>
            <br>
            <v-card>
              <v-card-title><h4>Cities</h4></v-card-title>
              <v-divider></v-divider>
              <v-list dense>
                <v-list-tile v-for="(item, index) in cities">
                  <v-list-tile-content><b>{{item.name}}</b></v-list-tile-content>
                  <v-list-tile-content class="align-end"><i>{{ item.country }}</i></v-list-tile-content>
                </v-list-tile>
              </v-list>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
    </v-app>
  </div>
</template>

<script>
export default {
  name: 'hello',
  data: function () {
    return {
      stats: {},
      users: [],
      admins: [],
      landmarks: [],
      cities: [],
      city: {name:'', country:''},
      admin: {email:'', password: ''},
      landmark: {name:'', description:'', city:'', latitude:'', longitude:''},
      dialog: false,
      
      addCityError: false,
      addCitySuccess: false,
      addAdminError: false,
      addAdminSuccess: false,
      addLandmarkError: false,
      addLandmarkSuccess: false,

    }

  },
  created() {
    this.$store.dispatch("getStats")
    .then( (response) => {
      this.stats = response;
    })

    this.$store.dispatch("getUsers")
    .then( (response) => {
      console.log(response);
      this.users = response;
    })

    this.$store.dispatch("getAdmins")
    .then( (response) => {
      console.log(response);
      this.admins = response;
    })
    this.$store.dispatch("getLandmarks")
    .then( (response) => {
      console.log(response);
      this.landmarks = response;
    })
    this.$store.dispatch("getCities")
    .then( (response) => {
      console.log(response);
      this.cities = response;
    })
  },
  methods: {

    addCity(){
      this.$store.dispatch('newCity', this.city)
        .then(response => this.addCitySuccess = true)
        .catch(error=> this.addCityError = true)
    },

    addAdmin(){
      this.$store.dispatch('newAdmin', this.admin)
        .then(response => this.addAdminSuccess = true)
        .catch(error=> this.addAdminError = true)
    },

    addLandmark(){
      this.$store.dispatch('newLandmark', this.landmark)
        .then(response => this.addLandmarkSuccess = true)
        .catch(error => this.addLandmarkError = true)
    },
    yes(email){
      this.dialog = false;
      this.$store.dispatch("delete_user",email)
    }
  },
  beforeRouteEnter (to, from, next) {
  // called before the route that renders this component is confirmed.
  // does NOT have access to `this` component instance,
  // because it has not been created yet when this guard is called!
      if(!(!!localStorage.getItem("admin-token"))){
        next({ path: '/admin/login' })
      }
      else next()
  }
}

</script>

<style scoped>

  .headline {
    color: #1976D2;
  }
  .vavatar {
    bottom : 85px;
  }

  .cardtext {
    position:absolute;
    bottom: 30px;
  }
</style>
