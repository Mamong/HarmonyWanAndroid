import { OnBoardingItem } from "../view/OnBoardingItem"

@Component
export struct OnBoardingPage{
  @StorageLink('firstLaunch') firstLaunch: boolean = true;

  build() {
    Swiper() {
      OnBoardingItem({index:1})
      OnBoardingItem({index:2, onEnterApp:()=>{
        this.firstLaunch = false
      }})
    }
    .width('100%')
    .indicator(
      Indicator.dot()
        .itemWidth(15)
        .itemHeight(15)
        .selectedItemWidth(30)
        .selectedItemHeight(15)
        .color(Color.White)
        .selectedColor(Color.Orange)
    )
  }
}