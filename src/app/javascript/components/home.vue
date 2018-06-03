<template>
  <div id='home'>
        <v-layout>
            <v-flex xs12 sm6 offset-sm3>
                <google-map
                    style="width: 100%; height: 100%; position: absolute; left:0; top:0"
                    name="example"
                ></google-map>
            </v-flex>
    </v-layout>
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


