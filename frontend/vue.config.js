module.exports = {
  devServer: {
    disableHostCheck: true,
    proxy: {
      '/api/*': {
        target: 'http://api:5000',
        pathRewrite: {
          '/api': ''
        }
      }
    }
  },
  "transpileDependencies": [
    "vuetify"
  ]
}
