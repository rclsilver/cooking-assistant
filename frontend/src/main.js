import Vue from 'vue'
import '@/plugins/vuetify'
import { router } from '@/plugins/router'
import resource from '@/plugins/resource'
import cookies from '@/plugins/cookies'
import '@/plugins/drag-drop'
import '@/plugins/confirm'
import { store } from '@/store'
import App from '@/App.vue'

new Vue({
  router,
  resource,
  store,
  cookies,
  render: h => h(App)
}).$mount('#app')
