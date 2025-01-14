export class RequestConstant {
  /**
   * The host address of the server.
   */
  static readonly SERVER: string = 'https://www.wanandroid.com';

  /**
   * The request success status code.
   */
  static readonly SERVER_CODE_SUCCESS: number = 0;

  /**
   * The page size.
   */
  static readonly PAGE_SIZE: number = 4;

  /**
   * Http request success status code.
   */
  static readonly HTTP_CODE_200: number = 200;

  /**
   * The http timeout duration.
   */
  static readonly HTTP_READ_TIMEOUT: number = 10000;

}

/**
 * The request content type enum.
 */
export const enum ContentType {
  JSON = 'application/json',
  FORM_DATA = "application/x-www-form-urlencoded"
}