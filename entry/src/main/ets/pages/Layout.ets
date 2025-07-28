// 跳转页面入口函数
import { Recommend } from './Recommend';
import { Find } from './Find';
import { Dynamic } from './Dynamic';
import { Mine } from './Mine';

@Builder
export function LayoutBuilder() {
  Layout();
}

interface TabItemProps {
  text: string,
  icon: ResourceStr
}

@ComponentV2
struct Layout {
  pathStack: NavPathStack = new NavPathStack();

  @Local currentTab:number =  0;

  @Local tabData: TabItemProps[] = [
    {text: '推荐', icon: $r('app.media.tab1')},
    {text: '发现', icon: $r('app.media.tab2')},
    {text: '动态', icon: $r('app.media.tab3')},
    {text: '我的', icon: $r('app.media.tab4')},
  ]

 @Builder tabBuilder(item: TabItemProps, index: number) {
    Column() {
      Image(item.icon)
        .width(24)
        .fillColor('#63aaaa')
      Text(item.text)
        .fontSize(14)
        .fontColor(this.currentTab == index ? '#e85a88' : '#63aaaa')
    }
  }

  build() {
    NavDestination() {
      Tabs({barPosition: BarPosition.End}) {
        ForEach(this.tabData, (item: TabItemProps, index: number) => {
          TabContent() {
            if(index == 0) {
              Recommend()
            } else if(index == 1) {
              Dynamic()
            }else if(index == 2) {
              Find()
            }else if(index == 3) {
              Mine()
            }
          }
          .tabBar(this.tabBuilder(item, index))
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
          .backgroundColor('#131215')
        })
      }
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      .backgroundColor('#3b3f42')
      .onChange((index: number) => {
        this.currentTab = index;
      })
    }

    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}