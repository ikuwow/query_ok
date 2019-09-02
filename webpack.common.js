const path = require('path');

module.exports = {
  bail: true,
  entry: {
    index: ['./source/javascripts/index.js'],
  },
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, '.tmp/dist')
  }
}
