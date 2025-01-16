import { injectable, inject } from "inversify";
import { Account } from "../../domain/entities/account";
import { User } from "../../domain/entities/user";
import { AuthRepo } from "../../domain/repos/auth_repo";
import { AuthRemoteDataSrc } from "../datasources/auth_remote_data_src";

@injectable()
export class AuthRepoImpl extends AuthRepo {
  private remoteDataSource: AuthRemoteDataSrc

  constructor(@inject(AuthRemoteDataSrc)remoteDataSource: AuthRemoteDataSrc) {
    super()
    this.remoteDataSource = remoteDataSource
  }

  async getUser(): Promise<Account> {
    let result = await this.remoteDataSource.getUser();
    return result.toDomainModel();
  }

  async login(username: string, password: string): Promise<User> {
    let result =
      await this.remoteDataSource.login(username, password);
    return result.toDomainModel();
  }

  async register(username: string, password: string, repassword: string): Promise<User> {
    let result = await this.remoteDataSource.register(
      username, password, repassword);
    return result.toDomainModel();
  }

  async logout(): Promise<void> {
    return await this.remoteDataSource.logout();
  }
}
