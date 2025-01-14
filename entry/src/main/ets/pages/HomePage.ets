import { Banner } from "../viewmodel/Models"
import HomeVm from "../viewmodel/HomeViewModel"

import ArticleVm from "../viewmodel/ArticleViewModel"
import { ListResponse, Article } from "../viewmodel/Models";
import { ApiException } from "../utils/Request";
import { toastShort } from "../utils/ToastUtils";
import { ArticleListItem } from "../view/ArticleListItem";
import { CommonFlatList } from "../view/CommonFlatList";
import { NavigationBarView } from "@mamong/navigationbarview"

@Component
export struct HomePage {
  @Consume('pageInfos') pageInfos: NavPathStack

  onClickMenu?: () => void
  @State private banners: Banner[] = []
  @State private isLoading: boolean = false
  @State private isSuccess: boolean = false
  //初次下载
  @State private isFetching: boolean = false
  @State private hasMoreData: boolean = false
  @State private error: ApiException | null = null
  @State private data: Article[] = [];
  @State private isRefreshing: boolean = false
  @State private curPage: number = 0

  loadData(page: number = 0): Promise<void> {
    this.isFetching = true

    let request: Promise<object>[] = [ArticleVm.getArticleList(page)]
    if (this.isRefreshing) {
      page = 0
      request.push(ArticleVm.getTopList())
    }

    return Promise.all(request).then((values: object[]) => {
      let value = values[0] as ListResponse
      this.curPage = page;
      if (this.isRefreshing) {
        let value2 = values[1] as Article[]
        value2.forEach(item => item.isTop = true)
        this.data = [...value2, ...value.datas];
      } else {
        this.data.push(...value.datas);
      }
      this.hasMoreData = !value.over;

      this.isSuccess = true
      this.error = null
    })
      .catch((err: ApiException) => {
        this.isSuccess = false
        this.error = err
        toastShort(this.getUIContext(), err.message)
      }).finally(() => {
        this.isRefreshing = false
        this.isFetching = false
        this.isLoading = false
      });
  }

  loadMore() {
    if (this.isLoading || this.isFetching || !this.hasMoreData) {
      return
    }
    return this.loadData(this.curPage + 1);
  }

  aboutToAppear(): void {
    this.isLoading = true
    this.isRefreshing = true
    this.loadData()

    HomeVm.getBanner().then((value: Banner[]) => {
      this.banners = value
    }).catch((err: ApiException) => {
      toastShort(this.getUIContext(), err.message)
    });
  }

  @Builder
  header() {
    if(this.banners.length) {
      Swiper() {
        ForEach(this.banners, (item: Banner) => {
          Image(item.imagePath).height(190).width('100%')
        })
      }
      .height(190)
      .margin({bottom:12})
      .indicator(Indicator.digit()// 设置数字导航点样式
        .bottom(0)
        .right(0)
        .fontColor(Color.Gray))
      .loop(true)
      .autoPlay(true)
      .interval(3000)
    }
  }

  @Builder
  listItem(value: Article) {
    ArticleListItem({ item: value })
  }

  build() {
    Column() {
      Column() {
        NavigationBarView({
          title: '玩安卓',
          showBack: false,
          navHeight: 44,
          leftMenus: [
            {
              'value': "", 'symbolIcon': $r('sys.symbol.list_bullet'), 'action': () => {
              this.onClickMenu && this.onClickMenu()
            }
            }
          ],
          rightMenus: [
            {
              'value': "", 'symbolIcon': $r('sys.symbol.magnifyingglass'), 'action': () => {
                this.pageInfos.pushPathByName('hotkeys',null)
            }
            }]
        })
        CommonFlatList({
          showGoTop: true,
          isLoading: this.isLoading,
          isSuccess: this.isSuccess,
          hasMoreData: this.hasMoreData,
          error: this.error,
          data: this.data,
          listItem: (value: object) => {
            this.listItem(value as Article)
          },
          listHeader: () => {
            this.header()
          },
          onRefresh: () => {
            this.loadData()
          },
          onEndReached: () => {
            this.loadMore()
          },
          isRefreshing: $isRefreshing
        })
      }
    }
    .justifyContent(FlexAlign.Start)
    .backgroundColor('#F3F4F5')
    .width('100%')
    .height('100%')
  }
}