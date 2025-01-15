import { NavigationTitle } from "../constants/CommonConstants"
import { ArticleList, ArticleSource } from "../view/ArticleList"

@Component
export struct CollectionArticlesPage {

  build() {
    NavDestination() {
      ArticleList({ source: ArticleSource.Collection })
    }
    .title(NavigationTitle($r('app.string.menu_collection')))
  }
}