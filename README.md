# synch-tool

shell版简易同步下载工具 ，用于同步git项目,方便学习源码

# 使用
```
// synch-tool
lib
+ resource
+ + opensource(任意命名)
- - - abc(任意命名，并添加加git地址换行表示多个项目如下)

// abc中添加地址
https://github.com/lodash/lodash.git
https://github.com/storybookjs/storybook.git

// 执行
// 两种方式 手动指定目录
// 方式一 ./lib/synch.sh ~/Document/temp
// 方式二 使用默认的start.sh 会在Document中创建

// 结果
目标目录/opensource(上述说的任意命名的文件夹)/@web/xxx项目
```

# TODO
- [ ] 全局命令
- [ ] 支持任意目录下创建待同步资源文件夹