import 'package:{{name.snakeCase()}}/src/{{name.snakeCase()}}/domain/repositories/{{name.snakeCase()}}_repository.dart';
import 'package:{{name.snakeCase()}}/src/{{name.snakeCase()}}/data/datasources/{{name.snakeCase()}}_local_datasource.dart';
import 'package:{{name.snakeCase()}}/src/{{name.snakeCase()}}/data/datasources/{{name.snakeCase()}}_remote_datasource.dart';

class {{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository {
  final {{name.pascalCase()}}LocalDataSource localDataSource;
  final {{name.pascalCase()}}RemoteDataSource remoteDataSource;

  {{name.pascalCase()}}RepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  // TODO: implement methods from {{name.pascalCase()}}Repository
}
