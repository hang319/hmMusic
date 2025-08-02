import { GlobalMusic } from '../modules/music';
import { number2time } from '../utils/Tools';
import { AppStorageV2 } from '@kit.ArkUI';
import { playerManager } from '../utils/AvPlayerManager';
import { MusicItem } from '../components/MusicItem';

@Builder
export function PlayBuilder() {
  Play();
}

@ComponentV2
struct Play {

  pathStack: NavPathStack = new NavPathStack();
  currentSong: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'SOME_KEY', () => new GlobalMusic())!;



  build() {
    NavDestination() {
      Column(){
        Text('Play')
          .fontColor(Color.Green)
          .fontSize(20)
        
        // 使用MusicItem组件显示当前播放的歌曲
        MusicItem({
          songName: this.currentSong.name || '未知歌曲',
          songAuthor: this.currentSong.author || '未知作者',
          isPlaying: this.currentSong.isPlay || false,
        })
        .margin({ top: 20, bottom: 20 })
        
        Slider()
          .layoutWeight(1)
          .blockColor(Color.Gray)
          .selectedColor(Color.Orange)
          .onChange((value) => {
            playerManager.seekPlay(value)
          })

        Text(number2time(this.currentSong.duration || 220000))
      }
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}