module.exports = {
  test: /\.html$/i,
  loader: 'html-loader',
  options: {
    minimize: true,
    removeComments: true,
    collapseWhitespace: true
  }
};

