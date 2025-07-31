export interface SongItemType {
  img: string
  name: string
  author: string
  url: string
  id:string
}

@ObservedV2
export class GlobalMusic {
  @Trace img: string = ""  // 音乐封面
  @Trace name: string = ""  // 音乐名称
  @Trace author: string = ""  // 作者
  @Trace url: string = ""  // 当前播放链接
  @Trace time: number = 0  // 播放时间
  @Trace duration: number = 0  // 音乐的播放时长
  @Trace playIndex: number = 0;
  @Trace playList: SongItemType[] = [];

  @Trace isPlay: boolean = false;
}