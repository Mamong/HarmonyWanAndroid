import { ApiException } from "../utils/Request";
import HomeVm from "../viewmodel/HomeViewModel"
import { Tree } from "../viewmodel/Models";
import { LengthMetrics } from "@kit.ArkUI";
import { NavigationBarView } from "@mamong/navigationbarview"
import { CommonConstants as Const } from '../constants/CommonConstants';
import { HierarchyParam } from "./HierarchyArticlesPage";
import { toastShort } from "../utils/ToastUtils";
import { ActivityLoading } from "../view/LoadingView";

@Component
export struct HierarchyPage {
  @Consume('pageInfos') pageInfos: NavPathStack
  @State private tree: Tree[] = []
  @State private isLoading: boolean = false

  aboutToAppear(): void {
    this.isLoading = true
    HomeVm.getHierarchy().then((value: Tree[]) => {
      this.tree = value
    }).catch((err: ApiException) => {
      toastShort(this.getUIContext(), err.message)
    }).finally(() => {
      this.isLoading = false
    });
  }

  @Builder
  listItem(item: Tree) {
    Column() {
      Text(item.name).fontSize(16).fontWeight(FontWeight.Bold)
      Blank().height(10)
      Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.px(15), cross: LengthMetrics.px(20) } }) {
        ForEach(item.children, (item: Tree) => {
          Button(item.name)
            .fontSize(14)
            .backgroundColor(Const.chapterBgColor[item.id%10])
            .height(32)
            .onClick(() => {
              this.pageInfos.pushPathByName('hierarchy', new HierarchyParam(item.parentChapterId, item.id))
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
    //由于TabContent垂直居中，套一层满屏Column解决
    Column() {
      Column() {
        NavigationBarView({ title: '体系', showBack: false, navHeight: 44 })
        if (this.isLoading) {
          ActivityLoading()
        } else {
          List({ space: 12 }) {
            ForEach(this.tree, (item: Tree) => {
              ListItem() {
                this.listItem(item)
              }
            })
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