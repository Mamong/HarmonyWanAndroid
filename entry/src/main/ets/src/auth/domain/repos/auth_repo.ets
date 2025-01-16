import { Account } from '../entities/account';
import { User } from '../entities/user';

export abstract class AuthRepo {

  abstract getUser():Promise<Account>;

  abstract login(username:string, password:string):Promise<User>;

  abstract register(username:string, password:string, repassword:string):Promise<User>;

  abstract logout();
}