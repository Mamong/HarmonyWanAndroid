import { injectable, inject } from "inversify";

import { UsecaseWithParamsExp } from "../../../../core/usecase/usecase";
import { User } from "../entities/user";
import { AuthRepo } from "../repos/auth_repo";


@injectable()
export class Login extends UsecaseWithParamsExp<User, LoginParams> {
  private repo: AuthRepo;

  constructor(@inject(AuthRepo)repo:AuthRepo) {
    super()
    this.repo = repo
  }

  call(params:LoginParams):Promise<User> {
    return this.repo.login(params.username, params.password);
  }
}

interface  LoginParams {
  username:string
  password:string
}
