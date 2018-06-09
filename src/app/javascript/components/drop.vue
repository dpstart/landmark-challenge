<template>
    <v-content>
        <v-jumbotron
            :gradient="gradient"
            src="https://vuetifyjs.com/static/doc-images/parallax/material2.jpg"
            dark
        >
            <v-container fill-height>
                <v-layout align-center>
                    <v-flex>
                        <div>
                            <v-alert v-model="error" type="error" dismissible>
                            Error: {{errorMessage}}.
                            </v-alert>
                            <v-alert v-model="success" type="success" dismissible>
                            You visited {{landmarkName}}.
                            </v-alert>
                         </div>
                        <vue-dropzone 
                            v-on:vdropzone-success="successVisited"
                            ref="myVueDropzone" 
                            id="dropzone" 
                            :options="dropzoneOptions"
                        >
                        </vue-dropzone>
                    </v-flex>
                </v-layout>
            </v-container>
        </v-jumbotron>
    </v-content>
</template>

<script>
import vue2Dropzone from 'vue2-dropzone'
import 'vue2-dropzone/dist/vue2Dropzone.min.css'

const LANMDMARK_DETECTION_URL = 'http://localhost:3000/landmark_detection'


export default {
  name: 'app',
  components: {
    vueDropzone: vue2Dropzone
  },
  data: () => ({

      error:false,
      errorMessage: '',
      success: false,
      landmarkName: '',
      gradient: 'to top right, rgba(63,81,181, .7), rgba(25,32,72, .7)',
      dropzoneOptions: {
          url: LANMDMARK_DETECTION_URL,
          thumbnailWidth: 220,
          maxFilesize: 0.5,
          headers: {"access-token":localStorage.getItem("token"),
                    "expiry":localStorage.getItem("expiry"),
                    "client":localStorage.getItem("client"),
                    "token-type":"Bearer",
                    "uid":localStorage.getItem("uid")
                    }
      }
    }),
    methods:  {
        successVisited(file, response){
            if(response.status == "error"){
                console.log("Error")
                this.error = true
                this.errorMessage = response.message 
            } else {
                this.success = true;
                this.landmarkName = response.landmark.name;
            }
            console.log(response)
        }
    }
}
</script>

<style scoped>

    .jumbotron {
        height: 100% !important;
    }
</style>

