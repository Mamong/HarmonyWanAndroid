import { ArticleList, ArticleSource } from "../view/ArticleList"

@Component
export struct CollectionArticlesPage {

  build() {
    NavDestination() {
      ArticleList({ source: ArticleSource.Collection })
    }
    .title('我的收藏')
  }
}