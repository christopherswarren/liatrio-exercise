const nodeExternals = require('webpack-node-externals');
const path = require('path');

module.exports = {
  entry: './src/server.js',
  target: 'node',
  externals: [nodeExternals()],
  output: {
    path: path.join(__dirname, 'dist'),
    filename: 'server.js'
  }
}