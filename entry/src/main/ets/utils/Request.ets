import { http } from '@kit.NetworkKit';
import { ClassConstructor, plainToInstance } from "class-transformer";
import ResponseResult from '../viewmodel/ResponseResult';
import { RequestConstant as Const, ContentType } from '../constants/RequestConst';
import { TextUtils } from './TextUtils';
import { BusinessError } from '@kit.BasicServicesKit';
import hilog from '@ohos.hilog';
import { CookiesUtils } from './CookiesUtils';


export class ApiException extends Error {
  errorCode: number

  constructor(errorCode: number, errorMsg: string) {
    super(errorMsg);
    this.errorCode = errorCode
  }
}


class Request {
  private static httpRequest = http.createHttp();

  static async get<T>(url: string, queryParameters?: Record<string, string | number | boolean> | null,
    resourceType?: ClassConstructor<T>): Promise<T> {
    return Request.request(url, http.RequestMethod.GET, queryParameters, resourceType) as Promise<T>;
  }

  static async getList<T>(url: string, queryParameters?: Record<string, string | number | boolean> | null,
    resourceType?: ClassConstructor<T>): Promise<T[]> {
    return Request.request(url, http.RequestMethod.GET, queryParameters, resourceType) as Promise<T[]>;
  }

  static async post<T>(url: string, data?: Record<string, string | number | boolean> | null,
    resourceType?: ClassConstructor<T>): Promise<T> {
    return Request.request<T>(url, http.RequestMethod.POST, data, resourceType) as Promise<T>;
  }

  //不使用class-transformer会丢失类型，但是引入class-transformer需要ClassConstructor<T>
  //使用plainToInstance会导致Classes cannot be used as objects (arkts-no-classes-as-obj)
  //而plainToClassFromExist是废弃的方法，使用何种需要权衡影响
  private static async request<T>(url: string, method: http.RequestMethod,
    parameters?: Record<string, string | number | boolean> | null,
    resourceType?: ClassConstructor<T>): Promise<T | T[]> {
    //return new Promise(async (resolve: Function, reject: Function) => {
    let apiUrl = Const.SERVER + url;

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
    cookies = "loginUserName=testdog3\r; token_pass=6f46849b7027f489ae8bef583d6e1725\r; loginUserName_wanandroid_com=testdog3\r; token_pass_wanandroid_com=6f46849b7027f489ae8bef583d6e1725"
    let value: http.HttpResponse
    try {
      value = await Request.httpRequest.request(apiUrl, {
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
      let resultJson: ResponseResult<T> = JSON.parse(result) as ResponseResult<T>;
      if (resultJson.errorCode === Const.SERVER_CODE_SUCCESS) {
        if (resultJson.data && resourceType) {
          return plainToInstance(resourceType, resultJson.data)
        }
        return resultJson.data as T;
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

export default Request