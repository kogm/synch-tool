# synch-tool

shell版简易同步下载工具 ，用于同步git项目,方便学习源码

## 结构说明
```
// synch-tool
lib
+ resource
+ + opensource(任意命名)
- - - @web(任意命名，并添加加git地址换行表示多个项目如下)

// @web文件中添加地址
https://github.com/lodash/lodash.git
https://github.com/storybookjs/storybook.git

```
## 使用
```
// 执行
// 两种方式 手动指定目录
// 方式一 ./lib/synch.sh ~/Document/temp 会在该目下创建项目并同步
// 方式二 使用默认的start.sh 会在Document中创建
```
## 不同步某个项目
```
// @web
https://github.com/lodash/lodash.git
https://github.com/storybookjs/storybook.git false
```

# TODO
- [x] 支持暂停同步某个git项目
- [ ] 全局命令
- [ ] 支持任意目录下创建待同步资源文件夹