/*
 * 支持矩形和圆形，使用圆角和剪裁来实现圆形skeleton：
 * 例如SkeletonBox().width(50).height(50).borderRadius(25).clip(true)
 *
 * */

@Component
export struct SkeletonBox {
  @State private translateX: string = "-100%"

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
        .translate({ x: this.translateX })
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
          this.translateX = '100%'
        })
    }
    .clip(true)
    .width('100%').height('100%')
  }
}