import jwt_decode from 'jwt-decode'

import { userService } from '../services/user.service'
import { router } from '../plugins/router'

const initialState = userService.hasStoredData()
    ? { status: { loggedIn: true }, user: userService.getStoredData() } 
    : { status: {}, user: null }

export const authentication = {
  namespaced: true,
  state: initialState,
  actions: {
    login({ commit, dispatch }, { username, password} ) {
      commit('loginRequest', { username })

      userService.login(username, password).then(user => {
        commit('loginSuccess', user)
        router.push('/')
      }, error => {
        commit('loginFailure', error)
        dispatch('alert/error', 'Invalid username or password!', { root: true })
      })
  },
  refresh({ commit, dispatch }) {
    userService.refresh().then(user => {
      commit('updateToken', user)
    }, error => {
      commit('loginFailure', error)
      router.push('/login')
      dispatch('alert/warning', 'You session has expired!', { root: true })
    })
  },
  inspect(context) {
    if(context.state.status.loggedIn) {
      const token = jwt_decode(context.state.user.access)
      const expiration = token.exp
      const now = Date.now() / 1000
      const delta = expiration - now

      if(delta < 600) {
        context.dispatch('refresh')
      }
    }

    setTimeout(() => {
      context.dispatch('inspect')
    }, 5000)
  },
  logout({ commit }) {
    userService.logout()
    commit('logout')
    router.push('/login')
  }
  },
  mutations: {
    loginRequest(state, user) {
      state.status = { loggingIn: true }
      state.user = user
    },
    loginSuccess(state, user) {
      state.status = { loggedIn: true }
      state.user = user
    },
    loginFailure(state, error) {
      state.status = { error }
      state.user = null
    },
    updateToken(state, user) {
      state.user = user
    },
    logout(state) {
      state.status = {}
      state.user = null
    }
  }
}
