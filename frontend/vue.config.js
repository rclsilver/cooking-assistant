const BundleTracker = require('webpack-bundle-tracker')
const VuetifyLoaderPlugin = require('vuetify-loader/lib/plugin')

if ('production' === process.env.NODE_ENV) {
    publicPath = '/static'
} else {
    publicPath = 'http://0.0.0.0:8080'
}

module.exports = {
    publicPath: publicPath,
    outputDir: './dist',
    assetsDir: './cooking-assistant',

    chainWebpack: config => {
        config.optimization
            .splitChunks(false)

        config
            .plugin('BundleTracker')
            .use(BundleTracker, [{filename: '../frontend/webpack-stats.json'}])

        config
            .plugin('VuetifyLoaderPlugin')

        config.resolve.alias
            .set('__STATIC__', 'static')

        config.devServer
            .public('http://0.0.0.0:8080')
            .host('0.0.0.0')
            .port(8080)
            .hot(true)
            .hotOnly(true)
            .watchOptions({poll: true})
            .https(false)
            .headers({'Access-Control-Allow-Origin': ['\*']})
    }
};
