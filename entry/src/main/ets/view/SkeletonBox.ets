@Component
export struct SkeletonBox {
  @State private translateValue: string = "-100%"

  build() {
    Stack() {
      Rect()
        .fill('#f3f4f5')
        .height('100%')
        .width('100%')

      Rect()
        .height('100%')
        .width('100%')
        .fill(Color.Transparent)
        .translate({ x: this.translateValue })
        .linearGradient({
          angle: 45,
          colors: [
            ['rgba(255,255,255,0)', 0],
            ['rgba(255,255,255,1)', 0.5],
            ['rgba(255,255,255,0)', 0]
          ]
        })
        .animation({ duration: 1500, iterations: -1 })
        .onAppear(() => {
          this.translateValue = '100%'
        })
    }
    .clip(true)
    .width('100%').height('100%')
  }
}