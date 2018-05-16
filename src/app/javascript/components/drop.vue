<template>
    <v-jumbotron
        :gradient="gradient"
        src="https://vuetifyjs.com/static/doc-images/parallax/material2.jpg"
        dark
    >
        <v-container fill-height>
            <v-layout align-center>
                <v-flex>
                    <vue-dropzone ref="myVueDropzone" id="dropzone" :options="dropzoneOptions"></vue-dropzone>
                </v-flex>
            </v-layout>
        </v-container>
    </v-jumbotron>
</template>

<script>
import vue2Dropzone from 'vue2-dropzone'
import 'vue2-dropzone/dist/vue2Dropzone.min.css'


export default {
  name: 'app',
  components: {
    vueDropzone: vue2Dropzone
  },
  data: function () {
    return {
      gradient: 'to top right, rgba(63,81,181, .7), rgba(25,32,72, .7)',
      dropzoneOptions: {
          url: 'https://httpbin.org/post',
          thumbnailWidth: 220,
          maxFilesize: 0.5,
          
         // headers: { "My-Awesome-Header": "header value" }
      }
    }
  }
}
</script>

<style scoped>

    .jumbotron {
        height: 100% !important;
    }
</style>

