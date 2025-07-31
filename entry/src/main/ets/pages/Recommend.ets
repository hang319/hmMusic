import { AppStorageV2 } from "@kit.ArkUI";
import { SongItemType } from "../modules/music";
import { playerManager } from "../utils/AvPlayerManager";

interface DAILY_RECOMMEND_TYPE {
  name: string,
  id: string,
  duration: number
}

@ComponentV2
export struct Recommend {

  pathStack: NavPathStack = AppStorageV2.connect(NavPathStack, 'navStack', () => new NavPathStack())!;

  @Local dailyRecommend:SongItemType[] = [
    {
      img: 'http://jyjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.jpg',
      name: '前进世界的尽头',
      author: 'WANDS',
      url: 'http://jyjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.m4a',
      id: '0000'
    },
    {
      img: 'http://jyjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/1.jpg',
      name: '画',
      author: '赵雷',
      url: 'http://jyjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/1.mp3',
      id: '0001'
    },
    {
      img: 'http://jyjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/2.jpg',
      name: 'Sweet Dreams',
      author: 'TPaul Sax / Eurythmics',
      url: 'http://jyjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/2.mp3',
      id: '0002'
    }
  ]

  @Local swiperList: ResourceStr[] = [
    $r('app.media.tab1'),
    $r('app.media.tab2'),
    $r('app.media.tab3'),
    $r('app.media.tab4'),
    'https://qcloud.dpfile.com/pc/_vzQAXVr13f_7iwVuYMN-KZdECsM6WjeAFvnO_6J6g0hOLcGgiPlxc9FC8mAyrgC.jpg'
  ]

  @Builder titleBuilder (title: string) {
    Row() {
      Text(title)
        .layoutWeight(1)
        .fontColor('#fff')
        .fontSize(22)
      Image($r('app.media.tab9'))
        .width(22)
    }
  }

  build() {
    Column({space: 20}) {
      // 搜索区域
      Row() {
        Image($r('app.media.tab8'))
          .width(22)
          .fillColor('#817d83')
        TextInput({placeholder: '只因你太美'})
          .layoutWeight(1)
          .placeholderColor('#817d83')
          .fontColor('#fff')
        Image($r('app.media.tab4'))
          .width(22)
          .fillColor('#817d83')
      }
      .width('100%')
      .backgroundColor('#2d2b29')
      .border({radius: 20})
      .padding({left: 8, right: 8})

      // 轮播图区域
      Swiper() {
        ForEach(this.swiperList, (item: ResourceStr) => {
          Image(item)
            .width('100%')
            .height('100vp')
        })
      }

      // 每日推荐
      this.titleBuilder('每日推荐')

      List() {
        ForEach(this.dailyRecommend, (item: DAILY_RECOMMEND_TYPE, index: number) => {
          ListItem() {
            Column() {
              Text(item.name)
                .fontColor('#fff')
                .fontSize(20)
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
              Image($r('app.media.tab2'))
                .width(20)
            }
            .width('40%')
            .height(200)
            .margin({right: 20})
            .backgroundColor(Color.Pink)
            .borderRadius(10)
            .clip(true)
          }.onClick(() => {
            this.pathStack.pushPathByName('Play', null, false)
            playerManager.singPlay({
              id: item.id,
              name: item.name,
              author: `hang-${index}`,
              url: '',
              img: ''
            })
          })
        })
      }
      .listDirection(Axis.Horizontal)
    }
    .width('100%')
    .height('100%')
    .padding({top: 10, bottom: 10, right: 10, left: 10})
  }
}