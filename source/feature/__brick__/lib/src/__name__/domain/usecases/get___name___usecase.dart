import 'package:{{name.snakeCase()}}/src/{{name.snakeCase()}}/domain/entities/{{name.snakeCase()}}_entity.dart';
import 'package:{{name.snakeCase()}}/src/{{name.snakeCase()}}/domain/repositories/{{name.snakeCase()}}_repository.dart';

class Get{{name.pascalCase()}}UseCase {
  final {{name.pascalCase()}}Repository repository;

  Get{{name.pascalCase()}}UseCase(this.repository);

  Future<{{name.pascalCase()}}Entity> call() async {
    return await repository.get{{name.pascalCase()}}();
  }
}
