import 'dart:io';

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage();
    return;
  } else if (arguments.first == 'version') {
    print('Dartpedia CLI version $version');
  } else if (arguments.first == 'search') {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else {
    printUsage();
  }
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'",
  );
}

void searchWikipedia(List<String>? arguments) {
  final String articleTitle;
  //If user does not pass in arguments, request an article title
  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    //Wait for input and provide a default empty string if input is null.
    articleTitle = stdin.readLineSync() ?? '';
  } else {
    //Otherwise, join the arguments into a single string.
    articleTitle = arguments.join(' ');
  }

  //print('Current article title: $articleTitle');
  print('Looking up articles about "$articleTitle". Please wait.');
  print('Here ya go!');
  print('(Pretend this is an article about "$articleTitle")');
}
