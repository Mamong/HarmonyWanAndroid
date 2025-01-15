import { ApiException } from "../utils/Request"
import { toastShort } from "../utils/ToastUtils"
import ArticleVm from "../viewmodel/ArticleViewModel"
import { Hotkey } from "../viewmodel/Models"
import { LengthMetrics } from "@kit.ArkUI"
import { CommonConstants as Const } from '../constants/CommonConstants';
import { SearchResultParam } from "./SearchResultPage"
import { ActivityLoading } from "../view/LoadingView"

@Component
export struct SearchPage {
  @Consume('pageInfos') pageInfos: NavPathStack
  @State private keywords: Hotkey[] = []
  @State private keyword: string = ""
  @State private isLoading: boolean = false

  aboutToAppear(): void {
    this.isLoading = true
    ArticleVm.getHotkeys().then((value: Hotkey[]) => {
      this.keywords = value
    }).catch((err: ApiException) => {
      toastShort(this.getUIContext(), err.message)
    }).finally(()=>{
      this.isLoading = false
    })
  }

  @Builder
  search() {
    Search({ value: this.keyword, placeholder: $r('app.string.search_placeholder') })
      .searchButton('搜索')
      .height(40)
      .backgroundColor('#F5F5F5')
      .placeholderColor(Color.Grey)
      .placeholderFont({ size: 14, weight: 400 })
      .textFont({ size: 14, weight: 400 })
      .onSubmit((_: string) => {
        if(this.keyword.length == 0){
          toastShort(this.getUIContext(), $r('app.string.tips_search_keywords'))
          return
        }
        this.pageInfos.pushPathByName('search', new SearchResultParam(this.keyword))
      })
      .onChange((value: string) => {
        this.keyword = value
      })
  }

  build() {
    NavDestination() {
      if(this.isLoading){
        ActivityLoading()
      }else {
        Column() {
          Row() {
            SymbolGlyph($r('sys.symbol.hotspot')).fontColor([Color.Red])
            Text($r('app.string.search_hotkey')).fontSize(19).margin({ left: 8 })
          }
          .padding({ top: 12, bottom: 12 })

          Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
            ForEach(this.keywords, (item: Hotkey) => {
              Button(item.name)
                .backgroundColor(Const.chapterBgColor[item.id%10])
                .fontSize(13)
                .height(36)
                .onClick(() => {
                  this.pageInfos.pushPathByName('search', new SearchResultParam(item.name))
                })
            })
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 12, right: 12 })
      }
    }
    .title(this.search())
  }
}