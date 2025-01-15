import { CoinDetail } from "../viewmodel/Models";
import { SkeletonBox } from "./SkeletonBox";

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

@Component
export struct CoinDetailSkeletonItem{

  build() {
    Row(){
      Column(){
        SkeletonBox().width(30).height(20)
        SkeletonBox().width(280).height(20)
          .margin({top:6})
      }
      .alignItems(HorizontalAlign.Start)
      SkeletonBox().width(30).height(20)
    }
    .backgroundColor(Color.White)
    .padding(12)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}