import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export default {
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
