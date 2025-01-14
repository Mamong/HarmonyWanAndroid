import Request from "../utils/Request";
import { ListResponse, Article, Hotkey } from "./Models";

class ArticleViewModel {
  /// 1.1 index article list
  getArticleList(page = 0, pageSize = 10): Promise<ListResponse> {
    return Request.get(`/article/list/${page}/json`, { "page_size": pageSize }, ListResponse)
  }

  /// 1.4 hotkey
  getHotkeys(): Promise<Hotkey[]> {
    return Request.get('/hotkey/json')
  }

  /// 1.5 index top articles
  getTopList(): Promise<Article[]> {
    return Request.getList('/article/top/json', null, Article)
  }

  /// hierarchy article list
  getHierarchyArticleList(cid: number, page = 0, pageSize = 10): Promise<ListResponse> {
    return Request.get(`/article/list/${page}/json`, { "page_size": pageSize, "cid": cid }, ListResponse)
  }

  /// 4.2 project article list
  getProjectArticleList(cid: number, page = 0, pageSize = 10): Promise<ListResponse> {
    return Request.get(`/project/list/${page}/json`, { "page_size": pageSize, "cid": cid }, ListResponse)
  }

  /// 7.1 search article list
  getSearchArticleList(k: string, page = 0, pageSize = 10): Promise<ListResponse> {
    return Request.post(`/article/query/${page}/json`, { "page_size": pageSize, "k": k }, ListResponse)
  }

  /// 15.2 wx article list
  getWxArticleList(id: number, page = 0, pageSize = 10): Promise<ListResponse> {
    return Request.get(`/wxarticle/list/${id}/${page}/json`, { "page_size": pageSize }, ListResponse)
  }
}

let articleVm = new ArticleViewModel();

export default articleVm as ArticleViewModel;