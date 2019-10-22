# flutter_tutorial

A new Flutter project about Jay Chou

## Getting Started
- flutter run

## 设计技术点
- 本地存储  shared_preferences
- 状态管理 provider
- 网络请求 http
## 项目笔记
- ## 项目笔记
- 问题：个人中心页退出到登录页，登录页正确退回但是头部和底部内容被保留。解决：
路由跳转时用当前context产生的问题，从父级传入context来，push第一个参数parentContext用父级context可解决。
    ```
    Navigator.push(this.parentContext, MaterialPageRoute(
        builder: (BuildContext context) {
            return Login();
        },
    ));
    ```
- 问题：首页的添加收藏后切换页面之后状态丢失，解决：因为widget不保留临时变量，切换导致丢失。BottomNavigationBar引起的body使用IndexedStack包着可解决问题.
    ```
    body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
    )
    ```
