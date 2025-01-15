import { hilog } from '@kit.PerformanceAnalysisKit';
import { BreakpointConstants } from '../constants/BreakpointConstants';
import { CommonConstants } from '../constants/CommonConstants';
import { deviceInfo } from '@kit.BasicServicesKit';
import { ProjectPage } from './ProjectPage';
import { NavigationPage } from './NavigationPage';
import { WxArticlePage } from './WxArticlePage';
import { HierarchyPage } from './HierarchyPage';
import { SlideBar } from './SlideBar';
import { LoginPage } from './LoginPage';
import { RegisterPage } from './RegisterPage';
import { Webview, WebviewParam } from './WebViewPage';
import { HierarchyArticles, HierarchyParam } from './HierarchyArticlesPage';
import { CoinDetailsPage } from './CoinDetailsPage';
import { SettingsPage } from './SettingsPage';
import { LanguagePage } from './LanguagePage';
import { SearchPage } from './SearchPage';
import { SearchResultPage, SearchResultParam } from './SearchResultPage';
import { CollectionArticlesPage } from './CollectionArticlesPage';

@Component
export struct Home {
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('themeColor') themeColor: number = 0xFF2196F3;

  @State currentIndex: number = 0;
  private homeTabBarOption: TabBarOption = {
    index: 0,
    title: $r('app.string.tab_home'),
    normalImg: $r('sys.symbol.house'),
    selectedImg: $r('sys.symbol.house_fill'),
  };
  private hierarchyTabBarOption: TabBarOption = {
    index: 1,
    title: $r('app.string.tab_hierarchy'),
    normalImg: $r('sys.symbol.more'),
    selectedImg: $r('sys.symbol.more_fill'),
  };
  private wxTabBarOption: TabBarOption = {
    index: 2,
    title: $r('app.string.tab_public_account'),
    normalImg: $r('sys.symbol.person_2'),
    selectedImg: $r('sys.symbol.person_2_fill'),
  };
  private naviTabBarOption: TabBarOption = {
    index: 3,
    title: $r('app.string.tab_navigation'),
    normalImg: $r('sys.symbol.paperplane'),
    selectedImg: $r('sys.symbol.paperplane_fill'),
  };
  private projectTabBarOption: TabBarOption = {
    index: 4,
    title: $r('app.string.tab_project'),
    normalImg: $r('sys.symbol.airplane'),
    selectedImg: $r('sys.symbol.airplane_fill'),
  };

  @Builder
  PageMap(name: string, param: object) {
    if (name == 'login') {
      LoginPage()
    } else if (name == 'register') {
      RegisterPage()
    } else if (name == 'hierarchy') {
      HierarchyArticles({ param: param as HierarchyParam })
    } else if (name == 'webview') {
      Webview({ param: param as WebviewParam })
    } else if (name == 'coinDetails') {
      CoinDetailsPage()
    } else if (name == 'settings') {
      SettingsPage()
    } else if (name == 'language') {
      LanguagePage()
    } else if (name == 'hotkeys') {
      SearchPage()
    } else if (name == 'search') {
      SearchResultPage({ param: param as SearchResultParam })
    } else if(name == 'collection'){
      CollectionArticlesPage()
    }
  }

  build() {
    Navigation(this.pageInfos) {
      Tabs({
        barPosition: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
        BarPosition.Start : BarPosition.End,
      }) {
        TabContent() {
          SlideBar()
        }
        .tabBar(this.BottomTabBuilder(this.homeTabBarOption))
        // .tabBar(new BottomTabBarStyle({
        //   normal: this.symbolModifier1,
        // }, 'Pink'))

        TabContent() {
          HierarchyPage()
        }
        .tabBar(this.BottomTabBuilder(this.hierarchyTabBarOption))

        TabContent() {
          WxArticlePage()
        }
        .tabBar(this.BottomTabBuilder(this.wxTabBarOption))

        TabContent() {
          NavigationPage()
        }
        .tabBar(this.BottomTabBuilder(this.naviTabBarOption))

        TabContent() {
          ProjectPage()
        }
        .tabBar(this.BottomTabBuilder(this.projectTabBarOption))
      }
      .barWidth(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      $r('app.float.bottom_tab_bar_width_lg') : CommonConstants.FULL_PERCENT)
      .barHeight(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? CommonConstants.FULL_PERCENT :
        ((deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? CommonConstants.TAB_BAR_HEIGHT :
          CommonConstants.TAB_BAR_HEIGHT + CommonConstants.BOTTOM_RECT_HEIGHT)))
      .barMode(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarMode.Scrollable : BarMode.Fixed,
        { nonScrollableLayoutStyle: LayoutStyle.ALWAYS_CENTER })
      .vertical(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG)
      .barBackgroundColor('#F3F4F5')
      //sdk 11+ works, while 10 doesn't.
      .onAnimationStart((index: number, targetIndex: number) => {
        hilog.info(0x0000, 'index', index.toString());
        this.currentIndex = targetIndex;
      })
      .scrollable(false)
    }
    //.title("玩安卓")
    //.titleMode(NavigationTitleMode.Mini)
    //.hideBackButton(true)
    .hideTitleBar(true)
    .mode(NavigationMode.Auto)
    .navBarWidth(350)
    .navDestination(this.PageMap)
  }

  //https://developer.huawei.com/consumer/cn/design/harmonyos-symbol/
  @Builder
  BottomTabBuilder(tabBarOption: TabBarOption) {
    Column() {
      SymbolGlyph(this.currentIndex === tabBarOption.index ? tabBarOption.selectedImg : tabBarOption.normalImg)
        .size({ width: 25, height: 25 })
        .renderingStrategy(SymbolRenderingStrategy.SINGLE)
        .fontColor([this.currentIndex === tabBarOption.index ? this.themeColor : '#6B6B6B'])
      Text(tabBarOption.title)
        .margin({ top: $r('app.float.tab_top_margin') })
        .fontSize($r('app.float.tab_font_size'))
        .fontWeight(CommonConstants.FONT_WEIGHT_500)
        .fontColor(this.currentIndex === tabBarOption.index ? this.themeColor : '#6B6B6B')
    }
    .padding({
      bottom: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 : CommonConstants.BOTTOM_RECT_HEIGHT
    })
    .height(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.side_tab_bar_height') :
    CommonConstants.FULL_PERCENT)
    .width(CommonConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
  }
}

interface TabBarOption {
  index: number;
  title: ResourceStr;
  normalImg: Resource;
  selectedImg: Resource;
}
