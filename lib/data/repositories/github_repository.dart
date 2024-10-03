import 'package:dio/dio.dart';
import 'package:login_firebase/models/github_user_model.dart';

class HerosUsers {
  final Dio _dio = Dio();

  static const apiUrl = 'https://superheroapi.com/';
  static const apiKey = '6c60ce2e93f4d99e80189e7f0d586a26';


  Future<List<GithubUserModel>> fetchHeroInformation() async {
    const String allHerosUrl =
        '$apiUrl/$apiKey/search/name';

    try {
      final response = await _dio.get(allHerosUrl);
      if (response.statusCode == 200) {
        List<dynamic> herosList = [];

        var lists = response.data['results']['lists'] as List;
        for (var list in lists) {
          var heros = list['heros'] as List;
          herosList.addAll(heros);
        }

        return herosList.map((heros) => GithubUserModel.fromJson(heros)).toList();
      } else {
        throw Exception('Erro ao tentar pegar informações do herói!');
      }
    } catch (e) {
      throw Exception('Erro ao acessar api ${e}!');
    }
  }
}