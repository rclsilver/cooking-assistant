import Vue from 'vue'
import VuetifyConfirm from 'vuetify-confirm'

Vue.use(VuetifyConfirm, {
  buttonTrueText: 'OK',
  buttonFalseText: 'On, ho',
  color: 'warning',
  icon: 'warning',
  title: 'Warning',
  width: 300,
  property: '$confirm'   
})
