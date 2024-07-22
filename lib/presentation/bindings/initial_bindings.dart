// lib/presentation/bindings/initial_binding.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controllers/navigation_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/ganado_controller.dart';
import '../controllers/publicaciones_controller.dart';
import '../controllers/custom_search_controller.dart';
import '../controllers/subscription_controller.dart';
import '../../data/datasources/subscription_remote_data_source.dart';
import '../../data/repositories/subscription_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    final httpClient = http.Client();
    final subscriptionRemoteDataSource = SubscriptionRemoteDataSource(httpClient);
    final subscriptionRepository = SubscriptionRepository(subscriptionRemoteDataSource);

    Get.put(subscriptionRepository);
    Get.put(NavigationController(repository: subscriptionRepository, apiKey: 'your_api_key_here'));
    Get.put(SubscriptionController(subscriptionRepository));

    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<GanadoController>(() => GanadoController());
    Get.lazyPut<PublicacionesController>(() => PublicacionesController());
    Get.lazyPut<CustomSearchController>(() => CustomSearchController());
  }
}
