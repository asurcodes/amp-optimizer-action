# AMP Optimizer Action :zap:

![GitHub (Pre-)Release Date](https://img.shields.io/github/release-date-pre/asurbernardo/amp-optimizer-action)
![GitHub issues](https://img.shields.io/github/issues/asurbernardo/amp-optimizer-action)
![GitHub](https://img.shields.io/github/license/asurbernardo/amp-optimizer-action)
![Twitter Follow](https://img.shields.io/twitter/follow/asurbernardo?style=social)

GitHub Action to optimize AMP HTML files.

It uses AMP Transformer GoLang library and recursively searchs for files to optimize. Designed for static web generator pipelines.

You can read more about AMP server side rendering on the [official blog](https://amp.dev/documentation/guides-and-tutorials/optimize-and-measure/server-side-rendering/).

## Usage

As parameters this job accepts the following:

- **root**: The root folder where the AMP files are located

Add this step to your workflow:

```
    - name: Optimize AMP
      uses: asurbernardo/amp-optimizer-action@1.0.2
      with:
        root: 'public'
```

As a [full working example](https://github.com/asurbernardo/blog/blob/master/.github/workflows/main.yml) using GoHugo on my own site:

```
name: Deploy blog
on:
  push:
    branches:
    - master
jobs:
  build-deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Pull source
      uses: actions/checkout@master
      with:
        submodules: true
    - name: Update submodules to latests master
      run: git submodule foreach git pull origin master
    - name: Setup Hugo
      uses: peaceiris/actions-hugo@v2.2.2
      with:
        hugo-version: '0.58.3'
        extended: true
    - name: Build
      run: hugo -t amperage --gc --minify
    - name: Optimize AMP
      uses: asurbernardo/amp-optimizer-action@1.0.2
      with:
        root: './public'
    - name: Deploy script
      uses: peaceiris/actions-gh-pages@v2.5.0
      env:
        ACTIONS_DEPLOY_KEY: ${{ secrets.ACTIONS_DEPLOY_KEY }}
        EXTERNAL_REPOSITORY: asurbernardo/asurbernardo.github.io
        PUBLISH_BRANCH: master
        PUBLISH_DIR: ./public
```
