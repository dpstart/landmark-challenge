<template>
    <v-content>
        <div>
            <v-alert :value="error" type="error" dismissible>
            ERROR
            </v-alert>
        </div>
        <v-jumbotron
            :gradient="gradient"
            src="https://vuetifyjs.com/static/doc-images/parallax/material2.jpg"
            dark
        >
            <v-container fill-height>
                <v-layout align-center>
                    <v-flex>
                        <vue-dropzone 
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

const _this = this

export default {
  name: 'app',
  components: {
    vueDropzone: vue2Dropzone
  },
  data: () => ({

      error:false,
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
                    },
        success: ((file, response)   => {
            if(response.status == "error"){
                _this.setError();
            }
            
            console.log(response.message)
        })
      }
    }),
    methods: {

        setError(){
            this.error = true;
        }
    }
}
</script>

<style scoped>

    .jumbotron {
        height: 100% !important;
    }
</style>

