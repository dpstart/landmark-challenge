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
              v-model="edit_success"
            >
              Successfully updated your password.
             <v-btn flat color="pink" @click.native="snackbar = false; success=false;">Close</v-btn>
            </v-snackbar>
      
      
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4>
            <v-card class="elevation-12">
              <v-toolbar dark color="primary">
                <v-toolbar-title>Change password</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form ref="form">
                  <v-text-field  
                    required
                    v-model="user.password" 
                    prepend-icon="person" 
                    name="password" 
                    label="New password" 
                    type="password"
                    >
                  </v-text-field>
                  <v-text-field  
                    required
                    v-model="user.password_confirmation" 
                    prepend-icon="person" 
                    name="password_confirmation" 
                    label="Confirm new password" 
                    type="password"
                    >
                  </v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-btn color="primary"  @click="changePassword">CHANGE PASSWORD</v-btn>
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
      user: {},
      edit_success: false
    }),
    props: {
      source: String
    },
    methods: {
        changePassword () {

                this.$store.dispatch("changePassword", {
                    password: this.user.password,
                    password_confirmation: this.user.password_confirmation
                }).then(() => {
                    this.edit_success = true
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


