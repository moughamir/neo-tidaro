part of '{{name.snakeCase()}}_bloc.dart';

abstract class {{name.pascalCase()}}State {}

class {{name.pascalCase()}}Initial extends {{name.pascalCase()}}State {}

class {{name.pascalCase()}}Loading extends {{name.pascalCase()}}State {}

class {{name.pascalCase()}}Loaded extends {{name.pascalCase()}}State {
  final {{name.pascalCase()}}Entity {{name.camelCase()}}Entity;

  {{name.pascalCase()}}Loaded(this.{{name.camelCase()}}Entity);
}

class {{name.pascalCase()}}Error extends {{name.pascalCase()}}State {
  final String message;

  {{name.pascalCase()}}Error(this.message);
}
