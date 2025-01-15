/*
初次加载没数据
 */
@Component
export struct DefaultEmpty {
  build() {
    Column() {
      SymbolGlyph($r('sys.symbol.airplane_fill'))
        .size({ width: 40, height: 40 })
        .renderingStrategy(SymbolRenderingStrategy.SINGLE)
        .fontColor([Color.Black, Color.Green, Color.White])
      Text("暂无相关数据....")
    }
    .justifyContent(FlexAlign.Center)
    .width('100%').height('100%')
  }
}

/*
初次加载异常，未登录、超时等
 */
@Component
export struct DefaultError {
  @Require @Prop error: string
  @Prop actionTitle: ResourceStr | null = null
  action?: () => void

  build() {
    Column() {
      SymbolGlyph($r('sys.symbol.xmark_circle_fill'))
        .size({ width: 40, height: 40 })
        .renderingStrategy(SymbolRenderingStrategy.SINGLE)
        .fontColor([Color.Black, Color.Green, Color.White])
      Text(this.error)
      if (this.actionTitle) {
        Button(this.actionTitle).onClick(() => {
          this.action && this.action()
        })
      }
    }
    .justifyContent(FlexAlign.Center)
    .width('100%').height('100%')
  }
}