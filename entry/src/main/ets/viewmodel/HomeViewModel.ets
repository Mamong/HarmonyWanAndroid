import Request from "../utils/Request";
import { Tree, Navi, Website, Banner } from "./Models";

class HomeViewModel {
  /// 1.2 index banner
  getBanner(): Promise<Banner[]> {
    return Request.get('/banner/json')
  }

  /// 1.3 often used websites
  getOftenUsedWebsites(): Promise<Website[]> {
    return Request.get('/friend/json')
  }

  /// hierarchy category
  getHierarchy(): Promise<Tree[]> {
    return Request.get('/tree/json')
  }

  /// 3.1 guide data
  getGuideList(): Promise<Navi[]> {
    return Request.get('/navi/json')
  }

  /// 4.1 project category
  getProjectTree(): Promise<Tree[]> {
    return Request.get('/project/tree/json')
  }

  /// 15.1 wx article category
  getWXArticleTree(): Promise<Tree[]> {
    return Request.get('/wxarticle/chapters/json')
  }
}

let homeVm = new HomeViewModel();

export default homeVm as HomeViewModel;