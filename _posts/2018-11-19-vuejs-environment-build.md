---
layout: post
title: "vue.js environment build"
description: "vue developer environment build guide"
category: RIA
tags: [vuejs]
---
{% include JB/setup %}

# Installation

> ## Node Version Requirement
Vue CLI required Node.js version 8.9 or above.
we use [node-v10](https://nodejs.org/dist/v10.0.0/node-v10.0.0-x64.msi)

To install the new package, use this command:
```bash
npm install -g @vue/cli
```

You can check you have the right version (3.x) with this command:
```bash
vue --version
```

# Createing a Project

## vue create
```bash
vue create hello-world
```

## using the GUI
```bash
vue ui
```

# CLI Service

## vue-cli-service serve
```bash
npm run serve
```

## vue-cli-service build
```bash
npm run build
```

# init project
```bash
cd ${project_home}
npm install -save-dev
```

# IDE

vscode

>*Extensions*
- Vetur(0.13.0): Vue tooling for VS Code
- ESLint(1.7.0): Integrates ESLint into VS Code
>>If you haven't installed ESLint either locally or globally do so by running npm install eslint in the workspace folder for a local install or npm install -g eslint for a global install.

# Online Document

- [Vue guide](https://cn.vuejs.org/v2/guide/)
- [Element UI quickstart](http://element-cn.eleme.io/#/zh-CN/component/quickstart)