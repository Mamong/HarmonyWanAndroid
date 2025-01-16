import { plainToInstance } from "class-transformer";
import { User } from "../../domain/entities/user";

export class UserModel {
  admin: boolean = false
  chapterTops: [] = []
  coinCount: number = 0
  collectIds: [] = []
  email: string = ""
  icon: string = ""
  id: number = 0
  nickname: string = ""
  type: number = 0
  token: string = ""
  username: string = ""
  password: string = ""
  repassword: string = ""

  static fromJson(json: object) {
    return plainToInstance(UserModel, json)
  }

  toDomainModel() {
    return new User(
      this.admin,
      this.chapterTops,
      this.coinCount,
      this.collectIds,
      this.email,
      this.icon,
      this.id,
      this.nickname,
      this.type,
      this.token,
      this.username,
    )
  }
}