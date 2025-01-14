import { Type } from 'class-transformer';
import 'reflect-metadata'

interface Tag {
  name: string,
  url: string
}

export class Article {
  isTop?: boolean;
  adminAdd: boolean = false;
  apkLink: string = "";
  audit: 0 | 1 = 0;
  author: string = "";
  canEdit: boolean = false;
  chapterId: number = 0;
  chapterName: string = "";
  collect: boolean = false;
  courseId: number = 0;
  desc: string = "";
  descMd: string = "";
  envelopePic: string = "";
  fresh: boolean = false;
  host: string = "";
  id: number = 0;
  isAdminAdd: boolean = false;
  link: string = "";
  niceDate: string = "";
  niceShareDate: string = "";
  origin: string = "";
  originId?: number = 0;
  prefix: string = "";
  projectLink: string = "";
  publishTime: number = 0;
  realSuperChapterId: number = 0;
  selfVisible: 0 | 1 = 1;
  shareDate: string = "";
  shareUser: string = "";
  superChapterId: number = 0;
  superChapterName: string = "";
  tags: Tag[] = [];
  title: string = "";
  type: number = 0;
  userId: number = 0;
  visible: 0 | 1 = 1;
  zan: number = 0;

  get displayAuthor(): string {
    return [this.author, this.shareUser, this.chapterName].find((item: string) => item.length > 0) ?? ""
  }
}


export interface Banner {
  desc: string,
  id: number,
  imagePath: string,
  isVisible: 0 | 1
  order: number,
  title: string,
  type: number,
  url: string
}

export interface Website {
  category: string,
  icon: string,
  id: number,
  link: string,
  name: string,
  order: number,
  visible: 0 | 1
}

export interface Hotkey {
  id: number,
  link: string,
  name: string,
  order: number,
  visible: 0 | 1
}

export interface Tree {
  //articleList:[],
  author: string,
  children: Tree[],
  courseId: number,
  cover: string,
  desc: string,
  id: number,
  lisense: string,
  lisenseLink: string,
  name: string,
  order: number,
  parentChapterId: number,
  type: number,
  userControlSetTop: boolean,
  visible: 0 | 1
}

export interface Navi {
  cid: number,
  name: string,
  articles: Article[]
}

export class ListResponse {
  curPage: number = 0;

  @Type(() => Article)
  datas: Article[] = [];

  offset: number = 0;
  over: boolean = false;
  pageCount: number = 0;
  size: number = 20;
  total: number = 0;
  // constructor(curPage:number,datas:T[],offset:number, over:boolean, pageCount:number, size:number, total:number) {
  //   this.curPage = curPage;
  //   this.datas = datas;
  //   this.offset = offset;
  //   this.over = over;
  //   this.pageCount = pageCount;
  //   this.size = size;
  //   this.total = total;
  // }
}

export interface UserInfo {
  admin: boolean,
  chapterTops: [],
  coinCount: number,
  collectIds: [],
  email: string,
  icon: string,
  id: number,
  nickname: number,
  type: number,
  token: string
  username: string
  password: string,
  repassword: string
}

export class CoinListResponse {
  curPage: number = 0;

  @Type(() => CoinDetail)
  datas: CoinDetail[] = [];

  offset: number = 0;
  over: boolean = false;
  pageCount: number = 0;
  size: number = 20;
  total: number = 0;
}


export interface CoinInfo {
  coinCount: number,
  rank: number,
  level: number,
  userId: number,
  username: string,
  nickname: string
}

export class  CoinDetail {
  reason: string = ""
  desc: string=""
  coinCount: number=0
}