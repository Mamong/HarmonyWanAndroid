import { i18n } from '@kit.LocalizationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { CommonConstants as Const, Language, NavigationTitle } from '../constants/CommonConstants';

@Component
export struct LanguagePage {
  @StorageLink('language') language: string = "zh-Hans";

  aboutToAppear(): void {
    let displayLanguage = i18n.System.getDisplayLanguage("de", "zh-Hans-CN"); // 德文
    let displayCountry = i18n.System.getDisplayCountry("SA", "en-GB"); // Saudi Arabia
    // language: 语言两字母代码，如"zh"，"de"，"fr"等
    // locale: 本地化标识符，如"en-GB"、"en-US"、"zh-Hans-CN"等
    // sentenceCase: 返回的语言名称是否需要首字母大写，默认值：true

    // 获取系统语言
    let systemLanguage = i18n.System.getSystemLanguage();  // systemLanguage为当前系统语言
    // 获取系统地区
    let systemRegion = i18n.System.getSystemRegion();  // systemRegion为当前系统地区
    // 获取系统区域
    let systemLocale = i18n.System.getSystemLocale();  // systemLocale为当前系统区域
    // 获取应用偏好语言，默认为空，随系统
    let appPreferredLanguage: string = i18n.System.getAppPreferredLanguage(); // 获取应用偏好语言
    console.log(appPreferredLanguage)
  }

  build() {
    NavDestination() {
      List() {
        ForEach(Const.languages, (value: Language) => {
          ListItem() {
            Row() {
              Text(value.name)
              SymbolGlyph($r('sys.symbol.checkmark'))
                .visibility(value.code == this.language ? Visibility.Visible : Visibility.Hidden)
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
            .height(51)
            .padding({
              left: 12,
              right: 12,
            })
          }
          .backgroundColor(Color.White)
          .onClick(()=>{
            this.language = value.code
            try {
              i18n.System.setAppPreferredLanguage(value.code); // 设置应用偏好语言为zh-Hans
            } catch(error) {
              let err: BusinessError = error as BusinessError;
              console.error(`call System.setAppPreferredLanguage failed, error code: ${err.code}, message: ${err.message}.`);
            }
          })
        })
      }
      .divider({ strokeWidth: 1, color: '#ffe9f0f0' })
    }
    .backgroundColor('#F3F4F5')
    .title(NavigationTitle($r('app.string.language')))
  }
}