import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  Future<List<Map<String, dynamic>>> fetchDataFromApi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=160d6229e69946b3a83c198a4a1a18b7';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var articles = jsonDecode(response.body)['articles'];
      return List<Map<String, dynamic>>.from(articles);
    } else {
      throw Exception('Failed to fetch articles');
    }
  }
}
