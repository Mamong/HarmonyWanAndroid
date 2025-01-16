import { injectable, inject } from "inversify";

import { UsecaseWithParamsExp } from "../../../../core/usecase/usecase";
import { User } from "../entities/user";
import { AuthRepo } from "../repos/auth_repo";

@injectable()
export class Register extends UsecaseWithParamsExp<User, RegisterParams> {
  private repo: AuthRepo;

  constructor(@inject(AuthRepo)repo: AuthRepo) {
    super()
    this.repo = repo
  }

  call(params: RegisterParams): Promise<User> {
    return this.repo.register(
      params.username,
      params.password,
      params.repassword);
  }
}

interface RegisterParams {
  username:string;
  password:string;
  repassword:string;
}
