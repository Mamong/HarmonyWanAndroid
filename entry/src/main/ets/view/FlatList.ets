import { EmptyBuilder } from "../constants/CommonConstants"

@Component
export struct FlatList {
  @Link isRefreshing: boolean
  @Require @Prop data: object[]
  onRefresh?: () => void
  onEndReached?: () => void
  onDidScroll?: () => void
  scroller?: Scroller
  @BuilderParam refreshControl?: () => void;
  @BuilderParam listEmpty?: () => void;
  @BuilderParam listHeader?: () => void;
  @BuilderParam listFooter?: () => void;
  @Require @BuilderParam listItem: (value: object, index: number) => void = EmptyBuilder;

  build() {
    if (this.data.length == 0 && !this.isRefreshing) {
      if (this.listEmpty) {
        this.listEmpty()
      }
    } else {
      Refresh({ refreshing: $$this.isRefreshing, builder: this.refreshControl && this.refreshControl() }) {
        List({ scroller: this.scroller }) {
          if (this.listHeader) {
            ListItem() {
              this.listHeader()
            }
          }

          ForEach(this.data, (item: object, index: number) => {
            ListItem() {
              this.listItem(item, index)
            }
          })

          if (this.listFooter) {
            ListItem() {
              this.listFooter()
            }
          }
        }
        .width('100%')
        .height('100%')
        .onReachEnd(() => {
          this.onEndReached && this.onEndReached()
        })
        .onDidScroll(() => {
          this.onDidScroll && this.onDidScroll()
        })
      }
      .onStateChange(async (status) => {
        switch (status) {
          case RefreshStatus.Inactive:
            break
          case RefreshStatus.Drag:
            //this.refreshText = '继续往下拉'
            break
          case RefreshStatus.OverDrag:
            //this.refreshText = '松手加载'
            break
          case RefreshStatus.Refresh:
            //this.refreshText = '加载中'
            this.onRefresh && this.onRefresh()
            break
          case RefreshStatus.Done:
            //this.refreshText = '加载成功'
            break
          default:
            break
        }
      })
    }
  }
}