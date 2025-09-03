import 'package:{{name.snakeCase()}}/src/{{name.snakeCase()}}/domain/entities/{{name.snakeCase()}}_entity.dart';

abstract class {{name.pascalCase()}}Repository {
  Future<{{name.pascalCase()}}Entity> get{{name.pascalCase()}}();
}
