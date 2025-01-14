import { ArticleList, ArticleSource } from "../view/ArticleList"

@Component
export struct SearchResultPage {
  param: SearchResultParam = new SearchResultParam()

  build() {
    NavDestination() {
      ArticleList({ source: ArticleSource.Search, ext: this.param.keyword })
    }
    .title(this.param.keyword)
  }
}

export class SearchResultParam {
  keyword: string

  constructor(keyword: string = "") {
    this.keyword = keyword
  }
}