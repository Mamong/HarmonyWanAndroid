import userVm from "../viewmodel/UserViewModel"

import { CoinDetail, CoinInfo, CoinListResponse } from "../viewmodel/Models"
import { CommonConstants as Const, NavigationTitle } from '../constants/CommonConstants';

import { ApiException } from "../utils/Request";
import { toastShort } from "../utils/ToastUtils";
import { CommonFlatList } from "../view/CommonFlatList";
import { NavigationBarView } from "@mamong/navigationbarview"
import { CoinDetailListItem, CoinDetailSkeletonItem } from "../view/CoinDetailListItem";
import { SymbolGlyphModifier } from "@kit.ArkUI";
import { WebviewParam } from "./WebViewPage";
import { CoinDetailListHeader, CoinDetailSkeletonHeader } from "../view/CoinDetailListHeader";

@Component
export struct CoinDetailsPage {
  @Consume('pageInfos') pageInfos: NavPathStack
  @StorageLink('themeColor') themeColor: number = 0xFF2196F3
  @State private coinInfo: CoinInfo | null = null
  @State private isLoading: boolean = false
  @State private isSuccess: boolean = false
  //初次下载
  @State private isFetching: boolean = false
  @State private hasMoreData: boolean = false
  @State private error: ApiException | null = null
  @State private data: CoinDetail[] = [];
  @State private isRefreshing: boolean = false
  @State private curPage: number = 1

  loadData(page: number = 0): Promise<void> {
    this.isFetching = true

    if (this.isRefreshing) {
      page = 1
    }

    return userVm.getCoinDetails(page).then((value: CoinListResponse) => {
      this.curPage = page;
      if (this.isRefreshing) {
        this.data = value.datas;
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

    userVm.getCoinInfo().then((value: CoinInfo) => {
      this.coinInfo = value
    }).catch((err: ApiException) => {
      toastShort(this.getUIContext(), err.message)
    });
  }

  @Builder
  header() {
    if (this.coinInfo) {
      CoinDetailListHeader({ coinInfo: this.coinInfo })
    }
  }

  @Builder
  listItem(value: CoinDetail) {
    CoinDetailListItem({ item: value })
  }

  @Builder
  listItemSkeleton(index: number) {
    if (index == 0) {
      CoinDetailSkeletonHeader()
    } else {
      CoinDetailSkeletonItem()
    }
  }

  build() {
    NavDestination() {
      Column() {
        CommonFlatList({
          skeletonCount: 10,
          showGoTop: true,
          isLoading: this.isLoading,
          isSuccess: this.isSuccess,
          hasMoreData: this.hasMoreData,
          error: this.error,
          data: this.data,
          listItem: (value: object) => {
            this.listItem(value as CoinDetail)
          },
          listItemSkeleton: (index: number) => {
            this.listItemSkeleton(index)
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
      .backgroundColor('#F3F4F5')
    }
    .menus([
      {
        value: '', symbolIcon: new SymbolGlyphModifier($r('sys.symbol.questionmark_circle')), action: () => {
        this.pageInfos.pushPathByName('webview', new WebviewParam($r('app.string.points_rule'), Const.pointRule))
      }
      }
    ])
    .title(NavigationTitle($r('app.string.menu_points_details')))
  }
}