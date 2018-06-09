<template>
  <v-app id="inspire">
    <v-content>
      <div>
        <v-alert v-model="error" type="error" dismissible>
          Log in error.
        </v-alert>
      </div>
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4>
            <v-card class="elevation-12">
              <v-toolbar dark color="primary">
                <v-toolbar-title>Admin Login</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form ref="form" lazy-validation>
                  <v-text-field 
                    :rules="emailRules" 
                    required v-model="email" 
                    prepend-icon="person" 
                    name="Email" 
                    label="Email" 
                    type="text"
                    >
                  </v-text-field>
                  <v-text-field 
                    :rules="passwordRules" 
                    required 
                    v-model="password" 
                    id="password" 
                    prepend-icon="lock" 
                    name="password" 
                    label="Password" 
                    type="password">
                  </v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-progress-circular v-if="isPending" indeterminate color="primary"></v-progress-circular>
                <v-btn @click="login({ email, password })" color="primary">Login</v-btn>
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
      error: false,
      alert: true,
      drawer: null,

      email: "",
      emailRules: [
        v => !!v || 'E-mail is required',
        v => /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) || 'E-mail must be valid'
      ],
      password: "",
      passwordRules: [
          v => !!v || 'Password is required',
      ]
    }),
    props: {
      source: String
    },
    methods: {
        login() {

            if (this.$refs.form.validate()) {
                this.$store.dispatch("loginAdmin", {
                    email: this.email,
                    password: this.password
                }).then(() => {
                    this.$router.push("/admin")
                })
                .catch((error) => {
                    console.log("Errore")
                    console.log(error)
                    this.error = true
                });
            }
        }
    },

    computed: {

      isPending () {
        return this.$store.getters.isPending;
      }
    },
    beforeRouteEnter (to, from, next) {
    // called before the route that renders this component is confirmed.
    // does NOT have access to `this` component instance,
    // because it has not been created yet when this guard is called!
        if(!!localStorage.getItem("admin-token")){
            next(false)
        }
        else next()
    },
  }
</script>

<style>
    a {
        margin-left:10px;
        text-decoration:none;
    }

    .alert {
      margin-top: 0 !important;
    }
</style>
