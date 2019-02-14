<template>
  <v-container fluid fill-height>
    <v-layout align-center justify-center>
      <v-flex xs12 sm8 md4>
        <v-card class="elevation-12">
          <v-toolbar dark color="primary">
            <v-toolbar-title>Login form</v-toolbar-title>
          </v-toolbar>
          <v-card-text>
            <v-form>
              <v-text-field prepend-icon="person" name="login" label="Username" type="text" v-model="username"></v-text-field>
              <v-text-field prepend-icon="lock" name="password" label="Password" id="password" type="password" v-model="password"></v-text-field>
            </v-form>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" :disabled="loggingIn || loggedIn" @click.prevent.stop="login()">Login</v-btn>
          </v-card-actions>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
  export default {
    data () {
      return {
        username: '',
        password: ''
      }
    },
    methods: {
      login() {
        this.$store.dispatch('authentication/login', {
          username: this.username,
          password: this.password
        })
      }
    },
    computed: {
      loggingIn() {
        return true === this.$store.state.authentication.status.loggingIn
      },
      loggedIn() {
        return true === this.$store.state.authentication.status.loggedIn
      }
    }
  }
</script>
