<template>
  <v-app>
    <v-navigation-drawer
      clipped
      fixed
      v-model="drawer"
      app
      enable-resize-watcher
    >
      <v-list dense class="pt-0">
        <v-list-tile to="/">
          <v-list-tile-action>
            <v-icon>dashboard</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>Home</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>

        <v-list-tile
          v-for="(item, itemIndex) in items"
          :key="itemIndex"
          :to="item.to"
        >
          <v-list-tile-action>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>{{ item.title }}</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>

        <v-list-tile to="/about">
          <v-list-tile-action>
            <v-icon>info</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>About</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>
    <v-toolbar app fixed clipped-left>
      <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
      <v-toolbar-title>
        <v-avatar size="32">
          <img src="./assets/logo.png">
        </v-avatar>
        Cooking Assistant
      </v-toolbar-title>
    </v-toolbar>
    <v-content>
      <v-container fluid>
        <v-alert :value="alert.message" :type="alert.type">{{ alert.message }}</v-alert>
        <router-view/>
      </v-container>
    </v-content>
    <v-footer app fixed>
      <span>Thomas Bétrancourt - 2019</span>
    </v-footer>
  </v-app>
</template>

<script>
  export default {
    name: 'App',
    components: {},
    data () {
      return {
        drawer: true,
        items: []
      }
    }
  }
</script>
