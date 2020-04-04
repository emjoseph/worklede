process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

// From: http://blog.blackninjadojo.com/ruby/rails/2019/03/01/webpack-webpacker-and-modules-oh-my-how-to-add-javascript-to-ruby-on-rails.html
const webpack = require("webpack");
environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    "window.jQuery": "jquery" // < I think this could be the line you need.
  })
)

module.exports = environment.toWebpackConfig()
