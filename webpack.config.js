const path = require('path');

module.exports = {
  mode: 'development',
  bail: true,
  entry: {
    index: ['./source/javascripts/index.js'],
  },
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'build/javascripts')
  }
}
