class InfiniteLoader {
  constructor(dataSource, limit=20) {
    this._dataSource = dataSource
    this._offset = 0
    this._limit = limit
    this.items = []
    this.loading = false
    this.finished = false
  }

  load() {
    return new Promise((resolve, reject) => {
      if(!this.finished && !this.loading) {
        this.loading = true
        this._dataSource({offset: this._offset, limit: this._limit}).then(response => {
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
}

export default InfiniteLoader
