import { KnowledgeMapContent, Section } from '../view/KnowledgeMapContent';
import { NavBarItem, NavBarItemType } from '../view/NavBarItem';
import { BusinessError } from '@kit.BasicServicesKit';
import { util } from '@kit.ArkTS';


@Component
struct PageMapComponent {

  @Prop name: string; // 接收的页面名称
  @Prop sections: Section[]; // 接收的 sections 数据
  @Prop currentNavBarIndex: number; // 当前导航栏索引

  @Provide('knowledgeMapPageStack') knowledgeMapPageStack: NavPathStack = new NavPathStack();

  build() {
    if (this.name === 'KnowledgeMapContent') {
      // 渲染 KnowledgeMapContent 组件
      KnowledgeMapContent({ section: this.sections[this.currentNavBarIndex] });
    }
    // 可以在这里处理其他页面名称的情况
    // 或者返回一个默认的组件
  }
}

@Preview
@Component
export struct KnowledgeMap {
  @State navBarList: NavBarItemType[] = [
    { order: '01', title: '准备与学习' },
    { order: '02', title: '构建应用' },
    { order: '03', title: '应用测试' },
    { order: '04', title: '上架' },
    { order: '05', title: '运营增长' },
    { order: '06', title: '商业变现' },
    { order: '07', title: '更多' }
  ];
  // 在KnowledgeMap页面中定义路由栈。我们通过创建NavPathStack实例并定义为@Provide类型的状态变量来进行路由栈的定义。Navigation有属于自己的路由栈，可以用于路由的前进、回退、路由历史记录的保存、路由参数的保存与获取。所以首先我们需要创建一个路由栈。
  @Provide('knowledgeMapPageStack') knowledgeMapPageStack: NavPathStack = new NavPathStack();
  @State currentNavBarIndex: number = -1;
  @State sections: Section[] = [];

  private getSections() {
    try {
      getContext(this).resourceManager.getRawFileContent("MapData.json", (error: BusinessError, value: Uint8Array) => {
        const textDecoder = util.TextDecoder.create("utf-8");
        const res = textDecoder.decodeWithStream(value, { stream: false });
        this.sections = JSON.parse(res);
      });
    } catch (error) {
      console.error(`callback getRawFileContent failed, error is ${JSON.stringify(error)}`)
    }
  }

  aboutToAppear(): void {
    this.getSections();
  }


  @Builder
  PageMap(name: string) {
    if (name === 'KnowledgeMapContent') {
      KnowledgeMapContent({ section: this.sections[this.currentNavBarIndex] });
    }

  }

  build() {
    // 添加Scroll组件。可以看到效果已经基本实现了，只是需要注意下面两种情况：
    // 1、列表的数据数量过多时，将导致内容会超过界面。
    // 2、列表的数据数量不足时，将导致Scroll组件滚动时出现空白区域。
    // 所以此处要在最外层包裹一个Scroll组件。我们可以把最开始加到Column组件的背景色移到Scroll组件上。此处添加constraintSize并设置minHeight为100%，可以解决当内容条数不足时，Scroll组件滚动时会出现空白区域的错误效果。edgeEffect用于设置边缘滑动效果，设置为EdgeEffect.Spring表示设置为弹性物理动效。该效果滑动到边缘后可以根据初始速度或通过触摸事件继续滑动一段距离，松手后回弹。
    Navigation(this.knowledgeMapPageStack) {
      Scroll() {
        Column() {
          Text('知识地图')
            .fontFamily('HarmonyHeiTi-Bold')
            .fontSize(24)
            .fontColor(Color.Black)
            .textAlign(TextAlign.Start)
            .lineHeight(33)
            .fontWeight(700)
            .width('100%')
          Image($r("app.media.knowledge_map_banner"))
            .width('100%')
            .borderRadius(16)
            .margin({ top: 19, bottom: 8 })
          Text('通过循序渐进的学习路径，无经验和有经验的开发者都可以轻松掌握ArkTS语言声明式开发范式，体验更简洁、更友好的HarmonyOS应用开发旅程。')
            .fontFamily('HarmonyHeiTi')
            .fontSize('14vp')
            .fontColor('rgba(0,0,0,0.60)')
            .fontWeight(400)
            .textAlign(TextAlign.Start)

          List({ space: 12 }) {
            ForEach(this.navBarList, (item: NavBarItemType, index: number) => {
              ListItem() {
                // NavBarItem({ navBarItem: item })
                NavBarItem({ navBarItem: item, currentNavBarIndex: this.currentNavBarIndex })
              }
              .width('100%')
            }, (item: NavBarItemType): string => item.title)
          }
          .width('100%')
          .margin({ top: 24 })

        }
        .padding({ top: 12, right: 16, bottom: 12, left: 16})
        .backgroundColor('#F1F3F5')}
      .backgroundColor('#F1F3F5')
      .align(Alignment.TopStart)
      .constraintSize({ minHeight: '100%' })
      .edgeEffect(EdgeEffect.Spring)
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
    .navDestination(this.PageMap)
    .navBarWidth(288)
  }
}