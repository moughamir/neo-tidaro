import 'dart:io';

import 'package:languist/src/config/config_reader.dart';

/// Command-line tool to run flutter gen-l10n with configuration from languist.yaml
void main(List<String> args) async {
  try {
    // Get the command to run
    final command = LanguistConfigReader.getGenL10nCommand();
    print('Running: $command');

    // Run the command
    final result = await Process.run('sh', ['-c', command], 
      runInShell: true, 
      workingDirectory: Directory.current.path
    );

    // Output the result
    print(result.stdout);
    stderr.write(result.stderr);

    // Return the exit code
    exit(result.exitCode);
  } catch (e) {
    print('Error generating localizations: $e');
    exit(1);
  }
}
