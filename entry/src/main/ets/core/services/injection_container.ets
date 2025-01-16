import { Container } from "inversify";
import { AuthRemoteDataSrc, AuthRemoteDataSrcImpl } from "../../src/auth/data/datasources/auth_remote_data_src";
import { AuthRepoImpl } from "../../src/auth/data/repos/auth_repo_impl";
import { AuthRepo } from "../../src/auth/domain/repos/auth_repo";
import { Login } from "../../src/auth/domain/usecases/login";
import { Register } from "../../src/auth/domain/usecases/register";
import { HttpRequestService } from "../../utils/HttpRequestService";
import { HttpService } from "../../utils/HttpService";

const myContainer = new Container({ skipBaseClassChecks: true });
init()

function init() {
  // cacheInit();
  authInit();
  // userInit();
  // homeInit();
  // articleInit();
  // collectionInit();
}

function authInit() {
  myContainer.bind<Login>(Login).to(Login);
  //myContainer.bind<Logout>(Logout).to(Logout);
  myContainer.bind<Register>(Register).to(Register);
  //myContainer.bind<GetUser>(GetUser).to(GetUser);
  myContainer.bind<AuthRepo>(AuthRepo).to(AuthRepoImpl);
  myContainer.bind<AuthRemoteDataSrc>(AuthRemoteDataSrc).to(AuthRemoteDataSrcImpl);
  myContainer.bind<HttpService>(HttpService).to(HttpRequestService);
}

export { myContainer };

