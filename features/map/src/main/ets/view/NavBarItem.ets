export interface NavBarItemType {
  order: string,
  title: string
}

@Component
export struct NavBarItem {
  // 删除自定义数据并修改数据获取方式。由于此处需要单向的从外部获得参数并进行渲染，所以需要我们删除自定义的数据并将@State换为@Prop。
  @Prop navBarItem: NavBarItemType;

  @Consume('knowledgeMapPageStack') knowledgeMapPageStack: NavPathStack;
  @Link currentNavBarIndex: number;

  build() {
    Row(){
      Text(this.navBarItem.order)
      Text(this.navBarItem.title)
        .fontFamily('HarmonyHeiTi-Medium')
        .fontSize(16)
        .fontColor('#182431')
        .textAlign(TextAlign.Start)
        .lineHeight(22)
        .fontWeight(500)
      Blank()
      Image($r('app.media.ic_arrow'))
        .width(12)
        .height(24)
    }
    .width('100%')
    .height(48)
    .borderRadius(16)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 12, right: 12 })
    // .backgroundColor('#F1F3F5')
    .backgroundColor(
      this.currentNavBarIndex === Number(this.navBarItem.order) - 1 ?
        '#1A0A59F7' :
      Color.Transparent
    )
    .onClick(() => {
      this.knowledgeMapPageStack.replacePath({ name: 'KnowledgeMapContent' });
      const index =  Number(this.navBarItem.order)  - 1;
      this.currentNavBarIndex = index;
    })
  }
}