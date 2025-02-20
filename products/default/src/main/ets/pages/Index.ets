// !！真实设备上演示在此添加，对应features的模块下的index声明导出


import { QuickStartPage } from 'quickstart';
// import { CourseLearning } from '@ohos/learning';
import { CourseLearning } from 'learning';
import { KnowledgeMap,KnowledgeMapContent } from 'map';

@Component
struct TabBarItem {
  @Prop title: string; // 标题
  @Prop targetIndex: number; // 目标索引
  @Prop selectedIcon: ResourceStr; // 选中时的图标
  @Prop unselectIcon: ResourceStr; // 未选中时的图标
  @Prop currentIndex: number; // 当前选中的索引

  build() {
    Column() {
      // 根据当前索引显示选中或未选中图标
      Image(this.currentIndex === this.targetIndex ? this.selectedIcon : this.unselectIcon)
        .width(24)
        .height(24)

      // 标题文本
      Text(this.title)
        .fontFamily('HarmonyHeiTi-Medium')
        .fontSize(10)
        .fontColor(this.currentIndex === this.targetIndex ? '#0A59F7' : 'rgba(0,0,0,0.60)')
        .textAlign(TextAlign.Center)
        .lineHeight(14)
        .fontWeight(500)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Entry
@Component
struct Index {

  @State currentIndex: number = 0;

  // @Builder
  // tabBarBuilder(title: string, targetIndex: number, selectedIcon: Resource, unselectIcon: Resource) {
  //   Column() {
  //     Image(this.currentIndex === targetIndex ? selectedIcon : unselectIcon)
  //       .width(24)
  //       .height(24)
  //     Text(title)
  //       .fontFamily('HarmonyHeiTi-Medium')
  //       .fontSize(10)
  //       .fontColor(this.currentIndex === targetIndex ? '#0A59F7' : 'rgba(0,0,0,0.60)')
  //       .textAlign(TextAlign.Center)
  //       .lineHeight(14)
  //       .fontWeight(500)
  //   }
  //   .width('100%')
  //   .height('100%')
  //   .justifyContent(FlexAlign.Center)
  //   .alignItems(HorizontalAlign.Center)
  // }

  build() {
    Tabs({ barPosition: BarPosition.End }){
      TabContent() {
        QuickStartPage()
      }
      .tabBar(
        {
          icon: this.currentIndex === 0 ? $r('app.media.ic_01_on') : $r('app.media.ic_01_off'),
          text: '首页'
        }
      )

      TabContent() {
        CourseLearning()
      }
      .tabBar({
        icon: this.currentIndex === 1 ? $r('app.media.ic_02_on') : $r('app.media.ic_02_off'),
        text: '课程'
      })

      TabContent() {
        KnowledgeMap()
      }
      .tabBar({
        icon: this.currentIndex === 2 ? $r('app.media.ic_03_on') : $r('app.media.ic_03_off'),
        text: '知识地图'
      })
    }
    .scrollable(false)
    .vertical(false)
    .divider({
      strokeWidth: 0.5,
      color: '#0D182431'
    })
    .backgroundColor('#F1F3F5')
    .padding({ top: 36, bottom: 28 })
  }
}