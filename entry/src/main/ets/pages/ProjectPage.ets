import { Tree } from "../viewmodel/Models";
import HomeVm from "../viewmodel/HomeViewModel"
import { CommonConstants as Const } from '../constants/CommonConstants';
import { ApiException } from "../utils/Request";
import { ArticleList, ArticleSource } from "../view/ArticleList";
import { toastShort } from "../utils/ToastUtils";

@Component
export struct ProjectPage {
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
    HomeVm.getProjectTree().then((value: Tree[]) => {
      this.tabBarArray = value;
    }).catch((err: ApiException) => {
      this.tabBarArray = [];
      toastShort(this.getUIContext(),err.message)
    });
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start }) {
        ForEach(this.tabBarArray, (item: Tree, index: number) => {
          TabContent() {
            ArticleList({ source: ArticleSource.Project, ext: item.id })
          }
          .tabBar(this.TabBuilder(index))
        }, (item: Tree) => `${item.id}`);
      }
      .barHeight(Const.TabBars_BAR_HEIGHT)
      .barMode(BarMode.Scrollable)
      .barWidth(Const.TabBars_BAR_WIDTH)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .vertical(false)
    }
  }
}