#!/usr/bin/env bash

# Create astro tremplate

read -p "$(tput setaf 3) Name Project: " project_name 

printf "
{
  'name': '${project_namme}',
  'type': 'module',
  'version': '0.0.1',
  'scripts': {
    'dev': 'astro dev',
    'start': 'astro dev',
    'build': 'astro check && astro build',
    'preview': 'astro preview',
    'astro': 'astro'
  },
  'dependencies': {
    '@astrojs/check': 'latest',
    'astro': 'latest',
    'typescript': 'latest'
  }
}" > package.json

command pnpn i

command pnpm i -D eslint eslint-plugin-astro eslint-plugin-jsx-a11y @typescript-eslint/parser prettier prettier-config-standard prettier-plugin-astro

printf '
/** @type {import('prettier').Config} */
module.exports = {
  // i am just using the standard config, change if you need something else
  ...require('prettier-config-standard'),
  pluginSearchDirs: [__dirname],
  plugins: [require.resolve('prettier-plugin-astro')],
  semi: true,
  tabWidth: 4,
  useTabs: true,
  singleAttributePerLine: false,
  bracketSameLine: true,
  overrides: [
    {
      files: '*.astro',
      options: {
        parser: 'astro',

      }
    }
  ]
}
' > $PWD/prettier.config.cjs

printf '/** @type {import('eslint').Linter.Config} */
module.exports = {
  extends: ['plugin:astro/recommended'],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    tsconfigRootDir: __dirname,
    sourceType: 'module',
    ecmaVersion: 'latest'
  },
  overrides: [
    {
      files: ['*.astro'],
      parser: 'astro-eslint-parser',
      parserOptions: {
        parser: '@typescript-eslint/parser',
        extraFileExtensions: ['.astro']
      },
      rules: {
        // override/add rules settings here, such as:
        // 'astro/no-set-html-directive': 'error'
      }
    }
  ]
}'> $PWD/.eslintrc.cjs

command rm -rfv .git/

echo ''
echo '$(tput setaf 2)Prettier & ESLint Astro plugins installed' $(tput sgr 0)'
