/*
* Copyright (c) 2024 Huawei Device Co., Ltd.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

export class ThemeColor {
  name: string
  color: number

  constructor(name: string, color: number) {
    this.name = name
    this.color = color
  }
}

export class Language {
  name: string
  code: string

  constructor(name: string, code: string) {
    this.name = name
    this.code = code
  }
}

export class CommonConstants {
  /**
   * Full percent.
   */
  public static readonly FULL_PERCENT: string = '100%';
  /**
   * Ninety percent.
   */
  public static readonly NINETY_PERCENT: string = '90%';
  /**
   * Common zero.
   */
  public static readonly ZERO: number = 0;
  /**
   * Font weight 500.
   */
  public static readonly FONT_WEIGHT_500: number = 500;
  /**
   * Font weight 400.
   */
  public static readonly FONT_WEIGHT_400: number = 400;
  /**
   * Maximum number of lines of text.
   */
  public static readonly MAX_LINES: number = 3;
  /**
   * Indicates the maximum number of addresses returned by reverse geocoding query..
   */
  public static readonly MAX_ITEMS: number = 1;
  /**
   * Layout weight.
   */
  public static readonly LAYOUT_WEIGHT: number = 1;
  /**
   * ListItem space.
   */
  public static readonly LIST_ITEM_SPACE: number = 14;
  /**
   * List space.
   */
  public static readonly LIST_SPACE: number = 3;
  /**
   * AlphabetIndexer itemSize.
   */
  public static readonly ITEM_SIZE: number = 20;
  /**
   * Text opacity.
   */
  public static readonly TEXT_OPACITY: number[] = [1, 0.4, 0.6, 0.05];
  /**
   * Device types.
   */
  public static readonly DEVICE_TYPES: string[] = ['2in1', 'tablet'];
  /**
   * Tab bar height for sm and md.
   */
  public static readonly TAB_BAR_HEIGHT: number = 35;
  /**
   * Bottom rect height.
   */
  public static readonly BOTTOM_RECT_HEIGHT: number = 24;
  /**
   * Grid horizontal gutter
   */
  public static readonly GRID_HORIZONTAL_GUTTER: string[] = ['24vp', '32vp'];
  /**
   * Grid vertical gutter
   */
  public static readonly GRID_VERTICAL_GUTTER: string[] = ['4vp', '16vp'];
  /**
   * The TabBars constants.
   */
  static readonly TabBars_UN_SELECT_TEXT_FONT_SIZE: number = 18;
  static readonly TabBars_SELECT_TEXT_FONT_SIZE: number = 24;
  static readonly TabBars_UN_SELECT_TEXT_FONT_WEIGHT: number = 400;
  static readonly TabBars_SELECT_TEXT_FONT_WEIGHT: number = 700;
  static readonly TabBars_BAR_HEIGHT: string = '7.2%';
  static readonly TabBars_HORIZONTAL_PADDING: string = '2.2%';
  static readonly TabBars_BAR_WIDTH: string = '100%';
  static readonly chapterBgColor = [
    '#FF79CDCD',
    '#FF71C671',
    '#FF4169E1',
    '#FF3CB371',
    '#FFEE82EE',
    '#FFF4A460',
    '#FFFF7256',
    '#FF5F9EA0',
    '#FF79CDCD',
    '#FFBC8F8F'
  ];
  static readonly gitHubStr = 'https://github.com/Mamong';
  static readonly csdnStr = 'https://blog.csdn.net/Mamong';
  static readonly downloadUrl = 'https://github.com/Mamong/Expo_WanAndroid';
  static readonly qqEmail = '1054209736@qq.com';
  static readonly pointRule = 'https://www.wanandroid.com/blog/show/2653';



  static readonly themeColors = [
    new ThemeColor('默认主题色', 0xFF2196F3),
    new ThemeColor('主站主题色', 0xFF235C87),
    new ThemeColor('皇家蓝', 0xFF4169E1),
    new ThemeColor('军校蓝', 0xFF5F9EA0),
    new ThemeColor('深卡其布', 0xFFBDB76B),
    new ThemeColor('玫瑰棕色', 0xFFBC8F8F),
    new ThemeColor('印度红', 0xFFCD5C5C),
    new ThemeColor('深石板灰', 0xFF2F4F4F),
    new ThemeColor('海洋绿', 0xFF2E8B57),
    new ThemeColor('暗淡的灰色', 0xFF696969),
    new ThemeColor('橙色', 0xFFFFA500),
    new ThemeColor('粉红色', 0xFFFFC0CB),
    new ThemeColor('深粉色', 0xFFFF1493),
    new ThemeColor('兰花的紫色', 0xFFDA70D6),
    new ThemeColor('适中的紫色', 0xFF9370DB),
    new ThemeColor('紫色', 0xFF800080),
    new ThemeColor('纯黑', 0xFF000000)]

  static readonly languages = [
    new Language("简体中文", "zh-Hans"),
    new Language("繁体中文", "zh-Hant"),
    new Language("English", "en-US")
  ]
}


@Builder
export function EmptyBuilder() {
}
