/**
 * Data returned by the network request.
 */
export class ResponseResult {
  /**
   * Code returned by the network request: success, fail.
   */
  errorCode: number;
  /**
   * Message returned by the network request.
   */
  errorMsg: string;
  /**
   * Data returned by the network request.
   */
  data?: object | null;

  constructor() {
    this.errorCode = 0;
    this.errorMsg = '';
    this.data = null;
  }
}

export abstract class HttpService {
  /// Http base url
  abstract get baseUrl(): string;

  abstract get headers(): Record<string, string>;

  abstract updateHeader(data: Record<string, object>);

  abstract get(endpoint: string, queryParameters?: Record<string, number | string | boolean>,
    forceRefresh?: boolean): Promise<ResponseResult>;

  abstract post(endpoint: string, data?: Record<string, number | string | boolean>): Promise<ResponseResult>;
}