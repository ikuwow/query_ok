const path = require('path');

module.exports = {
  bail: true,
  entry: './source/entry.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, '.tmp/dist')
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader']
      }
    ]
  }
}
