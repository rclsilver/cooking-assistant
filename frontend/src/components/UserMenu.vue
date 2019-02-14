<template>
  <v-menu
    offset-x
    offset-y
    origin="top right"
    :nudge-width="200"
  >
    <v-btn icon slot="activator">
      <v-icon>account_circle</v-icon>
    </v-btn>
    <v-card>
      <v-list>
        <v-list-tile avatar>
          <v-list-tile-avatar>
            <v-icon>account_circle</v-icon>
          </v-list-tile-avatar>
          <v-list-tile-content>
            <v-list-tile-title>{{ profile.first_name }} {{ profile.last_name }}</v-list-tile-title>
            <v-list-tile-sub-title>{{ profile.username }}</v-list-tile-sub-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-divider></v-divider>
        <v-list-tile @click="logout()">
          <v-list-tile-action>
            <v-icon>logout</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>Logout</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-card>
  </v-menu>
</template>

<script>
  export default {
    data () {
      return {
        user: {}
      }
    },
    computed: {
      profile: function() {
        return this.user
      }
    },
    mounted: function() {
      this.$api.users.get({id: 'me'}).then(response => {
        this.user = response.body
      })
    },
    methods: {
      logout() {
        this.$store.dispatch('authentication/logout')
      }
    }
  }
</script>
