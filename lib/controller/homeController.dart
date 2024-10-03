import 'package:get/get.dart';
import 'package:login_firebase/data/repositories/github_repository.dart';
import 'package:login_firebase/models/github_user_model.dart';

class HomeController extends GetxController{
  final HerosUsers repository;

  final List<HerosUsers> _users = <HerosUsers>[].obs;
  List<HerosUsers> get users => _users;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  HomeController({required this.repository});

  fetchHeroInformation() async {
    _isLoading.value = true;

    final response = await repository.fetchHeroInformation();

    _users.addAll(response as Iterable<HerosUsers>);

    _isLoading.value = false;
  }
}