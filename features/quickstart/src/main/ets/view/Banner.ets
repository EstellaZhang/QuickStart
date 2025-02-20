import { BannerClass } from "../model/BannerClass";
// import { bufferToString } from "../util/BufferUtil";

//@Preview 可以单独预览组件
// @Preview
@Component
export struct Banner{
  // @State bannerList:BannerClass[] = [];
  @State bannerList: Array<BannerClass> = [
    new BannerClass('pic0', $r('app.media.banner_pic0'),
      'https://developer.huawei.com/consumer/cn/training/course/video/C101718352529709527'),
    new BannerClass('pic1', $r('app.media.banner_pic1'),
      'https://developer.huawei.com/consumer/cn/'),
    new BannerClass('pic2', $r('app.media.banner_pic2'),
      'https://developer.huawei.com/consumer/cn/deveco-studio/'),
    new BannerClass('pic3', $r('app.media.banner_pic3'),
      'https://developer.huawei.com/consumer/cn/arkts/'),
    new BannerClass('pic4', $r('app.media.banner_pic4'),
      'https://developer.huawei.com/consumer/cn/arkui/'),
    new BannerClass('pic5', $r('app.media.banner_pic5'),
      'https://developer.huawei.com/consumer/cn/sdk/')
  ];

  // 获取路由栈
  @Consume('articlePathStack') articlePathStack: NavPathStack;

  // 生命周期回调函数
  // aboutToAppear(): void {
  //   console.info('12',1)
  //   this.getBannerDataFromJSON();
  // }

  /**
   *
   * @description 定义获取json的方法
   * 1、将获取的buffer内容转换为字符串
   * 2、将字符串转换为页面数据结构
   *
   */
  // getBannerDataFromJSON() {
  //   // 获取buffer内容
  //   getContext(this).resourceManager.getRawFileContent('BannerData.json').then(value => {
  //     console.info('999',value)
  //     //   简写
  //     this.bannerList = JSON.parse(bufferToString(value)) as BannerClass[];
  //     console.info('777',this.bannerList);
  //   })
  // }

  build(){
    Swiper() {
      ForEach(this.bannerList, (item: BannerClass) => {
        Image(item.imageSrc)
          // Image($r('app.media.banner_pic1'))
          // Image($r(item.imageSrc))
          .objectFit(ImageFit.Contain)
          .width('100%')
          .padding({ top: 11, left: 16, right: 16 })
          .borderRadius(16)
          // 触发点击事件
          .onClick(() => {
            this.articlePathStack.pushPathByName('bannerDetailPage', item);
          })
      }, (item: BannerClass) => item.id)
    }
    .autoPlay(true)
    .loop(true)
    .indicator(
      new DotIndicator()
        .color('#1a000000')
        .selectedColor('#0A59F7'))


    // Image($r('app.media.banner_pic1'))
    //   .objectFit(ImageFit.Contain)
    //   .width('100%')
    //   .padding({ top: 11, left: 16, right: 16 })
    //   .borderRadius(16)
  }
}
