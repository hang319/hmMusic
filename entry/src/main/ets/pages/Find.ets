import { AppStorageV2 } from "@kit.ArkUI";

@ComponentV2
export struct Find {

  pathStack: NavPathStack = AppStorageV2.connect(NavPathStack, 'navStack', () => new NavPathStack())!;

  
  build() {
    Text('发现').fontColor('#fff')
  }
}