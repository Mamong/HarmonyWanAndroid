/*
初次加载避免页面空白
 */
@Component
export struct ActivityLoading {
  @Prop type: LoadingType = LoadingType.activity
  @Prop tips: string = "loading...."

  build() {
    Column() {
      Column({ space: 8 }) {
        if (this.type == LoadingType.activity) {
          LoadingProgress()
            .size({ width: 40, height: 40 })
            .color(Color.White)
        } else if (this.type == LoadingType.error) {
          SymbolGlyph($r('sys.symbol.checkmark_circle_fill'))
            .size({ width: 40, height: 40 })
            .fontColor([Color.White])
        } else {
          SymbolGlyph($r('sys.symbol.xmark_circle_fill'))
            .size({ width: 40, height: 40 })
            .fontColor([Color.White])
        }
        Text(this.tips).fontColor(Color.White)
      }
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#ee333333')
      .size({ width: 100, height: 100 })
      .borderRadius(10)
    }
    .justifyContent(FlexAlign.Center)
    .width('100%').height('100%')
  }
}

export enum LoadingType {
  activity, error, success
}