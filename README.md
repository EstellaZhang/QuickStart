# QuickStart
HarmonyOS APP

## 应用架构


## 工程目录

```
├──commons                         // 公共能力层（用于存放公共基础能力集合（如工具库、公共配置等）。commons层可编译成一个或多个HAR包或HSP包，只可以被products和features依赖，不可以反向依赖。）
├──features                        // 基础特性层（用于存放基础特性集合（如应用中相对独立的各个功能的UI及业务逻辑实现等）。各个feature高内聚、低耦合、可定制，供产品灵活部署。不需要单独部署的feature通常编译为HAR包或HSP包，供products或其它feature使用。需要单独部署的feature通常编译为Feature类型的HAP包，和products下Entry类型的HAP包进行组合部署。features层可以横向调用及依赖common层，同时可以被products层不同设备形态的HAP所依赖，但是不能反向依赖products层。）
├── learning/                       # 课程模块
│   ├── components/                 # 课程相关组件
│   ├── pages/                      # 课程页面
│   └── HomePage.ets                # 课程入口页面
│
├── map/                            # 知识地图模块
│   ├── components/                 # 知识地图相关组件
│   ├── pages/                      # 知识地图页面
│   └── KnowledgeMap.ets            # 知识地图入口页面
│
└── quickstart/                     # 首页模块
    ├── components/                 # 首页相关组件
    ├── pages/                      # 首页页面
    └── ProfilePage.ets             # 首页入口页面
├──products                        // 产品定制层（用于针对不同设备形态进行功能和特性集成。products层各个子目录各自编译为一个Entry类型的HAP包，作为应用主入口。products层不可以横向调用。）

```

