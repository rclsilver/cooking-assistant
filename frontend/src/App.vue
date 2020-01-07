<template>
  <v-app>
    <v-navigation-drawer app clipped enable-resize-watcher v-model="drawer.visible"></v-navigation-drawer>
    <v-app-bar app clipped-left elevation="1" hide-on-scroll="false">
      <v-app-bar-nav-icon class="hidden-lg-and-up" @click.stop="drawer.visible = !drawer.visible"></v-app-bar-nav-icon>
      <v-toolbar-side-icon>
        <v-img class="mr-2" src="@/assets/logo.png" width="40px"></v-img>
      </v-toolbar-side-icon>
      <v-toolbar-title class="hidden-md-and-down">Cooking-Assistant</v-toolbar-title>
    </v-app-bar>

    <v-content>
      <HelloWorld />
    </v-content>

    <v-footer app>
      <v-layout justify-center>
        <span>
          Made with
          <span class="red--text">&#10084;</span> by Thomas Bétrancourt
        </span>
      </v-layout>
    </v-footer>
  </v-app>
</template>

<script>
import HelloWorld from "./components/HelloWorld";

export default {
  components: {
    HelloWorld
  },

  data: () => ({
    drawer: {
      visible: true,
      items: []
    }
  })
};
</script>
