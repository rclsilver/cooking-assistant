import Vue from 'vue'
import { userService } from '../services/user.service'

let API = {
  install: function(Vue) {
    Vue.prototype.$api = {
        units: Vue.resource('/api/units{/id}'),
        ingredients: Vue.resource('/api/ingredients{/id}'),
        sources: Vue.resource('/api/sources{/id}', {}, {
          retry: { method: 'POST', url: '/api/sources{/id}/retry' },
        }),
        recipes: Vue.resource('/api/recipes{/id}'),
        periods: Vue.resource('/api/periods{/id}'),
        users: Vue.resource('/api/users{/id}'),
    }
    Vue.http.interceptors.push(function(request) {
      if(userService.hasStoredData()) {
        request.headers.set('Authorization', 'Bearer ' + userService.getStoredData().access)
      }
      if(Vue.cookies.get('csrftoken')) {
        request.headers.set('X-CSRFTOKEN', Vue.cookies.get('csrftoken'))
      }
    })
  }
}

Vue.use(API)

export default API
