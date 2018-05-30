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
            <v-btn flat color="primary">Edit</v-btn>
            <v-btn flat color="primary">Explore</v-btn>
          </v-card-actions>
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
      bio: ''
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
  created() {
  
    this.$store.dispatch("profile")
      .then( (response) => {
        console.log(response);
        this.first_name = response.first_name;
        this.last_name = response.last_name;
        this.bio = response.bio;
      })
      
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
