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
              Successfully updated your profile.
             <v-btn flat color="pink" @click.native="snackbar = false; success=false;">Close</v-btn>
            </v-snackbar>

            <v-snackbar
              :timeout="timeout"
              :top="y === 'top'"
              :bottom="y === 'bottom'"
              :right="x === 'right'"
              :left="x === 'left'"
              :multi-line="mode === 'multi-line'"
              :vertical="mode === 'vertical'"
              v-model="deletion_success"
            >
              Your account was deleted. Please logout.
             <v-btn flat color="pink" @click.native="snackbar = false; success=false;">Close</v-btn>
            </v-snackbar>
      
      
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4>
            <v-card class="elevation-12">
              <v-toolbar dark color="primary">
                <v-toolbar-title>Edit Profile</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form ref="form">
                  <v-text-field  
                    :rules="emailRules" 
                    required
                    v-model="user.email" 
                    prepend-icon="person" 
                    name="email" 
                    label="Email" 
                    type="text"
                    >
                  </v-text-field>
                  <v-text-field  
                    required
                    v-model="user.first_name" 
                    prepend-icon="person" 
                    name="first_name" 
                    label="First name" 
                    type="text"
                    >
                  </v-text-field>
                  <v-text-field  
                    required
                    v-model="user.last_name" 
                    prepend-icon="person" 
                    name="last_name" 
                    label="Last name" 
                    type="text"
                    >
                  </v-text-field>
                  <v-text-field
                    v-model="user.bio"
                    name="bio"
                    label="bio"
                    textarea
                  ></v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-btn color="primary"  @click="updateProfile">EDIT</v-btn>
                <v-btn flat color="red" outline @click="deleteAccount">DELETE ACCOUNT</v-btn>
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
      edit_success: false,
      deletion_success: false
    }),
    props: {
      source: String
    },
    created() {
      this.$store.dispatch("profile")
        .then(response => {
          console.log(response);
          this.user = response
          this.user.email = localStorage.getItem("uid")
        }) 
    },
    methods: {
        updateProfile () {

            if (true) {
                this.$store.dispatch("updateProfile", {
                    first_name: this.user.first_name,
                    last_name: this.user.last_name,
                    bio: this.user.bio
                }).then(() => {
                    this.edit_success = true
                })
                .catch((errors) => {
                    console.log(errors)
                    this.errors = errors
                    this.error = true
                });
            }
        },
        deleteAccount() {
          this.$store.dispatch("deleteAccount").then(() => {
            console.log("Account deleted")
            this.deletion_success = true
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


