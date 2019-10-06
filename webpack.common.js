const path = require('path');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

const mainConfig = {
  bail: true,
  entry: {
    main: './source/entry.js',
  },
  output: {
    filename: 'bundle-[name].js',
    path: path.resolve(__dirname, '.tmp/dist')
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader']
      }
    ]
  },
  plugins: [
    new CleanWebpackPlugin()
  ]
}

const criticalConfig = {
  bail: true,
  entry: {
    critical: './source/critical.js',
  },
  output: {
    filename: 'bundle-[name].js',
    path: path.resolve(__dirname, '.tmp/dist')
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader']
      }
    ]
  },
  plugins: [
    new CleanWebpackPlugin()
  ]
}

module.exports = [mainConfig, criticalConfig];
