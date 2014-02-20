# 最基本的用户系统
============


## API

### 用户登录

path: `/api/login`

method: `POST`

request 参数:
 * email
 * password

response 结果
 * 登录成功的话： 返回http状态200， body是json数据格式：`{ "id": "5305a56964626a8b061de161", "success": true }`
 * 登录失败的话： 返回http状态401

示例：
```
 curl -X POST -d "email=test1@gmail.com&password=112233" http://localhost:3000/api/login -v
```

### 用户注册

path: `/api/signup`

method: `POST`

request 参数:
 * email
 * password

response 结果
 * 注册成功的话： 返回http状态200， body是json数据格式：`{ "id": "5305a56964626a8b061de161", "success": true }`
 * 注册失败的话： 返回http状态200， body是json数据格式：`{ "error": "注册失败的原因", "success": false }`

示例：
```
 curl -X POST -d "email=test1@gmail.com&password=112233" http://localhost:3000/api/signup -v
```

### 用户修改密码

path: `/api/change_password`

method: `POST`

request 参数:
 * email
 * password
 * new_password

response 结果
 * 修改密码成功的话： 返回http状态200， body是json数据格式：`{ "id": "5305a56964626a8b061de161", "success": true }`
 * 修改密码失败的话： 返回http状态200， body是json数据格式：`{ "error": "注册失败的原因", "success": false }`

示例：
```
 curl -X POST -d "email=test1@gmail.com&password=112233&new_password=556677" http://localhost:3000/api/change_password -v
```

============

##[Demo](http://passport.diki.io)

User system is writen **CoffeeScript**, run on nodejs illustrating the use of **passport** in **express**, **jade** and **mongoose** environment
together with front pages for login, signup and profile mock built with Twitter Bootstrap

Includes login with Facebook, Twitter, Github and Google together with Passport LocalStrategy

Technology
------------

| On The Server | On The Client  |
| ------------- | -------------- |
| Express       | Bootstrap 3    |
| Jade          | Backbone.js    |
| Passport      | jQuery         |
| Mongoose      | Underscore.js  |

## 操作命令

### 启动 coffee watch 进行编译
-------------
```bash
npm run-script watch
```

### 启动开发服务器
-------------
```bash
npm run-script start
```

License
------------

MIT
