import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pemrograman_sistem_mobile/models/model_post.dart';


Future<List<Post>> fetchPosts() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
    return jsonList
        .map((json) => Post.fromJson(json as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to load posts');
  }
}
