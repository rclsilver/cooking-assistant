import Vue from 'vue'
import Router from 'vue-router'

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
