import { media } from '@kit.MediaKit'
import { GlobalMusic, SongItemType } from '../modules/music';
import { AppStorageV2 } from '@kit.ArkUI';

class AvPlayerManager {
  // 属性+方法

  // 播放器
  player: media.AVPlayer | null = null

  currentSong: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'SOME_KEY', () => new GlobalMusic())!;

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

    this.player.on('durationUpdate', (duration) => {
      this.currentSong.duration = duration;
    })
  }

  // 播放歌曲，设置播放资源（基础版本）
  // singPlay(song: SongItemType) {
  //   this.player!.url = song.url
  //   this.currentSong.img = song.img;
  // }

  // 播放歌曲，设置播放资源（完整版本）
  singPlay(song: SongItemType) {
    // 判断是否在数组里
   const flag = this.currentSong.playList.some(item => item.id == song.id);
   if(flag) {
      if(this.currentSong.url == song.url) {
        this.player?.play()
        this.currentSong.isPlay = true;
      } else {
        this.currentSong.playIndex = this.currentSong.playList.findIndex(item => item.id ==song.id);
        // 切割
        this.changeSong()
      }
   } else {
     this.currentSong.playList.unshift(song);
     this.currentSong.playIndex = 0;
     // 切割
     this.changeSong()
   }
  }

  async changeSong() {
    await this.player?.reset();
    this.currentSong.duration = 0;
    this.currentSong.time = 0;
    // 补充完整
    this.currentSong.isPlay = true;
  }

  // 跳转进度
  seekPlay(value: number) {
    // this.currentSong.duration = value;
    this.player?.seek(value)
  }

  //暂停
  paused() {
    this.player?.pause()
    this.currentSong.isPlay = false;
  }

  // 上一首
  prevPlay() {
    this.currentSong.playIndex--;
    if(this.currentSong.playIndex < 0) {
      this.currentSong.playIndex = this.currentSong.playList.length - 1;
    }
    this.singPlay(this.currentSong.playList[this.currentSong.playIndex])
  }

  // 下一首
  nextPlay() {
   // 同上改就行。
  }
}

export const playerManager: AvPlayerManager = new AvPlayerManager();