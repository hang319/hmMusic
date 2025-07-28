import { media } from '@kit.MediaKit'
import { SongItemType } from '../modules/music';

class AvPlayerManager {
  // 属性+方法

  // 播放器
  player: media.AVPlayer | null = null

//  创建播放器 + 监听播放器的状态
  async init() {
    if(!this.player) {
        this.player = await media.createAVPlayer()
    }

    this.player.on('stateChange',(state) => {
      if(state === 'initialized') {
        this.player?.prepare()
      } else if(state == 'prepared') {
          this.player?.play()
      }
    })
  }

  // 播放歌曲，设置播放资源
  singPlay(song: SongItemType) {
  this.player!.url = song.url
  }
}

export const playerManager: AvPlayerManager = new AvPlayerManager();