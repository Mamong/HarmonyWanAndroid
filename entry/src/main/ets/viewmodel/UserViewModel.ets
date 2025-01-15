import Request from '../utils/Request'
import { CoinInfo, CoinListResponse, ListResponse, UserInfo } from './Models'

class USerViewModel {
  login(username: string, password: string): Promise<UserInfo> {
    return Request.post('/user/login', { 'username': username, 'password': password })
  }

  register(username: string, password: string, repassword: string): Promise<UserInfo> {
    return Request.post('/user/register', { 'username': username, 'password': password, 'repassword': repassword })
  }

  getCoinInfo(): Promise<CoinInfo> {
    return Request.get(`/lg/coin/userinfo/json`, null)
  }

  getCoinDetails(page = 0, pageSize = 10): Promise<CoinListResponse> {
    return Request.get(`/lg/coin/list/${page}/json`, { "page_size": pageSize }, CoinListResponse)
  }

  collectArticle(id: number): Promise<void> {
    return Request.post(`/lg/collect/${id}/json`)
  }

  uncollectArticle(id: number): Promise<void> {
    return Request.post(`/lg/uncollect_originId/${id}/json`)
  }

  getCollectArticles(page = 0, pageSize = 10): Promise<ListResponse> {
    return Request.get(`/lg/collect/list/${page}/json`, { "page_size": pageSize }, ListResponse)
  }

  uncollectMyArticle(id: number, originId: number = -1): Promise<void> {
    return Request.post(`/lg/uncollect/${id}/json`, { "originId": originId })
  }
}

let userVm = new USerViewModel();

export default userVm as USerViewModel;