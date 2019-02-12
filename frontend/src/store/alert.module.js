export const alert = {
  namespaced: true,
  state: {
    type: null,
    message: null
  },
  actions: {
    success({ commit }, message) {
      commit('update', {
        message,
        type: 'success'
      })
    },
    info({ commit }, message) {
      commit('update', {
        message,
        type: 'info'
      })
    },
    warning({ commit }, message) {
      commit('update', {
        message,
        type: 'warning'
      })
    },
    error({ commit }, message) {
      commit('update', {
        message,
        type: 'error'
      })
    },
    clear({ commit }) {
      commit('update', {
        message: null,
        type: null
      })
    }
  },
  mutations: {
    update(state, payload) {
      state.type = payload.type
      state.message = payload.message
    }
  }
}
