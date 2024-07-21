// lib/presentation/bindings/navigation_binding.dart
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/subscription_controller.dart';
import '../../data/datasources/subscription_remote_data_source.dart';
import '../../data/repositories/subscription_repository.dart';
import 'package:http/http.dart' as http;

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    final client = http.Client();
    final remoteDataSource = SubscriptionRemoteDataSource(client);
    final repository = SubscriptionRepository(remoteDataSource);
    Get.lazyPut<SubscriptionController>(() => SubscriptionController(repository));
    Get.lazyPut<NavigationController>(() => NavigationController(repository: repository, apiKey: 'your_api_key_here'));
  }
}
