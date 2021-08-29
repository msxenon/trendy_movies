import 'package:get/get.dart';
import 'package:terndy_movies/home/domain/entity/movies_page_model.dart';

// ignore: one_member_abstracts
abstract class IHomeRepository {
  Future<MoviesPageModel> getCases();
}

// ignore: one_member_abstracts
abstract class IHomeProvider {
  Future<Response<MoviesPageModel>> getCases();
}

class HomeProvider extends GetConnect implements IHomeProvider {
  @override
  void onInit() {
    httpClient.defaultDecoder =
        (val) => MoviesPageModel.fromJson(val as Map<String, dynamic>);
    httpClient.baseUrl =
        'https://api.themoviedb.org/3/trending/all/day?api_key=269cf15030b5a2d4f1a34c35b720202f';
  }

  @override
  Future<Response<MoviesPageModel>> getCases() => get('');
}

class HomeRepository implements IHomeRepository {
  HomeRepository({required this.provider});
  final IHomeProvider provider;

  @override
  Future<MoviesPageModel> getCases() async {
    final cases = await provider.getCases();
    print('xxx ${cases.statusText} == ${cases.body}');

    if (cases.status.hasError) {
      return Future.error(cases.statusText!);
    } else {
      return cases.body!;
    }
  }
}
