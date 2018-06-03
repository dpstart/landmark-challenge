<template>
  <div class="landmark">
    <v-content>
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md8>
            <v-card>
            <v-card-media  src="https://s3.amazonaws.com/iexplore_web/images/assets/000/005/495/original/dreamstime_m_9856207.jpg?1442331489" height="300px">
            </v-card-media>
              <v-card-title class="justify-center">
                <h3  class="headline mb-0">{{computedData.name}}</h3>
              </v-card-title>
              <v-card-text class="cardtext">
                <div>
                  <div>{{computedData.description}}</div>
                </div>
              </v-card-text>
          <v-card-actions>
          </v-card-actions>
          </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
  </div>
</template>

<script>
  export default {
    data: () => ({
      name: ''
    }),
    props: ["data"],

    mounted () {
      this.name = this.$route.params.name
    },
    computed: {
        computedData: function () {
            if ( this.data != null ) {
                console.log(this.data)
                return this.data
            }

            return 'defaultData';
        }
    }
  }
</script>

