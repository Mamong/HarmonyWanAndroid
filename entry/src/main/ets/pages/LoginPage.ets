import { ApiException } from "../utils/Request"
import { toast, toastShort } from "../utils/ToastUtils"
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
      toastShort(this.getUIContext(), "用户名不能为空")
      return
    }
    if (this.password.length == 0) {
      toastShort(this.getUIContext(), "密码不能为空")
      return
    }
    this.isLoading = true
    userVm.login(this.uname, this.password).then((value: UserInfo) => {
      PersistentStorage.persistProp<string>("username", value.username)
      AppStorage.setOrCreate("username", value.username)
      toastShort(this.getUIContext(), "登陆成功")
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
            TextInput({ placeholder: "用户名" })
              .onChange((value: string) => {
                console.info(value);
                this.uname = value
              })
          }.margin({ top: 80 })

          Row() {
            SymbolGlyph($r("sys.symbol.lock"))
            TextInput({ placeholder: "密码" })
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
                Text('登录').fontSize(18).fontColor(Color.White)
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
            Text("新用户？去")
            Button("注册", { buttonStyle: ButtonStyleMode.TEXTUAL })
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
    .title('登录')
  }
}