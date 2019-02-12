import Vue from 'vue'

let API = {
  install: function(Vue) {
    Vue.prototype.$api = {
        units: Vue.resource('/api/units{/id}'),
        ingredients: Vue.resource('/api/ingredients{/id}'),
        sources: Vue.resource('/api/sources{/id}'),
        recipes: Vue.resource('/api/recipes{/id}'),
    }
    Vue.http.interceptors.push(function(request) {
      if(Vue.cookies.get('csrftoken')) {
        request.headers.set('X-CSRFTOKEN', Vue.cookies.get('csrftoken'))
      }
    })
  }
}

Vue.use(API)

export default API
