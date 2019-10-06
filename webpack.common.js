const path = require('path');
const outputPath = path.resolve(__dirname, '.tmp/dist');

const mainConfig = {
  bail: true,
  entry: {
    main: './source/entry.js',
  },
  output: {
    filename: 'bundle-[name].js',
    path: outputPath
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader']
      }
    ]
  },
  plugins: []
}

const criticalConfig = {
  bail: true,
  entry: {
    critical: './source/entry-critical.js',
  },
  output: {
    filename: 'bundle-[name].js',
    path: outputPath
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader']
      }
    ]
  },
  plugins: []
}

module.exports = {main: mainConfig, critical: criticalConfig};
