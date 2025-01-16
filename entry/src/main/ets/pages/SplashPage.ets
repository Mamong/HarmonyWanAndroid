import { LengthMetrics } from "@kit.ArkUI";

@Component
export struct SplashPage {
  @StorageProp('colorMode') colorMode: ColorMode = ColorMode.LIGHT;
  @StorageLink('showSplash') showSplash: boolean = true;
  @State private count: number = 3
  @State private animationValue: number = 0
  private timer: number = -1

  aboutToAppear() {
    this.timer = setInterval(() => {
      this.count--
      if (this.count < 0) {
        this.showSplash = false
      }
    }, 1000)
  }

  aboutToDisappear(): void {
    clearInterval(this.timer)
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Image(this.colorMode == ColorMode.LIGHT ?
      $r('app.media.splash_bg') : $r('app.media.splash_bg_dark'))
        .objectFit(ImageFit.Fill)
      Image($r('app.media.splash_flutter'))
        .width(280)
        .height(120)
        .offset({ top: LengthMetrics.percent(0.35 + this.animationValue * 0.2) })
        .animation({ duration: 1500, iterations: -1, playMode: PlayMode.Alternate })

      Row() {
        Image($r('app.media.splash_fun'))
          .width(140 * this.animationValue)
          .height(80 * this.animationValue)
          .animation({ duration: 1500, iterations: -1, playMode: PlayMode.Alternate })

        Image($r('app.media.splash_android'))
          .width(200 * (1.01 - this.animationValue))
          .height(80 * (1.01 - this.animationValue))
          .animation({ duration: 1500, iterations: -1, playMode: PlayMode.Alternate })
      }
      .offset({ top: '70%' })
      .justifyContent(FlexAlign.SpaceEvenly)

      Button((this.count == 0 ? '' : `${this.count} | `) + '跳过')
        .position({ right: 20, bottom: 60 })
        .onClick(() => {
          this.showSplash = false
        })
    }.onAppear(() => {
      this.animationValue = 1
    })
  }
}