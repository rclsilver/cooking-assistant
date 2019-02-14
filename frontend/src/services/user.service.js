const USER_KEY = 'user'

export const userService = {
  login(username, password) {
    const requestOptions = {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username, password })
    }

    return fetch('/api/token/', requestOptions).then(this.handleResponse).then(user => {
      if(user.access) {
        localStorage.setItem(USER_KEY, JSON.stringify(user))
      }
      return user
    })
  },
  refresh() {
    const requestOptions = {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ refresh: this.getStoredData().refresh })
    }

    return fetch('/api/token/refresh/', requestOptions).then(this.handleResponse).then(user => {
      if(user.access) {
        user.refresh = this.getStoredData().refresh
        localStorage.setItem(USER_KEY, JSON.stringify(user))
      }
      return user
    })
  },
  logout() {
    localStorage.removeItem(USER_KEY)
  },
  hasStoredData() {
    return null !== localStorage.getItem(USER_KEY)
  },
  getStoredData() {
    let data = localStorage.getItem(USER_KEY)

    if(data) {
      return JSON.parse(data)
    } else {
      return data
    }
  },
  handleResponse(response) {
    return response.text().then(text => {
      const data = text && JSON.parse(text)

      if(!response.ok) {
        if(401 === response.status) {
          this.logout()
          location.reload(true)
        }

        const error = (data && data.message) || response.statusText
        return Promise.reject(error)
      }

      return data
    })
  }
}
