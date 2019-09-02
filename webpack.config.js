const path = require('path');

module.exports = {
  mode: 'development',
  bail: true,
  entry: {
    index: ['./source/javascripts/index.js'],
  },
  output: {
    filename: './source/javascripts/[name].js',
    path: path.resolve(__dirname, '.tmp/dist')
  }
}
