import { NavigationBarView } from '../src/main/ets/components/NavigationBarView'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        NavigationBarView({
          centerContent: () => {
            this.navigationBarTitleBuilder()
          },
          rightFirstImageContent: () => {
            this.navImages()
          }
        })

        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
    .alignItems(VerticalAlign.Top)
    .backgroundColor(Color.Gray)
  }

  @Builder navigationBarTitleBuilder() {
    Text("替换后的组件演示")
      .fontSize(16)
  }

  @Builder navImages() {
    Image($r("sys.media.ohos_app_icon"))
      .objectFit(ImageFit.Contain)
      .width(20)
      .height(20)
  }

}