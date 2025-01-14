import ArticleVm from "../viewmodel/ArticleViewModel"
import { ListResponse, Article } from "../viewmodel/Models";
import { ApiException } from "../utils/Request";
import { toastShort } from "../utils/ToastUtils";
import { ArticleListItem } from "./ArticleListItem";
import { CommonFlatList } from "./CommonFlatList";

@Component
export struct ArticleList {
  source: ArticleSource = ArticleSource.Home
  ext: number | string = 0
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

    if (this.isRefreshing) {
      page = this.source > 2 ? 1 : 0;
    }
    let request: Promise<ListResponse>
    switch (this.source) {
      case ArticleSource.Home:
      case ArticleSource.Collection:
        request = ArticleVm.getArticleList(page);
        break;
      case ArticleSource.Search:
        request = ArticleVm.getSearchArticleList(this.ext as string, page);
        break;
      case ArticleSource.Hierarchy:
        request = ArticleVm.getHierarchyArticleList(this.ext as number, page);
        break;
      case ArticleSource.Project:
        request = ArticleVm.getProjectArticleList(this.ext as number, page);
        break;
      case ArticleSource.WxArticle:
        request = ArticleVm.getWxArticleList(this.ext as number, page);
        break;
      default:
        request = ArticleVm.getArticleList(page);
        break;
    }
    return request.then((value: ListResponse) => {
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
    console.info(`=====aboutToAppear:${this.ext}=====`)
  }

  @Builder
  listItem(value: Article) {
    ArticleListItem({ item: value })
  }

  build() {
    Column() {
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
        // listHeader: () => {
        //
        // },
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
}

export enum ArticleSource {
  Home, Collection, Search, Hierarchy, Project, WxArticle
}