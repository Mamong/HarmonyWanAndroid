import { curves } from '@kit.ArkUI';
import { HomePage } from './HomePage';
import { image } from '@kit.ImageKit';
import { systemShare } from '@kit.ShareKit';
import { uniformTypeDescriptor as utd } from '@kit.ArkData';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { CommonConstants as Const } from '../constants/CommonConstants';

interface Menu {
  icon: Resource
  title: ResourceStr
  path: string
  action: boolean
}

@Component
export struct SlideBar {
  @Consume('pageInfos') pageInfos: NavPathStack
  @StorageLink('themeColor') themeColor: number = 0xFF2196F3
  @StorageProp('username') username: string = ""
  // 侧边栏数据源
  @State private menus: Menu[] = [
    {
      icon: $r("sys.symbol.arrow_up_circle"),
      title: $r('app.string.menu_points'),
      path: "coinDetails",
      action: false
    },
    {
      icon: $r("sys.symbol.heart_fill"),
      title: $r('app.string.menu_collection'),
      path: "collection",
      action: false
    },
    {
      icon: $r("sys.symbol.worldclock"),
      title: $r('app.string.menu_websites'),
      path: "website",
      action: false
    },
    {
      icon: $r("sys.symbol.person_fill"),
      title: $r('app.string.menu_about'),
      path: "about",
      action: false
    },
    {
      icon: $r("sys.symbol.share"),
      title: $r('app.string.menu_share'),
      path: "share",
      action: true
    },
    {
      icon: $r("sys.symbol.gearshape"),
      title: $r('app.string.menu_settings'),
      path: "settings",
      action: false
    },
    {
      icon: $r("sys.symbol.power"),
      title: $r('app.string.menu_logout'),
      path: "logout",
      action: true
    },
  ]
  // 侧边栏显示控制器
  @State private isShowing: boolean = false
  // 手指按下x坐标
  private downX: number = 0
  // 手指移动x坐标
  private moveX: number = 0


  private async share() {
    let resMgr = getContext().resourceManager
    let resId = $r('app.media.logo').id
    const buffer: Uint8Array = resMgr.getMediaContentSync(resId)
    // 生成应用图标缩略图
    // const contextFaker: Context = getContext(this);
    // let thumbnailPath = contextFaker.filesDir + '/exampleImage.jpg'; // 仅为示例 请替换正确的文件路径
    // const imageSourceApi: image.ImageSource = image.createImageSource(thumbnailPath);
    // let opts: image.InitializationOptions = { size: { height: 6, width: 6 } }
    // const pixelMap: image.PixelMap = await imageSourceApi.createPixelMap(opts);
    // const imagePackerApi: image.ImagePacker = image.createImagePacker();
    // const buffer: ArrayBuffer = await imagePackerApi.packing(pixelMap, {
    //   // 当前只支持'image/jpeg','image/webp'和'image/png'类型图片.
    //   format: 'image/jpeg',
    //   // JPEG编码中设定输出图片质量的参数,取值范围为0-100.
    //   // 建议适当压缩,图片过大无法拉起分享.
    //   quality: 30
    // });
    // 构造ShareData，需配置一条有效数据信息
    let shareData: systemShare.SharedData = new systemShare.SharedData({
      utd: utd.UniformDataType.HYPERLINK,
      // App Linking链接 仅为示例
      content: Const.downloadUrl,
      title: 'WanAndroid', // 不传title时 显示链接
      description: 'Harmony版本玩安卓', // 不传则不显示描述内容
      thumbnail: new Uint8Array(buffer) // 推荐传入应用图标 不传则显示默认html图标
    });
    // 进行分享面板显示
    let controller: systemShare.ShareController = new systemShare.ShareController(shareData);
    let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
    controller.show(context, {
      previewMode: systemShare.SharePreviewMode.DEFAULT,
      selectionMode: systemShare.SelectionMode.SINGLE
    }).then(() => {
      console.info('ShareController show success.');
    }).catch((error: BusinessError) => {
      console.error(`ShareController show error. code: ${error.code}, message: ${error.message}`);
    });
  }

  performAction(action: string) {
    if (action == 'share') {
      this.share()
    } else if (action == 'logout') {
      this.getUIContext().showAlertDialog({
        title: $r('app.string.tips'),
        message: $r('app.string.logout_confirm'),
        alignment: DialogAlignment.Center,
        buttons: [
          {
            value: $r('app.string.cancel'), style: DialogButtonStyle.DEFAULT, action: () => {
          }
          },
          {
            value: $r('app.string.confirm'), style: DialogButtonStyle.HIGHLIGHT, action: () => {

          }
          }
        ]
      })
    }
  }

  build() {
    SideBarContainer(SideBarContainerType.Overlay) {
      Column() {
        //侧边栏内容区默认宽度240vp
        List() {
          ListItem() {
            Flex({ justifyContent: FlexAlign.SpaceBetween }) {
              Column() {
                //已登录
                if (this.username.length > 0) {
                  Image($r('app.media.logo')).size({ width: 80, height: 80 })
                  Text(this.username)
                    .fontColor(Color.White)
                } else {
                  SymbolGlyph($r('sys.symbol.person_crop_circle_fill')).fontSize(60)
                  Text($r('app.string.login'))
                    .fontColor(Color.White)
                    .onClick(() => {
                      this.pageInfos.pushPathByName('login', null)
                    })
                }

              }
              .justifyContent(FlexAlign.SpaceBetween)
              .height('100%')
              .alignItems(HorizontalAlign.Start)

              Button() {
                SymbolGlyph($r('sys.symbol.xmark_circle_fill'))
                  .fontSize(32)
                  .fontColor([Color.White])
              }.onClick(() => {
                animateTo({ curve: curves.springMotion() }, () => {
                  this.isShowing = false
                })
              })
            }
            .height(150)
            .padding({
              left: 12,
              right: 12,
              top: 24,
              bottom: 24
            })
            .backgroundColor(this.themeColor)
          }

          ForEach(this.menus, (item: Menu, index: number) => {
            ListItem() {
              Row() {
                SymbolGlyph(item.icon)
                Blank().width(12)
                Text(item.title)
                  .fontSize(14)
              }
              .padding(12)
              .onClick(() => { //点击列表项
                if (item.action) {
                  this.performAction(item.path)
                  return
                }
                this.pageInfos.pushPathByName(item.path, null)
                animateTo({ curve: curves.springMotion() }, () => {
                  this.isShowing = false
                }) //动画关闭侧边栏
              })
            }
            .visibility(item.path == 'logout' && this.username.length == 0 ? Visibility.None : Visibility.Visible)
          }, (item: Menu) => item.path)
        }
        .divider({ strokeWidth: 1, color: '#ffe9f0f0' })
        .borderRadius({ topRight: 10, bottomRight: 10 })
        .backgroundColor(Color.White)
        .height('100%')
        .margin({ right: 100 })
      }.width('100%')
      //.height('100%')
      .backgroundColor("#ee111111")

      // .borderRadius(10)

      Column() { //内容区

        HomePage({
          onClickMenu: () => {
            animateTo({ curve: curves.springMotion() }, () => {
              this.isShowing = true
            })
          }
        })
      }
      .width('100%')
      //.height('100%')
      .onTouch((event) => { //监听手指右边滑动和点击事件
        if (event.type == TouchType.Move) {
          this.moveX = event.touches[0].x
          if ((this.moveX - this.downX) > 50) { //产生了右侧滑动 打开抽屉
            animateTo({ curve: curves.springMotion() }, () => {
              this.isShowing = true
            })
          }
        } else if (event.type == TouchType.Down) {
          this.downX = event.touches[0].x
          // 点击内容区就会关闭抽屉
          animateTo({ curve: curves.springMotion() }, () => {
            this.isShowing = false
          })
        }
      })
    }
    //.height('100%')
    .width('100%')
    .sideBarWidth('100%')
    .showControlButton(false)
    .showSideBar($$this.isShowing) //双向绑定 控制抽屉的开和关
  }
}

