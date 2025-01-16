import { NavigationTitle } from "../../../../constants/CommonConstants"
import { RegisterForm } from "../views/RegisterForm"

@Component
export struct RegisterPage {

  build() {
    NavDestination() {
      RegisterForm()
    }.title(NavigationTitle($r('app.string.register')))
  }
}