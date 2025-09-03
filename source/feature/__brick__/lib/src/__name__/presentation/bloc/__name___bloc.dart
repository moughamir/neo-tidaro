import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{name.snakeCase()}}/src/{{name.snakeCase()}}/domain/usecases/get_{{name.snakeCase()}}_usecase.dart';
import 'package:{{name.snakeCase()}}/src/{{name.snakeCase()}}/presentation/bloc/{{name.snakeCase()}}_event.dart';
import 'package:{{name.snakeCase()}}/src/{{name.snakeCase()}}/presentation/bloc/{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  final Get{{name.pascalCase()}}UseCase get{{name.pascalCase()}}UseCase;

  {{name.pascalCase()}}Bloc({required this.get{{name.pascalCase()}}UseCase}) : super({{name.pascalCase()}}Initial()) {
    on<Get{{name.pascalCase()}}Event>((event, emit) async {
      emit({{name.pascalCase()}}Loading());
      try {
        final result = await get{{name.pascalCase()}}UseCase();
        emit({{name.pascalCase()}}Loaded(result));
      } catch (e) {
        emit({{name.pascalCase()}}Error(e.toString()));
      }
    });
  }
}
