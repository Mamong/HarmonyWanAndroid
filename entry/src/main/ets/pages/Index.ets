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

import { geoLocationManager } from '@kit.LocationKit';
import { abilityAccessCtrl } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BreakpointConstants } from '../constants/BreakpointConstants';
import { CommonConstants } from '../constants/CommonConstants';
import { Home } from './Home';
import { OnBoardingPage } from './OnBoardingPage';
import { SplashPage } from './SplashPage';

@Entry
@Component
struct Index {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('firstLaunch') firstLaunch: boolean = true;
  @StorageLink('showSplash') showSplash: boolean = false

  build() {
    GridRow({
      columns: {
        sm: BreakpointConstants.GRID_ROW_COLUMNS[0],
        md: BreakpointConstants.GRID_ROW_COLUMNS[1],
        lg: BreakpointConstants.GRID_ROW_COLUMNS[2]
      }
    }) {
      GridCol({
        span: {
          sm: BreakpointConstants.GRID_COLUMN_SPANS[0],
          md: BreakpointConstants.GRID_COLUMN_SPANS[1],
          lg: BreakpointConstants.GRID_COLUMN_SPANS[4]
        }
      }) {
        Stack() {
          Home()
          if(this.firstLaunch) {
            OnBoardingPage()
          }else{
            if(this.showSplash){
              SplashPage()
            }
          }
        }
      }
      .height(CommonConstants.FULL_PERCENT)
      .width(CommonConstants.FULL_PERCENT)
    }
    .onBreakpointChange((breakPoint) => {
      this.currentBreakpoint = breakPoint;
    })
  }
}

