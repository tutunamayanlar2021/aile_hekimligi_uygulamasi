import 'package:dio/dio.dart';
import '../model/news_response.dart';

class NewsApiServices {
  final String _url =
      "https://newsapi.org/v2/top-headlines?country=tr&category=health&apiKey=f70ed7d37dcf4c21a647fe5ac3be99df";
  late Dio dio;

  NewsApiServices() {
    dio = Dio();
  }
  Future<List<Articles>?> fetchNewsArticle() async {
    try {
      Response response = await dio.get(_url);
      NewsResponce newsResponce = NewsResponce.fromJson(response.data);
      return newsResponce.articles;
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }
}
