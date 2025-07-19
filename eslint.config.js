import js from '@eslint/js';

export default [
  {
    ignores: [
      'node_modules/**',
      'vendor/**',
      'build/**',
      '.tmp/**',
      'dist/**'
    ]
  },
  js.configs.recommended,
  {
    languageOptions: {
      ecmaVersion: 2020,
      sourceType: 'module',
      globals: {
        // Browser globals
        window: 'readonly',
        document: 'readonly',
        navigator: 'readonly',
        console: 'readonly',
        btoa: 'readonly',
        URL: 'readonly',
        self: 'readonly',
        globalThis: 'readonly',
        // Node.js globals
        process: 'readonly',
        Buffer: 'readonly',
        __dirname: 'readonly',
        __filename: 'readonly',
        global: 'readonly',
        // ES6 globals
        Promise: 'readonly',
        Symbol: 'readonly',
        Map: 'readonly',
        Set: 'readonly',
        WeakMap: 'readonly',
        WeakSet: 'readonly',
        Proxy: 'readonly',
        Reflect: 'readonly'
      }
    },
    files: ['**/*.js']
  }
];
