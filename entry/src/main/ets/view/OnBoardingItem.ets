@Extend(Text)
function headingBold() {
  .lineHeight(58)
  .fontSize(48)
  .fontWeight(700)
}

@Component
export struct OnBoardingItem {
  onEnterApp?: () => void
  index: number = 1

  build() {
    Stack() {
      Image(this.index == 1 ? $r('app.media.on_boarding1') : $r('app.media.on_boarding2'))
        .objectFit(ImageFit.Cover)
      Column() {
        if (this.index == 1) {
          Text() {
            Span('One-Stop\n')
            Span('Android Learning.').fontColor(Color.Orange)
          }.headingBold()
        } else {
          Text() {
            Span('Clean Architecture With ')
            Span('Riverpod.').fontColor(Color.Orange)
          }.headingBold()
        }
        if (this.index == 2) {
          Button($r('app.string.onBoardingEnter')).onClick(() => {
            this.onEnterApp && this.onEnterApp()
          })
            .alignSelf(ItemAlign.Stretch)
            .margin({ bottom: 44, left: 20, right: 20 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}