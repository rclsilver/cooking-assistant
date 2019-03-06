class InfiniteLoader {
  constructor(dataSource, limit=20, filters={}) {
    this._dataSource = dataSource
    this._offset = 0
    this._limit = limit
    this._filters = filters
    this.items = []
    this.loading = false
    this.finished = false
  }

  load() {
    return new Promise((resolve, reject) => {
      if(!this.finished && !this.loading) {
        this.loading = true
        this._dataSource({offset: this._offset, limit: this._limit, ...this._filters}).then(response => {
          if(response.body.results.length > 0) {
            this.items.push(...response.body.results)

            if(this._limit) {
              this._offset = this._offset + this._limit
            } else {
              this.finished = true
            }
          } else {
            this.finished = true
          }
          this.loading = false
          resolve(response)
        }, response => {
          this.loading = false
          reject(response)
        })
      }
    });
  }

  reset() {
    this.items = []
    this._offset = 0
    this.finished = false
    this.loading = false
  }

  setFilters(filters) {
    this._filters = filters
    this.reset()
  }
}

export default InfiniteLoader
