<template>
  <v-app id="inspire">
    <v-content>
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4>
            <v-card class="elevation-12">
              <v-toolbar dark color="primary">
                <v-toolbar-title>Login</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form>
                  <v-text-field v-model="email" prepend-icon="person" name="Email" label="Login" type="text"></v-text-field>
                  <v-text-field v-model="password" id="password" prepend-icon="lock" name="password" label="Password" type="password"></v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <a  color="primary" style="margin-left:10px">FORGOT PASSWORD</a>
                <a  color="primary"><router-link  to="/register">REGISTER</router-link></a>
                <v-spacer></v-spacer>
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
      drawer: null,
      email: "",
      password: ""
    }),
    props: {
      source: String
    },
    methods: {
        login() {
            this.$store.dispatch("login", {
                email: this.email,
                password: this.password
            }).then(() => {
                this.$router.push("/")
            });
        }
    }
  }
</script>

<style>
    a {
        margin-left:10px;
        text-decoration:none;
    }
</style>
