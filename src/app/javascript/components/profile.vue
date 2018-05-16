<template>
  <div class="hello">
    <v-container fluid fill-height>
      <v-layout align-center justify-center>
        <v-flex xs12 fluid class="text-xs-center">
          <v-card>
            <v-card-media  src="https://cdn.designsmaz.com/wp-content/uploads/2014/10/ceystalhorizon.png" height="300px">
            </v-card-media>
              <v-card-title class="justify-center">
                  <v-avatar class="avatar" size="150">
                    <img  src="https://vuetifyjs.com/static/doc-images/john.jpg" alt="John">
                </v-avatar>
              </v-card-title>
              <v-card-text>
                <div>
                  <h3  class="headline mb-0">John Doe</h3>
                  <div>Located two hours south of Sydney in the <br>Southern Highlands of New South Wales, ...</div>
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
 
    } 
  }  
}

</script>

<style>

  .headline {
    color: #1976D2;
  }
  .avatar {
    position: absolute;
    bottom : 85px;
  }

  .card__text {
    position: absolute;
    bottom: 30px;
  }
</style>
