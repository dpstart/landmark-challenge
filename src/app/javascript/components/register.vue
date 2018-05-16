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
                <v-form>
                  <v-text-field  prepend-icon="person" name="login" label="Email" type="text"></v-text-field>
                  <v-text-field  prepend-icon="lock" name="password" label="Password" type="password"></v-text-field>
                  <v-text-field  prepend-icon="lock" name="password" label="Confirm Password" type="password"></v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <a color="primary" style="margin-left:10px"><router-link to="/login">LOGIN</router-link></a>
                <v-spacer></v-spacer>
                <v-btn color="primary">Sign up</v-btn>
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
      drawer: null
    }),
    props: {
      source: String
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
