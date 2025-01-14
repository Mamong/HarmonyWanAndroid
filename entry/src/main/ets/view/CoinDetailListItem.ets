import { CoinDetail } from "../viewmodel/Models";

@Component
export struct CoinDetailListItem{
  item: CoinDetail = new CoinDetail();

  build() {
    Row(){
      Column(){
        Text(this.item.reason).fontSize(15)
        Text(this.item.desc)
          .fontSize(14)
          .margin({top:6})
      }
      .alignItems(HorizontalAlign.Start)
      Text("+"+this.item.coinCount)
        .fontColor(Color.Green)
    }
    .backgroundColor(Color.White)
    .padding(12)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}