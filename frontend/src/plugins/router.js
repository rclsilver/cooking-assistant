import Vue from 'vue'
import Router from 'vue-router'
import { store } from '@/store'

Vue.use(Router)

export const router = new Router({
  mode: 'history',
  base: '/',
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('@/views/Home.vue')
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('@/views/Login.vue')
    },
    {
      path: '/recipes',
      name: 'recipe-list',
      component: () => import('@/views/recipes/List.vue')
    },
    {
      path: '/recipes/:id',
      name: 'recipe-details',
      component: () => import('@/views/recipes/Details.vue')
    },
    {
      path: '/about',
      name: 'about',
      component: () => import('@/views/About.vue')
    },
    {
      path: '*',
      name: 'page-not-found',
      component: () => import('@/views/PageNotFound.vue')
    }
  ]
})

router.beforeEach((to, from, next) => {
  const publicPages = [ '/login' ]
  const authRequired = !publicPages.includes(to.path)

  if(authRequired && !store.state.authentication.status.loggedIn) {
    next('/login')
  } else {
    next()
  }
})
