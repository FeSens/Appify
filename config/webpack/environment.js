const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')
const html = require('./loaders/html')

const webpack = require("webpack");
environment.plugins.append(
  "Provide",
  new webpack.ProvidePlugin({
  $: "jquery",
  jQuery: "jquery",
  Popper: ["popper.js", "default"]
  })
);
environment.loaders.prepend('erb', erb)
environment.loaders.append('html', html)
module.exports = environment;