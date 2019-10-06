const merge = require('webpack-merge');
const common = require('./webpack.common.js');

module.exports = merge.multiple(common, {
  main: {
    mode: 'production'
  },
  critical: {
    mode: 'production'
  }
});
