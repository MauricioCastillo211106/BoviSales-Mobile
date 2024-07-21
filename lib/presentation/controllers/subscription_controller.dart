import 'package:get/get.dart';
import 'package:bovi_sales/data/repositories/subscription_repository.dart';

class SubscriptionController extends GetxController {
  final SubscriptionRepository repository;

  SubscriptionController(this.repository);

  var subscriptionStatus = ''.obs;

  Future<void> checkSubscription(int userId, String token) async {
    var subscription = await repository.getSubscriptionStatus(userId, token);
    if (subscription != null && subscription['getSubscription'] != null) {
      subscriptionStatus.value = subscription['getSubscription']['status'];
    } else {
      subscriptionStatus.value = 'Inactive';
    }
  }

  bool isActive() {
    return subscriptionStatus.value == 'Active';
  }
}
