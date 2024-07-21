// lib/presentation/bindings/premium_binding.dart
import 'package:get/get.dart';
import '../controllers/premium_controller.dart';
import '../../data/datasources/subscription_remote_data_source.dart';
import '../../data/repositories/subscription_repository.dart';
import 'package:http/http.dart' as http;

class PremiumBinding extends Bindings {
  @override
  void dependencies() {
    final client = http.Client();
    final remoteDataSource = SubscriptionRemoteDataSource(client);
    final repository = SubscriptionRepository(remoteDataSource);
    Get.lazyPut<PremiumController>(() => PremiumController(repository));
  }
}
