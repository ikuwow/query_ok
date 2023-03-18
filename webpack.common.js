const path = require('path');

module.exports = {
  entry: {
    critical: './source/critical.js',
    main: './source/entry.js',
  },
  output: {
    filename: 'bundle-[name].js',
    path: path.resolve(__dirname, '.tmp/dist'),
    clean: true,
  },
  module: {
    rules: [
      {
        test: /\.(c|sa|sc)ss$/,
        use: ['style-loader', 'css-loader', 'sass-loader']
      },
      {
        test: /\.(eot|woff|woff2|ttf|svg)$/,
        type: 'asset/resource'
      }
    ]
  }
}
