/// Utility class for markdown operations and transformations
class MarkdownUtils {
  MarkdownUtils._();

  /// Creates a markdown header with content
  static String createHeader(String title, String content, {int level = 1}) {
    final headerPrefix = '#' * level.clamp(1, 6);
    return '$headerPrefix $title\n\n$content';
  }

  /// Creates a markdown list from items
  static String createList(List<String> items, {bool ordered = false}) {
    if (items.isEmpty) return '';
    
    return items
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final item = entry.value;
          return ordered ? '${index + 1}. $item' : '- $item';
        })
        .join('\n');
  }

  /// Creates a markdown link
  static String createLink(String text, String url) {
    return '[${text.trim()}](${url.trim()})';
  }

  /// Creates a markdown code block
  static String createCodeBlock(String code, {String language = ''}) {
    return '```$language\n$code\n```';
  }

  /// Creates a markdown table from headers and rows
  static String createTable(List<String> headers, List<List<String>> rows) {
    if (headers.isEmpty) return '';
    
    final headerRow = '| ${headers.join(' | ')} |';
    final separatorRow = '| ${headers.map((_) => '---').join(' | ')} |';
    
    final dataRows = rows.map((row) {
      final paddedRow = List<String>.from(row);
      while (paddedRow.length < headers.length) {
        paddedRow.add('');
      }
      return '| ${paddedRow.take(headers.length).join(' | ')} |';
    }).join('\n');
    
    return '$headerRow\n$separatorRow\n$dataRows';
  }

  /// Creates a markdown quote block
  static String createQuote(String text, {String? author}) {
    final lines = text.split('\n').map((line) => '> $line').join('\n');
    if (author != null) {
      return '$lines\n>\n> — $author';
    }
    return lines;
  }

  /// Escapes special markdown characters
  static String escapeMarkdown(String text) {
    const specialChars = ['*', '_', '`', '[', ']', '(', ')', '#', '+', '-', '.', '!'];
    String escaped = text;
    
    for (final char in specialChars) {
      escaped = escaped.replaceAll(char, '\\$char');
    }
    
    return escaped;
  }

  /// Removes markdown formatting and returns plain text
  static String stripMarkdown(String markdown) {
    String text = markdown;
    
    // Remove headers
    text = text.replaceAll(RegExp(r'^#{1,6}\s+'), '');
    
    // Remove bold and italic
    text = text.replaceAll(RegExp(r'\*\*(.*?)\*\*'), r'$1');
    text = text.replaceAll(RegExp(r'\*(.*?)\*'), r'$1');
    text = text.replaceAll(RegExp(r'__(.*?)__'), r'$1');
    text = text.replaceAll(RegExp(r'_(.*?)_'), r'$1');
    
    // Remove links
    text = text.replaceAll(RegExp(r'\[([^\]]+)\]\([^\)]+\)'), r'$1');
    
    // Remove code blocks and inline code
    text = text.replaceAll(RegExp(r'```[\s\S]*?```'), '');
    text = text.replaceAll(RegExp(r'`([^`]+)`'), r'$1');
    
    // Remove list markers
    text = text.replaceAll(RegExp(r'^\s*[-*+]\s+', multiLine: true), '');
    text = text.replaceAll(RegExp(r'^\s*\d+\.\s+', multiLine: true), '');
    
    // Remove blockquotes
    text = text.replaceAll(RegExp(r'^\s*>\s*', multiLine: true), '');
    
    return text.trim();
  }

  /// Validates if a string contains valid markdown
  static bool isValidMarkdown(String text) {
    if (text.trim().isEmpty) return false;
    
    // Check for unmatched brackets
    int openBrackets = 0;
    int openParens = 0;
    
    for (int i = 0; i < text.length; i++) {
      switch (text[i]) {
        case '[':
          openBrackets++;
          break;
        case ']':
          openBrackets--;
          break;
        case '(':
          if (i > 0 && text[i - 1] == ']') openParens++;
          break;
        case ')':
          openParens--;
          break;
      }
    }
    
    return openBrackets == 0 && openParens == 0;
  }

  /// Extracts all links from markdown text
  static List<MarkdownLink> extractLinks(String markdown) {
    final linkRegex = RegExp(r'\[([^\]]+)\]\(([^\)]+)\)');
    final matches = linkRegex.allMatches(markdown);
    
    return matches.map((match) {
      return MarkdownLink(
        text: match.group(1) ?? '',
        url: match.group(2) ?? '',
        startIndex: match.start,
        endIndex: match.end,
      );
    }).toList();
  }

  /// Extracts all headers from markdown text
  static List<MarkdownHeader> extractHeaders(String markdown) {
    final headerRegex = RegExp(r'^(#{1,6})\s+(.+)$', multiLine: true);
    final matches = headerRegex.allMatches(markdown);
    
    return matches.map((match) {
      return MarkdownHeader(
        level: match.group(1)?.length ?? 1,
        text: match.group(2) ?? '',
        startIndex: match.start,
        endIndex: match.end,
      );
    }).toList();
  }

  /// Generates a table of contents from markdown headers
  static String generateTableOfContents(String markdown, {int maxLevel = 3}) {
    final headers = extractHeaders(markdown);
    final filteredHeaders = headers.where((h) => h.level <= maxLevel).toList();
    
    if (filteredHeaders.isEmpty) return '';
    
    final tocItems = filteredHeaders.map((header) {
      final indent = '  ' * (header.level - 1);
      final anchor = header.text.toLowerCase()
          .replaceAll(RegExp(r'[^\w\s-]'), '')
          .replaceAll(RegExp(r'\s+'), '-');
      return '$indent- [${header.text}](#$anchor)';
    }).join('\n');
    
    return '## Table of Contents\n\n$tocItems\n';
  }

  /// Counts words in markdown text (excluding formatting)
  static int countWords(String markdown) {
    final plainText = stripMarkdown(markdown);
    final words = plainText.split(RegExp(r'\s+'));
    return words.where((word) => word.isNotEmpty).length;
  }

  /// Estimates reading time in minutes
  static int estimateReadingTime(String markdown, {int wordsPerMinute = 200}) {
    final wordCount = countWords(markdown);
    return (wordCount / wordsPerMinute).ceil().clamp(1, double.infinity).toInt();
  }
}

/// Represents a markdown link
class MarkdownLink {
  final String text;
  final String url;
  final int startIndex;
  final int endIndex;

  const MarkdownLink({
    required this.text,
    required this.url,
    required this.startIndex,
    required this.endIndex,
  });

  @override
  String toString() => '[$text]($url)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarkdownLink &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          url == other.url;

  @override
  int get hashCode => text.hashCode ^ url.hashCode;
}

/// Represents a markdown header
class MarkdownHeader {
  final int level;
  final String text;
  final int startIndex;
  final int endIndex;

  const MarkdownHeader({
    required this.level,
    required this.text,
    required this.startIndex,
    required this.endIndex,
  });

  @override
  String toString() => '${'#' * level} $text';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarkdownHeader &&
          runtimeType == other.runtimeType &&
          level == other.level &&
          text == other.text;

  @override
  int get hashCode => level.hashCode ^ text.hashCode;
}
