<template>
  <div class="hello">
    <v-container fluid fill-height>
      <v-layout align-center justify-center>
        <v-flex xs12 fluid class="text-xs-center">
          <v-card>
            <v-card-media  src="https://cdn.designsmaz.com/wp-content/uploads/2014/10/ceystalhorizon.png" height="300px">
            </v-card-media>
              <v-card-title class="justify-center">
                  <v-avatar class="vavatar" size="150">
                    <img  src="https://vuetifyjs.com/static/doc-images/john.jpg" alt="John">
                </v-avatar>
              </v-card-title>
              <v-card-text class="cardtext">
                <div>
                  <h3  class="headline mb-0">{{first_name}} {{last_name}}</h3>
                  <div>{{bio}}</div>
                </div>
              </v-card-text>
          <v-card-actions>
            <v-btn flat color="primary" :to="{name: 'EditProfile'}">Edit</v-btn>
          </v-card-actions>
          </v-card>
          </v-flex>
      </v-layout>
    </v-container>
    <v-container fluid fill-height>
      <v-layout align-center justify-center>
        <v-flex xs12 fluid class="text-xs-center">
          <v-card v-if="hasVisited">
            <v-toolbar color="cyan" dark>
              <v-toolbar-title>Places you visited</v-toolbar-title>
            </v-toolbar>
            <v-list three-line>
              <template v-for="(item, index) in visited">
                <v-list-tile  :key="item.name" avatar>
                  <v-list-tile-avatar>
                    <img :src="item.img_URL">
                  </v-list-tile-avatar>
                  <v-list-tile-content>
                    <v-list-tile-title v-html="item.name"></v-list-tile-title>
                    <v-list-tile-sub-title v-html="item.description"></v-list-tile-sub-title>
                    <v-list-tile-sub-title><i>{{item.latitude}}  -  {{item.longitude}}</i></v-list-tile-sub-title>
                  </v-list-tile-content>
                </v-list-tile>
              </template>
            </v-list>
          </v-card>
          <v-card>
            <v-toolbar color="cyan" dark>
              <v-toolbar-title>Achievements you earned</v-toolbar-title>
            </v-toolbar>
            <v-list three-line>
              <template v-for="(item, index) in earned">
                <v-list-tile  :key="item.name" avatar>
                  <v-list-tile-content>
                    <v-list-tile-title v-html="item.name"></v-list-tile-title>
                    <v-list-tile-sub-title v-html="item.description"></v-list-tile-sub-title>
                    <v-list-tile-sub-title v-html="item.color"></v-list-tile-sub-title>
                  </v-list-tile-content>
                </v-list-tile>
              </template>
            </v-list>
          </v-card>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
export default {
  name: 'hello',
  data: function () {
    return {
      
      
      first_name: '',
      last_name: '',
      bio: '',

      visited: {},
      earned:{}
    } 
  },
  beforeRouteEnter (to, from, next) {
  // called before the route that renders this component is confirmed.
  // does NOT have access to `this` component instance,
  // because it has not been created yet when this guard is called!
      if(!(!!localStorage.getItem("token"))){
          next(false)
      }
      else next()
  },

  computed: {
    hasVisited: function () { return this.visited.length > 0 }
  },

  created() {
    this.$store.dispatch("profile")
      .then( (response) => {
        console.log(response);
        this.first_name = response.first_name;
        this.last_name = response.last_name;
        this.bio = response.bio;
      }) 
  },
  mounted() {
      this.$store.dispatch("getVisited")
        .then(response => {this.visited = response;
        console.log(this.visited);
        console.log(response)}),
      this.$store.dispatch("getEarned")
        .then(response => {this.earned = response;
        console.log("eranred")
        console.log(this.earned);
        console.log(response)})
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
