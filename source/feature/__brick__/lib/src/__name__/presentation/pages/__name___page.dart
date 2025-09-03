import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{name.snakeCase()}}/src/{{name.snakeCase()}}/presentation/bloc/{{name.snakeCase()}}_bloc.dart';
import 'package:{{name.snakeCase()}}/src/{{name.snakeCase()}}/presentation/bloc/{{name.snakeCase()}}_event.dart';
import 'package:{{name.snakeCase()}}/src/{{name.snakeCase()}}/presentation/bloc/{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Page extends StatelessWidget {
  const {{name.pascalCase()}}Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{{name.pascalCase()}} Feature'),
      ),
      body: BlocBuilder<{{name.pascalCase()}}Bloc, {{name.pascalCase()}}State>(
        builder: (context, state) {
          if (state is {{name.pascalCase()}}Initial) {
            context.read<{{name.pascalCase()}}Bloc>().add(Get{{name.pascalCase()}}Event());
            return const Center(child: Text('Tap to load data'));
          } else if (state is {{name.pascalCase()}}Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is {{name.pascalCase()}}Loaded) {
            return Center(child: Text('Data: ${state.{{name.camelCase()}}Entity.name}'));
          } else if (state is {{name.pascalCase()}}Error) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}
