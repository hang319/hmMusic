// MusicItem 组件 - 独立文件，供其他页面导入使用
// 使用@Prop接收父组件传递的数据


@Component
export struct MusicItem {
  @Prop songName: string;  // 接收歌曲名称
  @Prop songAuthor: string;  // 接收作者名称
  @Prop isPlaying: boolean;  // 接收播放状态
  
  // 本地状态，不会影响父组件
  @State private isLiked: boolean = false;
  
  // 抛出事件 (通过Prop传递回调函数)
  @Prop onLikeClick: () => void;

  build() {
    Row() {
      // 音乐信息区域
      Column() {
        Text(this.songName)
          .fontColor('#fff')
          .fontSize(16)
          .maxLines(1)
        
        Text(this.songAuthor)
          .fontColor('#999')
          .fontSize(14)
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      
      // 播放状态和喜欢按钮
      Column() {
        if (this.isPlaying) {
          Text('▶ 播放中')
            .fontColor('#e85a88')
            .fontSize(12)
            .margin({ bottom: 4 })
        }
        
        Button(this.isLiked ? '❤️' : '🤍')
          .onClick(() => {
            this.isLiked = !this.isLiked;
            this.onLikeClick();  // 触发事件
          })
          .backgroundColor('#2d2b29')
          .borderRadius(15)
          .width(30)
          .height(30)
      }
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#2d2b29')
    .borderRadius(8)
    .margin({ bottom: 8 })
  }
} 