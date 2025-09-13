import 'dart:io';

import 'package:yaml/yaml.dart';

/// Class to read and parse the languist.yaml configuration file
class LanguistConfigReader {
  /// The path to the languist.yaml configuration file
  static const String configPath = 'languist.yaml';

  /// Read the configuration file and return a map of the configuration
  static Map<String, dynamic> readConfig() {
    final File file = File(configPath);

    if (!file.existsSync()) {
      throw const FileSystemException('Configuration file not found', configPath);
    }

    final String yamlString = file.readAsStringSync();
    final YamlMap yamlMap = loadYaml(yamlString) as YamlMap;

    return _convertYamlMapToMap(yamlMap);
  }

  /// Get the flutter gen-l10n command arguments based on the configuration
  static List<String> getGenL10nArgs() {
    final Map<String, dynamic> config = readConfig();

    final List<String> args = [
      'gen-l10n',
      '--arb-dir=${config['arb-dir'] ?? 'lib/l10n'}',
      '--template-arb-file=${config['template-arb-file'] ?? 'intl_en.arb'}',
      '--output-localization-file=${config['output-localization-file'] ?? 'intl_localizations.dart'}',
      '--output-class=${config['output-class'] ?? 'IntlLocalizations'}',
    ];

    if (config['output-dir'] != null) {
      args.add('--output-dir=${config['output-dir']}');
    }

    // Add boolean flags
    if (config['nullable-getter'] == false) {
      args.add('--no-nullable-getter');
    }

    return args;
  }

  /// Get the command string to run in the melos script
  static String getGenL10nCommand() {
    return 'flutter ${getGenL10nArgs().join(' ')}';
  }

  /// Convert YamlMap to a regular Map<String, dynamic>
  static Map<String, dynamic> _convertYamlMapToMap(YamlMap yamlMap) {
    final Map<String, dynamic> result = {};

    for (final MapEntry<dynamic, dynamic> entry in yamlMap.entries) {
      if (entry.value is YamlMap) {
        result[entry.key.toString()] = _convertYamlMapToMap(
          entry.value as YamlMap,
        );
      } else if (entry.value is YamlList) {
        result[entry.key.toString()] = _convertYamlListToList(
          entry.value as YamlList,
        );
      } else {
        result[entry.key.toString()] = entry.value;
      }
    }

    return result;
  }

  /// Convert YamlList to a regular List<dynamic>
  static List<dynamic> _convertYamlListToList(YamlList yamlList) {
    final List<dynamic> result = [];

    for (final dynamic item in yamlList) {
      if (item is YamlMap) {
        result.add(_convertYamlMapToMap(item));
      } else if (item is YamlList) {
        result.add(_convertYamlListToList(item));
      } else {
        result.add(item);
      }
    }

    return result;
  }
}
