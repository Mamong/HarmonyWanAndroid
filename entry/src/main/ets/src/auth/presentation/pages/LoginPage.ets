import { NavigationTitle } from "../../../../constants/CommonConstants"
import { LoginForm } from "../views/LoginForm"

@Component
export struct LoginPage {

  build() {
    NavDestination() {
      LoginForm()
      .height('100%')
    }
    .title(NavigationTitle($r('app.string.login')))
  }
}