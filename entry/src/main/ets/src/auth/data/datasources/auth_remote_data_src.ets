import { injectable, inject } from "inversify";

import { HttpService } from '../../../../utils/HttpService';
import { AccountModel } from '../models/account_model';
import { UserModel } from '../models/user_model';

export abstract class AuthRemoteDataSrc {
  abstract getUser(): Promise<AccountModel>;

  abstract login(username: string, password: string): Promise<UserModel>;

  abstract register(username: string, password: string, repassword: string): Promise<UserModel>;

  abstract logout();
}

@injectable()
export class AuthRemoteDataSrcImpl extends AuthRemoteDataSrc {
  private httpService: HttpService

  constructor(@inject(HttpService)httpService: HttpService) {
    super();
    this.httpService = httpService
  }

  async getUser(): Promise<AccountModel> {
    let responseData = await this.httpService.get('/user/lg/userinfo/json');
    return AccountModel.fromJson(responseData.data!);
  }

  async login(username: string, password: string): Promise<UserModel> {
    let responseData = await this.httpService.post('/user/login',
      { "username": username, "password": password });
    return UserModel.fromJson(responseData.data!);
  }

  async register(username: string, password: string, repassword: string): Promise<UserModel> {
    let responseData = await this.httpService.post('/user/register', {
      "username": username,
      "password": password,
      "repassword": repassword
    });
    return UserModel.fromJson(responseData.data!);
  }

  async logout(): Promise<void> {
    await this.httpService.get('/user/logout');
  }
}