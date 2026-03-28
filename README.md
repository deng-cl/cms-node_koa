# vue3 项目后端接口

**后台管理系统**: [cms-back-management_vue3](https://github.com/deng-cl/cms-back-management_vue3)

**客户端前台**: [cms-client_uniapp](https://github.com/deng-cl/cms-client_uniapp)

**项目描述:** 电子产品管理系统-后台管理系统 + 客户端前台
`基于 Vue3+ElementPlus 开发的后台管理系统，其中主要包括用户管理、标签管理、商品管理、订单管理等核心功能；基于 uniapp+uviewPlus 开发的电子产品管理系统的前台，其中主要包括商品购买（tip: 非真实支付，使用定时器模拟支付）、地址管理、购物车、订单管理、信息管理、商品搜索等核心功能；基于 Koa+MySQL 开发该项目相应的接口`
- **技术栈:** Vue3，Vue Router，Pinia，Axios，Element Plus，TypeScript，Vite，Prettier，ESLint，Commitizen，Commitlint，husky，Node，Koa，MySQL，JWT，uniapp，uviewPlus
- **项目规范搭建:** 规划目录结构实现模块解耦（模块化开发），统一代码风格，推行组件化设计，引入 Prettier、ESLint 等确保代码质量等，提升开发效率与代码可维护性
- **定制UI组件:** 对 Element Plus 进行定制性的封装，抽取后台相似模块封装成一个通用的 UI 组件，使其可以通过传入对应的配置的形式，来快速的对页面及其功能的构建，提升了代码开发效率与风格的统一性
- **定制 store hook:** 鉴于后台功能模块相似使 store 逻辑重复，故定制了 useCommomStore hook 统一管理重复逻辑，有利于新 store 模块的搭建。搭建新 store 模块时，调用并稍作配置即可
- **统一管理API:** 运用 TypeScript 深度封装 Axios，添加请求和响应拦截器统一处理流程，对 API 接口请求模块化管理，按功能或业务分类，集中调用
- **统一代码规范:** 通过 EditorConfig，Prettier，ESLint，husky，Commitizen，Commitlint 统一代码开发规范，提高代码的质量
- **接口开发规范:** 通过明确的文件命名规则和目录结构，将代码按功能或业务逻辑组织，划分 router、middleware、controller、service 四层，各层各司其职，增强代码可维护性与扩展性
