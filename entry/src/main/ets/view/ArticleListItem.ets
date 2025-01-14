import { Article } from "../viewmodel/Models";
import { CommonConstants as Const } from '../constants/CommonConstants';
import { WebviewParam } from "../pages/WebView";

@Reusable
@Component
export struct ArticleListItem {
  @Consume('pageInfos') pageInfos: NavPathStack
  item: Article = new Article();

  aboutToReuse(params: Record<string, ESObject>) {
    this.item = params.item as Article
    console.info(`=====Recycle Child:${this.item.id}=====`)
  }

  @Builder
  ArticleHeader() {
    Text() {
      if (this.item.isTop) {
        Span(" 置顶 ")
          .fontColor('#FFFFFF')
          .textBackgroundStyle({ color: "#FF0000", radius: "4vp" })
        Span(" ")
      }
      if (this.item.fresh) {
        Span(" 新 ")
          .fontColor('#FFFFFF')
          .textBackgroundStyle({ color: "#FF0000", radius: "4vp" })
        Span(" ")
      }
      Span(this.item.title)
        .fontWeight(FontWeight.Bold)
    }
    .maxLines(2)
    .textOverflow({ overflow: TextOverflow.Ellipsis })
    .fontSize(13)
  }

  @Builder
  ArticleBottom() {
    Flex({ alignItems: ItemAlign.Center }) {
      SymbolGlyph($r('sys.symbol.heart_fill'))
        .width(25)
        .height(25)
      SymbolGlyph($r('sys.symbol.clock_fill'))
        .width(25)
        .height(25)
      Text(this.item.niceDate)
        .fontSize(13)
      Blank().width(10)
      Text(this.item.displayAuthor)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .fontSize(13)
        .flexBasis(1)
        .flexShrink(1)
        .flexGrow(1)
    }

    //.backgroundColor('#FF0000')
  }

  build() {
    Row() {
      Column({ space: 8 }) {
        this.ArticleHeader()
        Text(this.item.desc)
          .fontSize(14)
          .maxLines(3)
          .wordBreak(WordBreak.BREAK_ALL)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        this.ArticleBottom()
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(8)
      if (this.item.envelopePic != '') {
        Image(this.item.envelopePic)
          .width(60)
          .height(100)
      } else {
        Text(this.item.superChapterName)
          .fontSize(10)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
          .width(60)
          .height(60)
          .borderRadius(30)
          .backgroundColor(Const.chapterBgColor[this.item.id%10])
      }
    }
    .onClick(() => {
      this.pageInfos.pushPathByName('webview', new WebviewParam(this.item.title, this.item.link ))
    })
    .backgroundColor('#FFFFFF')
    .padding(12)
    .borderRadius(10)
    // ListItem card模式默认有缩进
    .margin({ left: 12, right: 12,bottom: 12 })
  }
}