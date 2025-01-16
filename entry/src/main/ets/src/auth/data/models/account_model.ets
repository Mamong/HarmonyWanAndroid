import { plainToInstance } from "class-transformer";

export class AccountModel{

  static fromJson(json:object){
    return plainToInstance(AccountModel,json)
  }

  toDomainModel(){
    return new AccountModel()
  }
}