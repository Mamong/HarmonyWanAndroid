import { EmptyBuilder } from "../constants/CommonConstants"
import { ApiException } from "../utils/Request"
import { FlatList } from "./FlatList"
import { ActivityLoading } from "./LoadingView"
import { DefaultEmpty, DefaultError } from "./PlaceholderView"

@Component
export struct CommonFlatList {
  @Consume('pageInfos') pageInfos: NavPathStack

  @Prop isLoading: boolean
  @Prop isSuccess: boolean
  @Prop hasMoreData: boolean
  @Prop error: ApiException | null = null
  @Prop showGoTop: boolean = false
  //内部根据滚动位置控制GoTopButton的显式与隐藏
  @State private showTop: boolean = false
  private scroller = new Scroller()
  //FlatListProp
  @Link isRefreshing: boolean
  @Require @Prop data: object[]
  onRefresh?: () => void
  onEndReached?: () => void
  @BuilderParam listHeader?: () => void;
  @Require @BuilderParam listItem: (value: object) => void = EmptyBuilder;

  @Builder
  listFooter() {
    Row() {
      if(this.hasMoreData) {
        LoadingProgress().width(20).height(20)
      }
      Text(this.hasMoreData ? '加载中...' : '没有更多数据了')
        .padding(12)
    }.justifyContent(FlexAlign.Center)
    .width('100%')
  }

  @Builder
  listEmpty(){
    DefaultEmpty()
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      //初次加载
      if (this.isLoading) {
        ActivityLoading()
      } else {
        //失败且数据为空，所有错误都通过toast展示
        if (this.error && this.data.length == 0) {
          DefaultError({
            error: this.error.message,
            actionTitle: this.error.errorCode == -1001 ? "去登录" : "重试",
            action: this.error.errorCode == -1001 ? () => {
              this.pageInfos.pushPathByName('login', null)
            } : this.onRefresh
          })
        } else {
          //成功或已有数据
          FlatList({
            scroller: this.scroller,
            data: this.data,
            listHeader: this.listHeader,
            listItem: this.listItem,
            // refreshControl: () => {
            //
            // },
            listEmpty: () => {
              this.listEmpty()
            },
            listFooter: () => {
              this.listFooter()
            },
            onRefresh: this.onRefresh,
            onEndReached: this.onEndReached,
            onDidScroll: () => {
              if (!this.showGoTop) {
                return
              }
              if (this.scroller.currentOffset().yOffset > 0) {
                this.showTop = true
              } else {
                this.showTop = false
              }
            },
            isRefreshing: this.isRefreshing
          })
        }
      }
      if (this.showGoTop && this.showTop) {
        Button({ type: ButtonType.Circle, stateEffect: true }) {
          SymbolGlyph($r('sys.symbol.arrow_up_to_line'))
            .fontSize(32)
            .renderingStrategy(SymbolRenderingStrategy.SINGLE)
            .fontColor([Color.Black, Color.Green, Color.White])
        }
        .onClick(() => {
          this.scroller.scrollTo({ xOffset: 0, yOffset: 0, animation: true })
        })
        .backgroundColor(0x317aff)
        .width(60)
        .height(60)
        .position({ right: 12, bottom: 12 })
      }
    }
    .width('100%')
    .height('100%')
  }
}