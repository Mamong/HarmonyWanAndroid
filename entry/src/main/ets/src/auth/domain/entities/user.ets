import { instanceToPlain, plainToInstance } from "class-transformer"

export class User {
  admin: boolean
  chapterTops: number[]
  coinCount: number
  collectIds: number[]
  email: string
  icon: string
  id: number
  nickname: string
  type: number
  token: string
  username: string

  constructor(admin: boolean, chapterTops: number[], coinCount: number, collectIds: [], email: string, icon: string,
    id: number, nickname: string, type:number, token:string, username:string) {
    this.admin = admin
    this.chapterTops = chapterTops
    this.coinCount = coinCount
    this.collectIds = collectIds
    this.email = email
    this.icon = icon
    this.id = id
    this.nickname = nickname
    this.type = type
    this.token = token
    this.username = username
  }

  static fromJson(json: object) {
    return plainToInstance(User, json)
  }

  toJson() {
    return instanceToPlain(this)
  }
}