import { webview } from "@kit.ArkWeb";
import { BusinessError } from "@kit.BasicServicesKit";
import { NavigationTitle } from "../constants/CommonConstants";

@Component
export struct Webview {
  @Consume('pageInfos') pageInfos: NavPathStack
  @State param:WebviewParam = new WebviewParam()
  private controller: webview.WebviewController = new webview.WebviewController();

  aboutToAppear(): void {
    try {
      webview.WebviewController.setWebDebuggingAccess(true);
    } catch (error) {
      console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
    }
  }

  build() {
    NavDestination() {
      Web({ src: this.param.url, controller: this.controller })
        .onProgressChange((event) => {
          if (event) {
            console.log('newProgress:' + event.newProgress);
          }
        })
    }
    .title(NavigationTitle(this.param.title))
    // .onReady(cxt => {
    //   let param = cxt.pathInfo.param as WebviewParam
    //   this.title = param.title
    //   this.url = param.url
    // })
  }
}


export class WebviewParam {
  title: ResourceStr
  url: string

  constructor(title:ResourceStr="", url:string="") {
    this.title = title
    this.url = url
  }
}