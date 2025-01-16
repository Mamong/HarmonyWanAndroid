
/// here we offer two usecase style: with exception or without exception
/// usecase without exception, that is, exception will be packed into the result
// abstract class UsecaseWithParams<Type, Params> {
//
//    abstract call(params?:Params):ResultFuture<Type>;
// }

// abstract class UsecaseWithoutParams<Type> {
//
//   ResultFuture<Type> call();
// }

/// usecase with exception, that is, exception will be thrown
export abstract class UsecaseWithParamsExp<Type, Params> {

  abstract call(params?:Params):Promise<Type>;
}

// abstract class UsecaseWithoutParamsExp<Type> {
//   const UsecaseWithoutParamsExp();
//
//   Future<Type> call();
// }

// class PaginatedParams extends Equatable {
//   final int page;
//   final int pageSize;
//
//   const PaginatedParams({
//   required this.page,
//   required this.pageSize,
// });
//
//   @override
//   List<Object?> get props => [page, pageSize];
// }
