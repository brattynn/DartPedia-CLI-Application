import 'dart:io';
import 'package:http/http.dart' as http;

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage();
    return;
  } else if (arguments.first == 'version') {
    print('Dartpedia CLI version $version');
  } else if (arguments.first == 'wikipedia') {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else {
    printUsage();
  }
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'wikipedia <ARTICLE-TITLE>'",
  );
}

void searchWikipedia(List<String>? arguments) async {
  final String articleTitle;
  //If user does not pass in arguments, request an article title
  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    final inputFromStdin = stdin.readLineSync();
    //Wait for input and provide a default empty string if input is null.

    if (inputFromStdin == null || inputFromStdin.isEmpty) {
      print('No article title provided. Exiting.');
      return; //Exits if no title is provided
    }
    articleTitle = inputFromStdin;
  } else {
    //Otherwise, join the arguments into a single string.
    articleTitle = arguments.join(' ');
  }

  //print('Current article title: $articleTitle');
  print('Looking up articles about "$articleTitle". Please wait.');
  var articleContent = await getWikipediaArticle(articleTitle);
  print(articleContent); //Prints the full article response (raw JSON for now)
}

Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle', //API path for article summary
  );
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  }

  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}
