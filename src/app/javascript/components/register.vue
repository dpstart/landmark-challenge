<template>
  <v-app id="inspire">
    <v-content>
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4>
            <v-card class="elevation-12">
              <v-toolbar dark color="primary">
                <v-toolbar-title>Sign up</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form ref="form" lazy-validation>
                  <v-text-field  v-model="email" prepend-icon="person" name="email" label="Email" type="text"></v-text-field>
                  <v-text-field  v-model="password" prepend-icon="lock" name="password" label="Password" type="password"></v-text-field>
                  <v-text-field  v-model="password_confirm" prepend-icon="lock" name="password_confirm" label="Confirm Password" type="password"></v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <a color="primary" style="margin-left:10px"><router-link to="/login">LOGIN</router-link></a>
                <v-spacer></v-spacer>
                <v-btn color="primary"  @click="signup({ email, password, password_confirm })">Sign up</v-btn>
              </v-card-actions>
            </v-card>
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
              We've sent you a confirmation email.
             <v-btn flat color="pink" @click.native="snackbar = false">Close</v-btn>
            </v-snackbar>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
  export default {
    data: () => ({
      drawer: null,
      y: 'top',
      x: null,
      mode: '',
      timeout: 6000,
      

      email: "",
      password: "",
      password_confirm : "",

      success: false
    }),
    props: {
      source: String
    },

    methods: {
        signup () {

            if (this.$refs.form.validate()) {
                this.$store.dispatch("signup", {
                    email: this.email,
                    password: this.password,
                    password_confirmation: this.password_confirm
                }).then(() => {
                    console.log("Successful signup")
                    this.success = true
                    this.$refs.form.reset()
                })
                .catch((error) => {
                    console.log(error)
                    this.error = true
                });
            }
        }
    },
  
    beforeRouteEnter (to, from, next) {

        if(!!localStorage.getItem("token")){
            next(false)
        }
        else next()
    }
  }
</script>

<style scoped>

</style>
