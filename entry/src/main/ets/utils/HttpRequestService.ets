import { injectable, inject } from "inversify";

import { HttpService } from "./HttpService";
import { http } from "@kit.NetworkKit";
import { ResponseResult } from "./HttpService";
import { RequestConstant as Const, ContentType } from '../constants/RequestConst';
import { TextUtils } from './TextUtils';
import { BusinessError } from '@kit.BasicServicesKit';
import hilog from '@ohos.hilog';
import { CookiesUtils } from './CookiesUtils';
import { ApiException } from "./Request";

@injectable()
export class HttpRequestService extends HttpService {
  private httpRequest: http.HttpRequest;

  constructor() {
    super();
    this.httpRequest = http.createHttp();
  }

  /// Http base url
  get baseUrl(): string {
    return Const.SERVER
  }

  get headers(): Record<string, string> {
    return {
      'accept': 'application/json',
      'content-type': 'application/x-www-form-urlencoded',
    };
  }

  updateHeader(data: Record<string, object>) {

  }

  get(endpoint: string, queryParameters?: Record<string, number | string | boolean>,
    forceRefresh: boolean = true): Promise<ResponseResult> {
    return this.request(endpoint, http.RequestMethod.GET, queryParameters)
  }

  post(endpoint: string, data?: Record<string, number | string | boolean>): Promise<ResponseResult> {
    return this.request(endpoint, http.RequestMethod.POST, data)
  }

  private async request(endpoint: string, method: http.RequestMethod,
    parameters?: Record<string, string | number | boolean> | null): Promise<ResponseResult> {

    let apiUrl = this.baseUrl + endpoint;

    let extraData: string | null = null
    if (parameters != null) {
      if (method == http.RequestMethod.GET) {
        apiUrl += "?" + TextUtils.mapToUrlEncodedString(parameters)
      } else {
        extraData = TextUtils.mapToUrlEncodedString(parameters)
      }
    }

    PersistentStorage.persistProp<string>("cookies", "")
    let cookies = AppStorage.get<string>("cookies") // cookies get
    if (cookies) {
      hilog.info(0, "network", `request cookies: ${cookies}`)
    }
    //cookies = "loginUserName=testdog3\r; token_pass=6f46849b7027f489ae8bef583d6e1725\r; loginUserName_wanandroid_com=testdog3\r; token_pass_wanandroid_com=6f46849b7027f489ae8bef583d6e1725"
    let value: http.HttpResponse
    try {
      value = await this.httpRequest.request(apiUrl, {
        method: method,
        readTimeout: Const.HTTP_READ_TIMEOUT,
        header: {
          'Content-Type': ContentType.FORM_DATA,
          'Cookie': cookies,
        },
        connectTimeout: Const.HTTP_READ_TIMEOUT,
        extraData: extraData,
      } as http.HttpRequestOptions);
    } catch (e) {
      let err = e as BusinessError;
      let error = new ApiException(err.code, err.message);
      throw error
    }

    // Processes the data and returns.
    if (value.responseCode === Const.HTTP_CODE_200) {
      if (value.cookies) {
        // 当 cookies 有值时才进行保存
        //hilog.info(0, "network", `response cookies: ${cookies}`)
        let cookies = CookiesUtils.formatWanAndroidCookies(value.cookies)
        hilog.info(0, "network", `response cookies: ${cookies}`)
        AppStorage.setOrCreate("cookies", cookies) // cookies save
      }

      // Obtains the returned data.
      let result = `${value.result}`;
      let resultJson: ResponseResult = JSON.parse(result) as ResponseResult;
      if (resultJson.errorCode === Const.SERVER_CODE_SUCCESS) {
        return resultJson;
      } else {
        //业务错误
        let error = new ApiException(resultJson.errorCode, resultJson.errorMsg);
        throw error
      }
    } else {
      //Http 错误
      let error = new ApiException(value.responseCode, `${$r('app.string.http_error_message')}`);
      throw error
    }

  }
}