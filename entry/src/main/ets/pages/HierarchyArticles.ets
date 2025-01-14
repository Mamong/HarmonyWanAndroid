import { Tree } from "../viewmodel/Models";
import HomeVm from "../viewmodel/HomeViewModel"
import { CommonConstants as Const } from '../constants/CommonConstants';
import { ApiException } from "../utils/Request";
import { ArticleList, ArticleSource } from "../view/ArticleList";

@Component
export struct HierarchyArticles {
  @Consume('pageInfos') pageInfos: NavPathStack
  param:HierarchyParam = new HierarchyParam()
  // pid: number = 0
  // cid: number = 0
  @State private title: string = ""

  @State private tabBarArray: Tree[] = []
  @State private currentIndex: number = 0

  @Builder
  TabBuilder(index: number) {
    Column() {
      Text(this.tabBarArray[index].name)
        .height(Const.FULL_PERCENT)
        .padding({ left: Const.TabBars_HORIZONTAL_PADDING, right: Const.TabBars_HORIZONTAL_PADDING })
        .fontSize(this.currentIndex === index ? Const.TabBars_SELECT_TEXT_FONT_SIZE :
        Const.TabBars_UN_SELECT_TEXT_FONT_SIZE)
        .fontWeight(this.currentIndex === index ? Const.TabBars_SELECT_TEXT_FONT_WEIGHT :
        Const.TabBars_UN_SELECT_TEXT_FONT_WEIGHT)
        .fontColor('#333')
    }
  }

  aboutToAppear(): void {
    HomeVm.getHierarchy().then((value: Tree[]) => {
      let section = value.find(item => item.id == this.param.pid)
      this.title = section!.name
      this.tabBarArray = section!.children
      this.currentIndex = section!.children.findIndex(item => item.id == this.param.cid)
    }).catch((err: ApiException) => {
      this.tabBarArray = [];
    });
  }

  build() {
    NavDestination() {
      Column() {
        Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
          ForEach(this.tabBarArray, (item: Tree, index: number) => {
            TabContent() {
              ArticleList({ source: ArticleSource.Hierarchy, ext: item.id })
            }
            .tabBar(this.TabBuilder(index))
          }, (item: Tree) => `${item.id}`);
        }
        .barHeight(Const.TabBars_BAR_HEIGHT)
        //.height(Const.TabBars_BAR_HEIGHT)
        .barMode(BarMode.Scrollable)
        .barWidth(Const.TabBars_BAR_WIDTH)
        .onChange((index: number) => {
          this.currentIndex = index;
        })
        .vertical(false)
      }
    }
    .title(this.title)
  }
}

export class  HierarchyParam {
  pid: number
  cid: number

  constructor(pid:number=0, cid:number=0) {
    this.pid = pid
    this.cid = cid
  }
}