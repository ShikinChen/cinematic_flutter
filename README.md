# FlutterCinematic--电影电视剧信息app
Flutter练习项目
根据
https://github.com/aaronoe/FlutterCinematic
的放弃使用redux改用rxdart的bloc

固定jaguar_query jaguar_orm 和jaguar_query_sqflite版本为2.2.5 防止jaguar_query升级到2.2.6 导致alter方法在jaguar_query_sqfli没实现报错

基于Flutter v0.8.2版本开发 兼容1.2
```bash
git clone -b v0.8.2 https://github.com/flutter/flutter
```

#api申请
需要在 https://www.themoviedb.org/settings/api 申请apikey
配置在constants.dart