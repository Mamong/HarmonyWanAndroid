import CommonConstant from './common/constant'

//https://atomgit.com/maple_kit/NavigationBarView/tree/master/NavigationBarViewLibrary
/**
 * 导航栏
 *
 * 每个页面都需要配置一个
 */
@Preview
@Component
export struct NavigationBarView {
  /** 标题 */
  public title?: string | Resource | null = null
  /** 标题字体大小 */
  public titleFont: string | number | Resource = $r("app.float.24fp")
  /** 标题字体颜色 */
  public titleColor: ResourceColor = $r("app.color._000000")
  /** 标题字体粗细 */
  public titleFontWeight?: string | number | FontWeight = FontWeight.Medium
  /** 是否显示返回按钮 */
  public showBack: boolean = true
  /** 返回图标 */
  public backImage: string | PixelMap | Resource = $r("app.media.goback_333")
  /** 返回图标的颜色 */
  public backImageColor: ResourceColor = $r("app.color._333333")
  /** 返回图标的大小 */
  public backImageSize: number = CommonConstant.BACK_IMAGE_SIZE
  /** 返回图标距离左侧屏幕的间距 */
  public backImageLeftMargin: number = CommonConstant.BACK_IMAGE_LEFT_MARGIN
  /** 返回按钮的标题 */
  public backTitle?: string | null = null
  /** 返回按钮的标题字体颜色 */
  public backTitleColor: ResourceColor = $r("app.color._000000")
  /** 返回按钮的标题字体大小 */
  public backTitleFont: string | number | Resource = $r("app.float.20fp")
  /** 返回按钮的标题字体粗细 */
  public backTitleFontWeight: string | number | FontWeight = FontWeight.Medium
  /** 返回按钮标题距离返回图标的间距 */
  public backTitleLeftMargin: Length = $r("app.float.16vp")
  /** 中间内容是否保持居中 */
  public contentToCenter: boolean = true
  /** 中间内容距离两侧的间距 */
  public contentHorizontalSpace: number = CommonConstant.CONTENT_HORIZONTAL_SPACE
  /** 中间内容的对齐方式，可通过该值修改contentToCenter=false下title居左显示 */
  public centerContentAlign: Alignment = Alignment.Center
  /** 搜索框文本占位符 */
  public searchPlaceholder: string | Resource = $r("app.string.search_placeholder")
  /** 搜索框文本占位符的字体颜色 */
  public searchPlaceholderFontColor: ResourceColor = $r("app.color._999999")
  /** 搜索框文本占位符的字体大小 */
  public searchPlaceholderFontSize: string | number | Resource = $r("app.float.16fp")
  /** 搜索框文本占位符的字体粗细 */
  public searchPlaceholderFontWeight: string | number | FontWeight = FontWeight.Normal
  /** 搜索框图标 */
  public searchImage: string | PixelMap | Resource = $r("app.media.search")
  /** 搜索框图标的颜色 */
  public searchImageColor: ResourceColor = $r("app.color._999999")
  /** 搜索框图标的大小 */
  public searchImageSize: Length = $r("app.float.15vp")
  /** 搜索框图标距离左侧的间距 */
  public searchImageLeftMargin: Length = $r("app.float.15vp")
  /** 搜索框文本占位符的周边间距 */
  public searchPlaceholderMargin?: Padding | Length = { left: $r("app.float.10vp"), right: $r("app.float.15vp") }
  /** 搜索框的背景颜色 */
  public searchBackgroundColor?: ResourceColor = $r("app.color._F0F0F0")
  /** 搜索框的圆角，默认为内容的高度 */
  public searchBarRadius?: number
  /** 从右侧屏幕往左的第一个按钮的图片 */
  //public rightFirstImage?: string | PixelMap | Resource

  /** 从右侧屏幕往左的第二个按钮的图片 */
  //public rightSecondImage?: string | PixelMap | Resource

  /** 从右侧屏幕往左的第三个按钮的图片 */
  //public rightThirdImage?: string | PixelMap | Resource

  /** 右侧功能按钮的图标大小，宽高都是该值 */
  public rightImageSize: Length = $r("app.float.25vp")
  /** 右侧功能按钮的事件点击区域宽度，高度跟随内容的高度 */
  public rightImageBoxWidth: number = CommonConstant.RIGHT_IMAGE_BOX_WIDTH
  /** 右侧功能按钮距离右侧屏幕的间距 */
  public rightImagesOnScreenRightMargin: number = CommonConstant.RIGHT_IMAGE_ON_SCREEN_RIGHT_MARGIN
  /** 内容的高度 */
  public contentHeight: number = CommonConstant.CONTENT_HEIGHT
  /** 内容距离底部的间距 */
  public contentBottomSpace: Length = $r("app.float.10vp")
  /** 导航栏的总高度，该高度参考的程序为【我的华为】App */
  public navHeight: Length = $r("app.float.100vp")
  /** 返回按钮的点击事件，如果存在返回标题，点击返回标题也会触发该事件 */
  public backClick?: (event?: ClickEvent) => void
  /** 搜索框的点击事件 */
  public searchClick?: (event?: ClickEvent) => void
  public leftMenus?: NaviMenuItem[]
  @BuilderParam public leftMenusBuilder?: CustomBuilder
  public rightMenus?: NaviMenuItem[]
  @BuilderParam public rightMenusBuilder?: CustomBuilder
  /** 从右侧屏幕往左的第一个按钮的点击事件 */
  // public rightFirstImageClick?: (event?: ClickEvent) => void
  //
  // /** 从右侧屏幕往左的第二个按钮的点击事件 */
  // public rightSecondImageClick?: (event?: ClickEvent) => void
  //
  // /** 从右侧屏幕往左的第三个按钮的点击事件 */
  // public rightThirdImageClick?: (event?: ClickEvent) => void

  /** 替换中间的内容文本，替换后，需要自己实现【标题】或【搜索框】 */
  @BuilderParam public centerContent?: CustomBuilder
  /** 从右侧屏幕往左的第一个按钮的内容替换，一般可用来改为文本控件或者组合图标（双层图标），通过设置rightImageBoxWidth来拉开间距 */
  //@BuilderParam public rightFirstImageContent?: CustomBuilder

  /** 从右侧屏幕往左的第二个按钮的内容替换，一般可用来改为文本控件或者组合图标（双层图标），通过设置rightImageBoxWidth来拉开间距 */
  //@BuilderParam public rightSecondImageContent?: CustomBuilder

  /** 从右侧屏幕往左的第三个按钮的内容替换，一般可用来改为文本控件或者组合图标（双层图标），通过设置rightImageBoxWidth来拉开间距 */
  //@BuilderParam public rightThirdImageContent?: CustomBuilder

  /** 右侧所有功能按钮的总长 + 按钮紧贴屏幕右侧的边距 */
  private rightImageTotalSpace: number = 0
  @State private leftIndent: number = 0
  @State private rightIndent: number = 0

  aboutToAppear() {
    // 计算右侧功能键所占的总宽度
    this.fillRightImageTotalSpace()
    // 初始化默认参数
    if (!this.searchBarRadius) {
      // 默认搜索条背景圆角处理
      this.searchBarRadius = this.contentHeight / 2
    }
  }

  build() {
    //内容下沉
    Column() {
      //底部padding
      Column() {
        Row() {

          // 返回按钮
          if (this.showBack) {
            this.backBuilder()
          }

          if (this.leftMenus || this.leftMenusBuilder) {
            Row() {
              Row() {
                if (this.leftMenusBuilder) {
                  this.leftMenusBuilder()
                } else if (this.leftMenus) {
                  ForEach(this.leftMenus, (item: NaviMenuItem) => {
                    if (item.symbolIcon) {
                      Button({ buttonStyle: ButtonStyleMode.TEXTUAL }) {
                        SymbolGlyph(item.symbolIcon)
                      }
                      .width(this.rightImageSize)
                      .height(this.rightImageSize)
                      .onClick(item.action)
                    } else if (item.icon) {
                      // Image(item.icon)
                      //   .objectFit(ImageFit.Contain)
                      //   .width(this.rightImageSize)
                      //   .height(this.rightImageSize)
                      //   .onClick(item.action)
                      Button({ buttonStyle: ButtonStyleMode.TEXTUAL }) {
                        Image(item.icon)
                          .objectFit(ImageFit.Contain)
                      }
                      .width(this.rightImageSize)
                      .height(this.rightImageSize)
                      .enabled(item.isEnabled)
                      .onClick(item.action)
                    } else if (item.value) {
                      Button(item.value, { buttonStyle: ButtonStyleMode.TEXTUAL })
                        .width(this.rightImageSize)
                        .height(this.rightImageSize)
                        .enabled(item.isEnabled)
                        .onClick(item.action)
                    }
                  })
                }
              }
              .margin({ left: this.rightImagesOnScreenRightMargin })
              .height(this.contentHeight)
            }.onAreaChange((oldValue: Area, newValue: Area) => {
              this.leftIndent = (newValue.position.x as number) + (newValue.width as number)
            })
          }

          // 标题及搜索
          if (((this.title || this.searchClick) && !this.backTitle) || this.centerContent) {
            Stack() {
              if (this.centerContent) {
                // 外部替换
                this.centerContent()
              } else {
                // 内部预置
                if (this.title) {
                  this.titleBuilder()
                }
                if (this.searchClick) {
                  this.searchBarBuilder()
                }
              }

            }
            .alignContent(this.centerContentAlign)
            .layoutWeight(1)
            // .backgroundColor(Color.Green)
            .margin({ left: Math.max(0, this.rightIndent - this.leftIndent), right: Math.max(0, this.leftIndent - this.rightIndent) })
            //.margin(this.getCenterContentMargin())
          } else {
            Blank()
          }

          // 右侧的按钮，最多只能放三个
          if (this.rightMenus || this.rightMenusBuilder) {
            Row() {
              Row() {
                if (this.rightMenusBuilder) {
                  this.rightMenusBuilder()
                } else if (this.rightMenus) {
                  ForEach(this.rightMenus, (item: NaviMenuItem) => {
                    if (item.symbolIcon) {
                      Button({ buttonStyle: ButtonStyleMode.TEXTUAL }) {
                        SymbolGlyph(item.symbolIcon)
                      }
                      .width(this.rightImageSize)
                      .height(this.rightImageSize)
                      .onClick(item.action)
                    } else if (item.icon) {
                      // Image(item.icon)
                      //   .objectFit(ImageFit.Contain)
                      //   .width(this.rightImageSize)
                      //   .height(this.rightImageSize)
                      //   .onClick(item.action)
                      Button({ buttonStyle: ButtonStyleMode.TEXTUAL }) {
                        Image(item.icon)
                          .objectFit(ImageFit.Contain)
                      }
                      .width(this.rightImageSize)
                      .height(this.rightImageSize)
                      .enabled(item.isEnabled)
                      .onClick(item.action)
                    } else if (item.value) {
                      Button(item.value, { buttonStyle: ButtonStyleMode.TEXTUAL })
                        .width(this.rightImageSize)
                        .height(this.rightImageSize)
                        .enabled(item.isEnabled)
                        .onClick(item.action)
                    }
                  })
                }
              }
              .margin({ right: this.rightImagesOnScreenRightMargin })
              .height(this.contentHeight)
            }
            .onAreaChange((oldValue: Area, newValue: Area) => {
              this.rightIndent = newValue.width as number
            })
          }
        }
        .width(CommonConstant.FULL_ALL_SPACE)
        .height(this.contentHeight)
        .margin({ bottom: this.contentBottomSpace })
      }
    }
    .justifyContent(FlexAlign.End)
    .backgroundColor($r("app.color.start_window_background"))
    .width(CommonConstant.FULL_ALL_SPACE)
    .height(this.navHeight)
  }

  /**
   * 创建返回按钮
   */
  @Builder
  private backBuilder() {
    Row() {
      Image(this.backImage)
        .width(this.backImageSize)
        .height(this.backImageSize)
        .fillColor(this.backImageColor)
        .margin({ left: this.backImageLeftMargin })
      if (this.backTitle) {
        Text(this.backTitle)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .fontSize(this.backTitleFont)
          .fontWeight(this.backTitleFontWeight)
          .fontColor(this.backTitleColor)
          .margin({ left: this.backTitleLeftMargin })
      }
    }
    .onClick(this.backClick)
  }

  /**
   * 创建标题
   */
  @Builder
  private titleBuilder() {
    Text(this.title)
      .fontSize(this.titleFont)
      .fontWeight(this.titleFontWeight)
      .fontColor(this.titleColor)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .maxLines(1)
      .layoutWeight(1)
  }

  /**
   * 创建搜索条
   */
  @Builder
  private searchBarBuilder() {
    Row() {
      Image(this.searchImage)
        .width(this.searchImageSize)
        .height(this.searchImageSize)
        .fillColor(this.searchImageColor)
        .margin({ left: this.searchImageLeftMargin })
      Text(this.searchPlaceholder)
        .maxLines(1)
        .fontColor(this.searchPlaceholderFontColor)
        .fontSize(this.searchPlaceholderFontSize)
        .fontWeight(this.searchPlaceholderFontWeight)
        .margin(this.searchPlaceholderMargin)
        .layoutWeight(1)
    }
    .height(this.contentHeight)
    .backgroundColor(this.searchBackgroundColor)
    .borderRadius(this.searchBarRadius)
    .onClick(this.searchClick)
  }

  /**
   * 创建右侧紧贴屏幕的按钮
   */
  // @Builder private rightImageBuilder(image: string | PixelMap | Resource| undefined, tag: number) {
  //   Column() {
  //     if (this.rightFirstImageContent || this.rightSecondImageContent || this.rightThirdImageContent) {
  //       // 外部替换
  //       if (this.rightFirstImageContent) {
  //         this.rightFirstImageContent()
  //       }else if (this.rightSecondImageContent) {
  //         this.rightSecondImageContent()
  //       }else if (this.rightThirdImageContent) {
  //         this.rightThirdImageContent()
  //       }
  //     }else {
  //       // 内部预置
  //       Image(image)
  //         .objectFit(ImageFit.Contain)
  //         .width(this.rightImageSize)
  //         .height(this.rightImageSize)
  //     }
  //   }
  //   .width(this.rightImageBoxWidth)
  //   .height(this.contentHeight)
  //   .justifyContent(FlexAlign.Center)
  //   .onClick((event: ClickEvent) => {
  //     if (tag === 0) {
  //       this.rightFirstImageClick && this.rightFirstImageClick(event)
  //       return
  //     }
  //     if (tag === 1) {
  //       this.rightSecondImageClick && this.rightSecondImageClick(event)
  //       return
  //     }
  //     if (tag === 2) {
  //       this.rightThirdImageClick && this.rightThirdImageClick(event)
  //       return
  //     }
  //   })
  // }

  /**
   * 计算右侧功能键所占的总宽度
   */
  private fillRightImageTotalSpace() {
    let totalSpace = 0
    if (!this.rightMenus) {
      return
    }
    totalSpace += this.rightImagesOnScreenRightMargin
    totalSpace += this.rightImageBoxWidth * this.rightMenus.length
    this.rightImageTotalSpace = totalSpace
  }

  /**
   * 计算中心内容的两边Margin
   * @returns
   */
  private getCenterContentMargin(): Margin {
    if (this.contentToCenter) {
      const leftSpace = this.showBack ? this.backImageSize + this.backImageLeftMargin : 0
      const rightSpace = this.rightImageTotalSpace
      if (leftSpace > rightSpace) {
        return { left: this.contentHorizontalSpace, right: leftSpace + this.contentHorizontalSpace }
      }
      return { left: (rightSpace + this.contentHorizontalSpace) - leftSpace, right: this.contentHorizontalSpace }
    }
    return { left: this.contentHorizontalSpace, right: this.contentHorizontalSpace }
  }

  // /** 标题 */
  // public resetTitle(newValue: string): NavigationBarView {
  //   this.title = newValue
  //   return this
  // }
  //
  // /** 标题字体大小 */
  // public setTitleFont(newValue: string | number | Resource): NavigationBarView {
  //   this.titleFont = newValue
  //   return this
  // }
  //
  // /** 标题字体颜色 */
  // public setTitleColor(newValue: ResourceColor): NavigationBarView {
  //   this.titleColor = newValue
  //   return this
  // }
  //
  // /** 标题字体粗细 */
  // public setTitleFontWeight(newValue: string | number | FontWeight): NavigationBarView {
  //   this.titleFontWeight = newValue
  //   return this
  // }
  //
  // /** 是否显示返回按钮 */
  // public setShowBack(newValue: boolean): NavigationBarView {
  //   this.showBack = newValue
  //   return this
  // }
  //
  // /** 返回图标 */
  // public setBackImage(newValue: string | PixelMap | Resource): NavigationBarView {
  //   this.backImage = newValue
  //   return this
  // }
  //
  // /** 返回图标的颜色 */
  // public setBackImageColor(newValue: ResourceColor): NavigationBarView {
  //   this.backImageColor = newValue
  //   return this
  // }
  //
  // /** 返回图标的大小 */
  // public setBackImageSize(newValue: number): NavigationBarView {
  //   this.backImageSize = newValue
  //   return this
  // }
  //
  // /** 返回图标距离左侧屏幕的间距 */
  // public setBackImageLeftMargin(newValue: number): NavigationBarView {
  //   this.backImageLeftMargin = newValue
  //   return this
  // }
  //
  // /** 返回按钮的标题 */
  // public setBackTitle(newValue: string): NavigationBarView {
  //   this.backTitle = newValue
  //   return this
  // }
  //
  // /** 返回按钮的标题字体颜色 */
  // public setBackTitleColor(newValue: ResourceColor): NavigationBarView {
  //   this.backTitleColor = newValue
  //   return this
  // }
  //
  // /** 返回按钮的标题字体大小 */
  // public setBackTitleFont(newValue: string | number | Resource): NavigationBarView {
  //   this.backTitleFont = newValue
  //   return this
  // }
  //
  // /** 返回按钮的标题字体粗细 */
  // public setBackTitleFontWeight(newValue: string | number | FontWeight): NavigationBarView {
  //   this.backTitleFontWeight = newValue
  //   return this
  // }
  //
  // /** 返回按钮标题距离返回图标的间距 */
  // public setBackTitleLeftMargin(newValue: number): NavigationBarView {
  //   this.backTitleLeftMargin = newValue
  //   return this
  // }
  //
  // /** 中间内容是否保持居中 */
  // public setContentToCenter(newValue: boolean): NavigationBarView {
  //   this.contentToCenter = newValue
  //   return this
  // }
  //
  // /** 中间内容距离两侧的间距 */
  // public setContentHorizontalSpace(newValue: number): NavigationBarView {
  //   this.contentHorizontalSpace = newValue
  //   return this
  // }
  //
  // /** 中间内容的对齐方式，可通过该值修改contentToCenter=false下title居左显示 */
  // public setCenterContentAlign(newValue: Alignment): NavigationBarView {
  //   this.centerContentAlign = newValue
  //   return this
  // }
  //
  // /** 搜索框文本占位符 */
  // public setSearchPlaceholder(newValue: string): NavigationBarView {
  //   this.searchPlaceholder = newValue
  //   return this
  // }
  //
  // /** 搜索框文本占位符的字体颜色 */
  // public setSearchPlaceholderFontColor(newValue: ResourceColor): NavigationBarView {
  //   this.searchPlaceholderFontColor = newValue
  //   return this
  // }
  //
  // /** 搜索框文本占位符的字体大小 */
  // public setSearchPlaceholderFontSize(newValue: string | number | Resource): NavigationBarView {
  //   this.searchPlaceholderFontSize = newValue
  //   return this
  // }
  //
  // /** 搜索框文本占位符的字体粗细 */
  // public setSearchPlaceholderFontWeight(newValue: string | number | FontWeight): NavigationBarView {
  //   this.searchPlaceholderFontWeight = newValue
  //   return this
  // }
  //
  // /** 搜索框图标 */
  // public setSearchImage(newValue: string | PixelMap | Resource): NavigationBarView {
  //   this.searchImage = newValue
  //   return this
  // }
  //
  // /** 搜索框图标的颜色 */
  // public setSearchImageColor(newValue: ResourceColor): NavigationBarView {
  //   this.searchImageColor = newValue
  //   return this
  // }
  //
  // /** 搜索框图标的大小 */
  // public setSearchImageSize(newValue: number): NavigationBarView {
  //   this.searchImageSize = newValue
  //   return this
  // }
  //
  // /** 搜索框图标距离左侧的间距 */
  // public setSearchImageLeftMargin(newValue: number): NavigationBarView {
  //   this.searchImageLeftMargin = newValue
  //   return this
  // }
  //
  // /** 搜索框文本占位符 */
  // public setSearchPlaceholderMargin(newValue: Margin): NavigationBarView {
  //   this.searchPlaceholderMargin = newValue
  //   return this
  // }
  //
  // /** 搜索框的背景 */
  // public setSearchBackgroundColor(newValue: ResourceColor): NavigationBarView {
  //   this.searchBackgroundColor = newValue
  //   return this
  // }
  //
  // /** 搜索框的圆角，默认为内容的高度 */
  // public setSearchBarRadius(newValue: number): NavigationBarView {
  //   this.searchBarRadius = newValue
  //   return this
  // }
  //
  // /** 从右侧屏幕往左的第一个按钮的图片 */
  // public setRightFirstImage(newValue: string | PixelMap | Resource): NavigationBarView {
  //   this.rightFirstImage = newValue
  //   return this
  // }
  //
  // /** 从右侧屏幕往左的第二个按钮的图片 */
  // public setRightSecondImage(newValue: string | PixelMap | Resource): NavigationBarView {
  //   this.rightSecondImage = newValue
  //   return this
  // }
  //
  // /** 从右侧屏幕往左的第三个按钮的图片 */
  // public setRightThirdImage(newValue: string | PixelMap | Resource): NavigationBarView {
  //   this.rightThirdImage = newValue
  //   return this
  // }
  //
  // /** 右侧功能按钮的图标大小，宽高都是该值 */
  // public setRightImageSize(newValue: number): NavigationBarView {
  //   this.rightImageSize = newValue
  //   return this
  // }
  //
  // /** 右侧功能按钮的事件点击区域宽度，高度跟随内容的高度 */
  // public setRightImageBoxWidth(newValue: number): NavigationBarView {
  //   this.rightImageBoxWidth = newValue
  //   return this
  // }
  //
  // /** 右侧功能按钮距离右侧屏幕的间距 */
  // public setRightImagesOnScreenRightMargin(newValue: number): NavigationBarView {
  //   this.rightImagesOnScreenRightMargin = newValue
  //   return this
  // }
  //
  // /** 内容的高度 */
  // public setContentHeight(newValue: number): NavigationBarView {
  //   this.contentHeight = newValue
  //   return this
  // }
  //
  // /** 内容距离底部的间距 */
  // public setContentBottomSpace(newValue: number): NavigationBarView {
  //   this.contentBottomSpace = newValue
  //   return this
  // }
  //
  // /** 导航栏的总高度，该高度参考的程序为【我的华为】App */
  // public setNavHeight(newValue: number): NavigationBarView {
  //   this.navHeight = newValue
  //   return this
  // }
  //
  // /** 返回按钮的点击事件，如果存在返回标题，点击返回标题也会触发该事件 */
  // public setBackClick(newValue: (event?: ClickEvent) => void): NavigationBarView {
  //   this.backClick = newValue
  //   return this
  // }
  //
  // /** 搜索框的点击事件 */
  // public setSearchClick(newValue: () => void): NavigationBarView {
  //   this.searchClick = newValue
  //   return this
  // }
  //
  // /** 从右侧屏幕往左的第一个按钮的点击事件 */
  // public setRightFirstImageClick(newValue: () => void): NavigationBarView {
  //   this.rightFirstImageClick = newValue
  //   return this
  // }
  //
  // /** 从右侧屏幕往左的第二个按钮的点击事件 */
  // public setRightSecondImageClick(newValue: () => void): NavigationBarView {
  //   this.rightSecondImageClick = newValue
  //   return this
  // }
  //
  // /** 从右侧屏幕往左的第三个按钮的点击事件 */
  // public setRightThirdImageClick(newValue: () => void): NavigationBarView {
  //   this.rightThirdImageClick = newValue
  //   return this
  // }

}

export interface NaviMenuItem {
  value: string
  icon?: string | undefined
  symbolIcon?: Resource
  isEnabled?: boolean
  action?: (() => void)
}