import Request from '../utils/Request'
import { CoinInfo, CoinListResponse, UserInfo } from './Models'

class USerViewModel {
  login(username: string, password: string): Promise<UserInfo> {
    return Request.post('/user/login', { 'username': username, 'password': password })
  }

  register(username: string, password: string, repassword: string): Promise<UserInfo> {
    return Request.post('/user/register', { 'username': username, 'password': password, 'repassword': repassword })
  }

  getCoinInfo():Promise<CoinInfo>{
    return Request.get(`/lg/coin/userinfo/json`, null)
  }

  getCoinDetails(page = 0, pageSize = 10):Promise<CoinListResponse>{
    return Request.get(`/lg/coin/list/${page}/json`, { "page_size": pageSize }, CoinListResponse)
  }
}

let userVm = new USerViewModel();

export default userVm as USerViewModel;