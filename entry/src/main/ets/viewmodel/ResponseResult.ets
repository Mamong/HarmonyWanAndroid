/**
 * Data returned by the network request.
 */
export default class ResponseResult<T> {
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
  data?: T | null;

  constructor() {
    this.errorCode = 0;
    this.errorMsg = '';
    this.data = null;
  }
}