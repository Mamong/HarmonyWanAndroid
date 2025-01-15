import { NavigationTitle } from "../constants/CommonConstants"
import { ApiException } from "../utils/Request"
import { toastShort } from "../utils/ToastUtils"
import { UserInfo } from "../viewmodel/Models"
import userVm from "../viewmodel/UserViewModel"

@Component
export struct LoginPage {
  @Consume('pageInfos') pageInfos: NavPathStack
  @State private isLoading: boolean = false

  private uname: string = ""
  private password: string = ""

  login() {
    if (this.uname.length == 0) {
      toastShort(this.getUIContext(), $r('app.string.tips_username_empty'))
      return
    }
    if (this.password.length == 0) {
      toastShort(this.getUIContext(), $r('app.string.tips_pwd_empty'))
      return
    }
    this.isLoading = true
    userVm.login(this.uname, this.password).then((value: UserInfo) => {
      PersistentStorage.persistProp<string>("username", value.username)
      AppStorage.setOrCreate("username", value.username)
      toastShort(this.getUIContext(), $r('app.string.login_success'))
      this.pageInfos.pop(true)
    }).catch((error: ApiException) => {
      toastShort(this.getUIContext(), error.message)
    }).finally(() => {
      this.isLoading = false
    })
  }

  build() {
    //键盘避让
    NavDestination() {
      Scroll() {
        Column() {
          Row() {
            SymbolGlyph($r("sys.symbol.person"))
            TextInput({ placeholder: $r('app.string.login_userName') })
              .onChange((value: string) => {
                console.info(value);
                this.uname = value
              })
          }.margin({ top: 80 })

          Row() {
            SymbolGlyph($r("sys.symbol.lock"))
            TextInput({ placeholder: $r('app.string.login_pwd') })
              .type(InputType.Password)
              .onChange((value: string) => {
                console.info(value);
                this.password = value
              })
          }.margin({ top: 20 })

          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Row() {
              if (this.isLoading) {
                LoadingProgress().width(40).height(40).color(Color.White)
              } else {
                Text($r('app.string.login')).fontSize(18).fontColor(Color.White)
              }
            }
            .height(50)
            .justifyContent(FlexAlign.Center)
            .padding({ left: 25, right: 25 })
            .alignItems(VerticalAlign.Center)
          }
          .onClick(() => {
            this.login()
          })
          .enabled(!this.isLoading)
          .width('100%')
          .margin({ top: 40, left: 25, right: 25 })

          Row() {
            Text($r('app.string.login_to_register'))
            Button($r('app.string.register'), { buttonStyle: ButtonStyleMode.TEXTUAL })
              .onClick(() => {
                this.pageInfos.replacePathByName('register', null)
              })
          }.margin({ top: 20 })
        }
        .padding({ left: 40, right: 40 })
      }
      .align(Alignment.TopStart)
      .height('100%')
    }
    .title(NavigationTitle($r('app.string.login')))
  }
}