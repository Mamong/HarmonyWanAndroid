import { LengthMetrics } from "@kit.ArkUI";
import { CommonConstants as Const, ThemeColor } from '../constants/CommonConstants';

@Component
export struct SettingsPage {
  @Consume('pageInfos') pageInfos: NavPathStack
  @StorageLink('language') language: string = "zh-Hans";
  @StorageLink('themeColor') themeColor: number = 0xFF2196F3;
  @State private showColors: boolean = false

  build() {
    NavDestination() {
      List() {
        ListItem() {
          Column() {
            Row() {
              Row() {
                SymbolGlyph($r('sys.symbol.paintpalette_fill')).fontColor([this.themeColor])
                Text('主题').margin({ left: 8 })
              }

              Row() {
                Rect({ width: 35, height: 35 }).fill(this.themeColor)
                SymbolGlyph($r('sys.symbol.arrow_up'))
                  .rotate({ angle: this.showColors ? 0 : 180 })
              }
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
            .height(51)
            .padding({
              left: 12,
              right: 12,
            })
            .onClick(() => {
              animateTo({ curve: Curve.EaseInOut, duration: 500 }, () => {
                this.showColors = !this.showColors
              })
            })

            //这里套一层Column可以让Flex提前布局好，避免了Rect动画
            //visibility直接加到Flex会导致产生Rect动画效果
            Column() {
              Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
                ForEach(Const.themeColors, (color: ThemeColor) => {
                  Rect({ width: 35, height: 35 })
                    .fill(color.color)
                    .onClick(() => {
                      this.themeColor = color.color
                    })
                })
              }
              .padding({
                left: 12,
                right: 12,
                top: 8,
                bottom: 8
              })
            }
            .visibility(this.showColors ? Visibility.Visible : Visibility.None)
          }
          .alignItems(HorizontalAlign.Start)
        }
        .backgroundColor(Color.White)

        ListItem() {
          Row() {
            Row() {
              SymbolGlyph($r('sys.symbol.worldclock')).fontColor([this.themeColor])
              Text('多语言').margin({ left: 8 })
            }

            Row() {
              Text(Const.languages.find(item => item.code == this.language)!.name)
              SymbolGlyph($r('sys.symbol.arrow_right'))
            }
          }
          .width('100%')
          .height(51)
          .padding({
            left: 12,
            right: 12,
          })
          .justifyContent(FlexAlign.SpaceBetween)
          .onClick(() => {
            this.pageInfos.pushPathByName('language', null)
          })
        }
        .backgroundColor(Color.White)
      }
      .divider({ strokeWidth: 1, color: '#ffe9f0f0' })
    }
    .backgroundColor('#F3F4F5')
    .title('设置')
  }
}