import { ApiException } from "../utils/Request"
import { toast } from "../utils/ToastUtils"
import HomeVm from "../viewmodel/HomeViewModel"
import { Article, Navi } from "../viewmodel/Models"
import { LengthMetrics } from "@kit.ArkUI"
import { NavigationBarView } from "@mamong/navigationbarview"
import { CommonConstants as Const } from '../constants/CommonConstants';
import { WebviewParam } from "./WebViewPage"
import { ActivityLoading } from "../view/LoadingView"

@Component
export struct NavigationPage {
  @Consume('pageInfos') pageInfos: NavPathStack
  @StorageLink('themeColor') themeColor: number = 0xFF2196F3;

  @State private navi: Navi[] = []
  @State private selectedIndex: number = 0
  @State private isLoading: boolean = false

  private leftScroller = new Scroller()
  private rightScroller = new Scroller()
  private scrollRight = false

  aboutToAppear(): void {
    this.isLoading = true
    HomeVm.getGuideList().then((value: Navi[]) => {
      this.navi = value

    }).catch((err: ApiException) => {
      toast(this.getUIContext(), err.message)
    }).finally(()=>{
      this.isLoading = false
    })
  }

  @Builder
  listItem(item: Navi) {
    Column() {
      Text(item.name).fontSize(16).fontWeight(FontWeight.Bold)
      Blank().height(10)
      Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.px(15), cross: LengthMetrics.px(20) } }) {
        ForEach(item.articles, (item: Article) => {
          Button(item.title)
            // .fontSize(14)
            .labelStyle({ overflow: TextOverflow.Ellipsis,
              maxLines: 2,
              minFontSize: 12,
              maxFontSize: 14,
              heightAdaptivePolicy:TextHeightAdaptivePolicy.LAYOUT_CONSTRAINT_FIRST,
              font: {
                size: 14,
              }
            })
            .backgroundColor(Const.chapterBgColor[item.id%10])
            .height(32)
            .onClick(() => {
              this.pageInfos.pushPathByName('webview', new WebviewParam(item.title, item.link))
            })
        })
      }
    }
    .backgroundColor(Color.White)
    .padding(10)
    .borderRadius(10)
    .margin({ left: 12, right: 12 })
  }

  build() {
    Column() {
      Column() {
        NavigationBarView({ title: '导航', showBack: false, navHeight: 44 })
        if(this.isLoading){
          ActivityLoading()
        }else {
          Row() {
            List({ scroller: this.leftScroller }) {
              ForEach(this.navi, (item: Navi, index: number) => {
                ListItem() {
                  Text(item.name)
                    .fontColor(index == this.selectedIndex ? this.themeColor : Color.Black)
                    .backgroundColor(index == this.selectedIndex ? Color.White : '#F3F4F5')
                    .textAlign(TextAlign.Center)
                    .padding({ top: 8, bottom: 8 })
                    .width(100)
                    .onClick(() => {
                      this.selectedIndex = index
                      this.rightScroller.scrollToIndex(index, true)
                    })
                }
              })
            }.width(100)

            List({ space: 12, scroller: this.rightScroller }) {
              ForEach(this.navi, (item: Navi) => {
                ListItem() {
                  this.listItem(item)
                }
              })
            }
            .onTouch(() => {
              this.scrollRight = true
            })
            .onDidScroll(() => {
              if (!this.scrollRight) return
              let currentIndex = 0
              this.navi.forEach((value: Navi, index: number) => {
                let rect = this.rightScroller.getItemRect(index)
                if (0 > rect.y && 0 < rect.y + rect.height) {
                  currentIndex = index
                }
              })
              this.leftScroller.scrollToIndex(currentIndex, true)
              this.scrollRight = false
            })
            .layoutWeight(1)
          }
        }
      }
    }
    .backgroundColor('#F3F4F5')
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height('100%')
  }
}