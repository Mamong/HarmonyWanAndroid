import { ApiException } from "../../../../utils/Request"
import { toastShort } from "../../../../utils/ToastUtils"
import { Register } from "../../domain/usecases/register"
import { myContainer } from "../../../../core/services/injection_container";
import { User } from "../../domain/entities/user";

@Component
export struct RegisterForm {
  @Consume('pageInfos') pageInfos: NavPathStack
  @State private isLoading: boolean = false
  private uname: string = ""
  private password: string = ""
  private repassword: string = ""

  register() {
    if (this.uname.length == 0) {
      toastShort(this.getUIContext(), $r('app.string.tips_username_empty'))
      return
    }
    if (this.password.length == 0) {
      toastShort(this.getUIContext(), $r('app.string.tips_pwd_empty'))
      return
    }
    if (this.repassword.length == 0) {
      toastShort(this.getUIContext(), $r('app.string.tips_pwd_confirm_empty'))
      return
    }
    // if (this.password != this.repassword) {
    //   toastShort(this.getUIContext(), "两次输入的密码不同")
    //   return
    // }
    this.isLoading = true
    const register = myContainer.get<Register>(Register);

    register.call({ username: this.uname, password: this.password, repassword: this.repassword })
      .then((value: User) => {
        PersistentStorage.persistProp<string>("username", value.username)
        AppStorage.setOrCreate("username", value.username)
        toastShort(this.getUIContext(), $r('app.string.login_success'))
        this.pageInfos.pop()
      })
      .catch((error: ApiException) => {
        toastShort(this.getUIContext(), error.message)
      })
      .finally(() => {
        this.isLoading = false
      })
  }

  build() {
    //键盘避让
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

        Row() {
          SymbolGlyph($r("sys.symbol.lock"))
          TextInput({ placeholder: $r('app.string.register_confirm_pwd') })
            .type(InputType.Password)
            .onChange((value: string) => {
              console.info(value);
              this.repassword = value
            })
        }.margin({ top: 20 })

        Button({ type: ButtonType.Capsule, stateEffect: true }) {
          Row() {
            if (this.isLoading) {
              LoadingProgress().width(40).height(40).color(Color.White)
            } else {
              Text($r('app.string.register')).fontSize(18).fontColor(Color.White)
            }
          }
          .height(50)
          .justifyContent(FlexAlign.Center)
          .padding({ left: 25, right: 25 })
          .alignItems(VerticalAlign.Center)
        }
        .onClick(() => {
          this.register()
        })
        .enabled(!this.isLoading)
        .width('100%')
        .margin({ top: 40, left: 25, right: 25 })

        Row() {
          Text($r('app.string.register_to_login'))
          Button($r('app.string.login'), { buttonStyle: ButtonStyleMode.TEXTUAL })
            .onClick(() => {
              this.pageInfos.replacePathByName('login', null)
            })
        }.margin({ top: 20 })
      }
      .padding({ left: 40, right: 40 })
    }
    .align(Alignment.TopStart)
    .height('100%')
  }
}