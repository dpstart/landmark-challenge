<template>
  <v-app id="edit">
    <v-content>
      <div>
        <v-alert v-model="errors" :key="index" v-for="(error, index) in errors" type="error" dismissible>
          {{error}}
        </v-alert>
      </div>

            <v-snackbar
              :timeout="timeout"
              :top="y === 'top'"
              :bottom="y === 'bottom'"
              :right="x === 'right'"
              :left="x === 'left'"
              :multi-line="mode === 'multi-line'"
              :vertical="mode === 'vertical'"
              v-model="success"
            >
              We've sent you a reset password email.
             <v-btn flat color="pink" @click.native="snackbar = false; success=false;">Close</v-btn>
            </v-snackbar>
      
      
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4>
            <v-card class="elevation-12">
              <v-toolbar dark color="primary">
                <v-toolbar-title>Reset password</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form ref="form">
                  <v-text-field  
                    required
                    v-model="email" 
                    prepend-icon="person" 
                    name="email" 
                    label="Email" 
                    type="text"
                    >
                  </v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-btn color="primary"  @click="resetPassword">RESET PASSWORD</v-btn>
              </v-card-actions>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
  export default {
    data: () => ({
      email: '',
      success: false
    }),
    props: {
      source: String
    },
    methods: {
      resetPassword () {

                this.$store.dispatch("resetPassword", {
                    email: this.email
                }).then(() => {
                    this.success = true
                })
                .catch((errors) => {
                    console.log(errors)
                    this.errors = errors
                    this.error = true
                });
            
        }
    }
  }
</script>
