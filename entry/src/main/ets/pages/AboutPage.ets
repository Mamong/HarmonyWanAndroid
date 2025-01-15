import { common, Want } from '@kit.AbilityKit';
import { CommonConstants as Const, NavigationTitle } from '../constants/CommonConstants';

@Component
export struct AboutPage {
  @StorageLink('themeColor') themeColor: number = 0xFF2196F3

  openLink(link: string) {
    //https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/start-email-apps-by-mailto-V5
    let context = getContext(this) as common.UIAbilityContext;

    let want: Want
    if(link.startsWith('http')){
      want = {
        action: 'ohos.want.action.viewData',
        entities: ['entity.system.browsable'],
        uri: link,
      }
    }else{
      want = {
        action: 'ohos.want.action.sendToData',
        uri: link
      }
    }
    context.startAbility(want)
  }

  build() {
    NavDestination() {
      Column() {
        Column() {
          Image($r('app.media.logo')).size({ width: 90, height: 90 })
          Text($r('app.string.about_desc')).margin({ top: 10 })

          Column() {

            Text() {
              Span($r('app.string.about_email'))
              Span(":")
              Span(Const.qqEmail)
                .decoration({ type: TextDecorationType.Underline, color: this.themeColor })
                .fontColor(this.themeColor).onClick(() => {
                this.openLink("mailto://" + Const.qqEmail)
              })
            }
            .fontSize(15)

            Text() {
              Span("CSDN:")
              Span(Const.csdnStr)
                .decoration({ type: TextDecorationType.Underline, color: this.themeColor })
                .fontColor(this.themeColor).onClick(() => {
                this.openLink(Const.csdnStr)
              })
            }
            .fontSize(15)
            .margin({ top: 25 })

            Text() {
              Span("Github:")
              Span(Const.gitHubStr)
                .decoration({ type: TextDecorationType.Underline, color: this.themeColor })
                .fontColor(this.themeColor)
                .onClick(() => {
                  this.openLink(Const.gitHubStr)
                })
            }
            .fontSize(15)
            .margin({ top: 25 })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ top: 50 })
        }
        .margin({ top: 75 })

        Text($r('app.string.about_bottom')).align(Alignment.Bottom)
          .margin({ bottom: 25 })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .height('100%')
    }
    .title(NavigationTitle($r('app.string.menu_about')))
  }
}