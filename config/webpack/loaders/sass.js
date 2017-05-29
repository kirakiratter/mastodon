const ExtractTextPlugin = require('extract-text-webpack-plugin');
const { env } = require('../configuration.js');

const minimize = env.NODE_ENV === 'production';

module.exports = {
  test: /\.(scss|sass|css)$/i,
  oneOf: [
    {
      test: /\/themes\//,
      use: ExtractTextPlugin.extract({
        fallback: 'style-loader',
        use: [
          {
            loader: 'css-loader',
            options: {
              alias: {
                // Resolve `../` URLs relative to the `styles` directory, not
                // `styles/themes/kkt` (since we are importing the base style)
                '..': '../../..'
              },
              minimize,
            }
          },
          'postcss-loader',
          'sass-loader',
        ],
      }),
    },
    {
      use: ExtractTextPlugin.extract({
        fallback: 'style-loader',
        use: [
          { loader: 'css-loader', options: { minimize } },
          'postcss-loader',
          'sass-loader',
        ],
      }),
    }
  ],
};
