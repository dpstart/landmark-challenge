<template>
  <div class="landmark">
    <v-content>
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4>
            <div>{{computedData.name}}</div>
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


