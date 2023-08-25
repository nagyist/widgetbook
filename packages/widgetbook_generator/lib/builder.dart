import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'generators/app_generator.dart';
import 'generators/json_builder.dart';
import 'generators/use_case_generator.dart';
import 'models/use_case_metadata.dart';

/// Builder for the [UseCase] annotation.
/// Creates a `.usecase.widgetbook.json` file for each `.dart` file containing
/// the [UseCase] annotation. The file contains a list of [UseCaseMetadata]
/// json objects representing the annotated elements. These files are used
/// later on by other builders to generate more code.
Builder useCaseBuilder(BuilderOptions options) {
  return JsonBuilder(
    UseCaseGenerator(),
    generatedExtension: '.usecase.widgetbook.json',
    formatOutput: (input) {
      // [GeneratorForAnnotation] joins the JSON objects by two newlines,
      // we replace that by a comma, and we surround the whole thing with
      // square brackets to make it a valid JSON list.
      final joined = input.replaceAll('\n\n', ',\n');
      return '[$joined]';
    },
  );
}

/// Builder for the [App] annotation.
/// Creates exactly one .g.dart file next to the file containing
/// the [App] annotation.
Builder appBuilder(BuilderOptions options) {
  const ignoredLintRules = {
    'unused_import',
    'prefer_relative_imports',
    'directives_ordering',
  };

  final headerParts = [
    '// coverage:ignore-file',
    '// ignore_for_file: type=lint',
    '// ignore_for_file: ${ignoredLintRules.join(", ")}',
    '\n$defaultFileHeader',
  ];

  return LibraryBuilder(
    AppGenerator(),
    generatedExtension: '.directories.g.dart',
    header: headerParts.join('\n'),
  );
}
