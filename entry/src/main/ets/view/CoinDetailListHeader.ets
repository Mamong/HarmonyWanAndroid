import { CoinInfo } from "../viewmodel/Models";
import { SkeletonBox } from "./SkeletonBox";

@Extend(Text)
function infoTitle() {
  .fontColor(Color.White).fontSize(18)
}

@Extend(Text)
function infoContent() {
  .fontColor(Color.White)
  .fontSize(28)
  .fontWeight(FontWeight.Bold)
}

@Component
export struct CoinDetailListHeader{
  @StorageLink('themeColor') themeColor: number = 0xFF2196F3;
  @Require coinInfo: CoinInfo = new CoinInfo()

  build() {
    Grid() {
      GridItem() {
        Column({space:4}) {
          Text($r('app.string.points_rank')).infoTitle()
          Text("" + this.coinInfo.rank).infoContent()
        }
      }
      GridItem() {
        Column({space:4}) {
          Text($r('app.string.points_level')).infoTitle()
          Text("" + this.coinInfo.level).infoContent()
        }
      }

      GridItem() {
        Column({space:4}) {
          Text($r('app.string.points_point')).infoTitle()
          Text("" + this.coinInfo.coinCount).infoContent()
        }
      }
    }
    .rowsTemplate('1fr')
    .columnsTemplate('1fr 1fr 1fr')
    .backgroundColor(this.themeColor)
    .width('100%')
    .height(100)
  }
}

@Component
export struct CoinDetailSkeletonHeader{
  @StorageLink('themeColor') themeColor: number = 0xFF2196F3;

  build() {
    Grid() {
      GridItem() {
        Column({space:4}) {
          SkeletonBox().width(40).height(20)
          SkeletonBox().width(80).height(30)
        }
      }
      GridItem() {
        Column({space:4}) {
          SkeletonBox().width(40).height(20)
          SkeletonBox().width(80).height(30)
        }
      }

      GridItem() {
        Column({space:4}) {
          SkeletonBox().width(40).height(20)
          SkeletonBox().width(80).height(30)
        }
      }
    }
    .rowsTemplate('1fr')
    .columnsTemplate('1fr 1fr 1fr')
    .backgroundColor(this.themeColor)
    .width('100%')
    .height(100)
  }
}