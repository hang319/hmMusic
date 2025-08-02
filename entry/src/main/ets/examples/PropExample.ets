// @Prop 装饰器使用示例
// 这个文件演示了父子组件之间如何使用@Prop传递数据

// 子组件：接收父组件传递的数据
@Component
struct ChildComponent {
  @Prop message: string = '';  // 接收字符串数据
  @Prop count: number = 0;     // 接收数字数据
  @Prop isActive: boolean = false;  // 接收布尔数据
  
  // 本地状态，不会影响父组件
  @State private localCount: number = 0;

  build() {
    Column() {
      Text(`来自父组件的消息: ${this.message}`)
        .fontSize(16)
        .fontColor('#333')
        .margin({ bottom: 8 })
      
      Text(`父组件传递的数字: ${this.count}`)
        .fontSize(14)
        .fontColor('#666')
        .margin({ bottom: 8 })
      
      if (this.isActive) {
        Text('当前状态: 活跃')
          .fontSize(14)
          .fontColor('#4CAF50')
          .margin({ bottom: 8 })
      } else {
        Text('当前状态: 非活跃')
          .fontSize(14)
          .fontColor('#999')
          .margin({ bottom: 8 })
      }
      
      Text(`本地计数: ${this.localCount}`)
        .fontSize(14)
        .fontColor('#FF9800')
        .margin({ bottom: 8 })
      
      Button('增加本地计数')
        .onClick(() => {
          this.localCount++;
        })
        .backgroundColor('#2196F3')
        .borderRadius(8)
        .width(120)
        .height(36)
    }
    .padding(16)
    .backgroundColor('#f5f5f5')
    .borderRadius(12)
    .margin({ bottom: 16 })
  }
}

// 父组件：向子组件传递数据
@Component
struct ParentComponent {
  @State parentMessage: string = 'Hello from Parent!';
  @State parentCount: number = 42;
  @State parentIsActive: boolean = true;

  build() {
    Column() {
      Text('@Prop 示例 - 父组件')
        .fontSize(20)
        .fontWeight('bold')
        .margin({ bottom: 16 })
      
      // 父组件的控制按钮
      Row() {
        Button('修改消息')
          .onClick(() => {
            this.parentMessage = `消息已更新: ${Date.now()}`;
          })
          .backgroundColor('#4CAF50')
          .borderRadius(8)
          .width(100)
          .height(36)
          .margin({ right: 8 })
        
        Button('增加计数')
          .onClick(() => {
            this.parentCount++;
          })
          .backgroundColor('#FF9800')
          .borderRadius(8)
          .width(100)
          .height(36)
          .margin({ right: 8 })
        
        Button('切换状态')
          .onClick(() => {
            this.parentIsActive = !this.parentIsActive;
          })
          .backgroundColor('#9C27B0')
          .borderRadius(8)
          .width(100)
          .height(36)
      }
      .margin({ bottom: 16 })
      
      // 显示父组件的当前状态
      Text(`父组件状态:`)
        .fontSize(16)
        .fontWeight('bold')
        .margin({ bottom: 8 })
      
      Text(`消息: ${this.parentMessage}`)
        .fontSize(14)
        .fontColor('#666')
        .margin({ bottom: 4 })
      
      Text(`计数: ${this.parentCount}`)
        .fontSize(14)
        .fontColor('#666')
        .margin({ bottom: 4 })
      
      Text(`活跃状态: ${this.parentIsActive}`)
        .fontSize(14)
        .fontColor('#666')
        .margin({ bottom: 16 })
      
      Divider()
        .margin({ bottom: 16 })
      
      // 使用@Prop向子组件传递数据
      ChildComponent({
        message: this.parentMessage,
        count: this.parentCount,
        isActive: this.parentIsActive
      })
      
      // 第二个子组件实例，展示数据传递的独立性
      ChildComponent({
        message: '这是第二个子组件',
        count: this.parentCount * 2,
        isActive: !this.parentIsActive
      })
    }
    .padding(20)
    .backgroundColor('#ffffff')
  }
}

// 导出父组件供其他页面使用
export { ParentComponent } 