@Builder
export function PlayBuilder() {
  Play();
}

@ComponentV2
struct Play {

  pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column(){
        Text('Play')
          .fontColor(Color.Green)
          .fontSize(20)
      }
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}