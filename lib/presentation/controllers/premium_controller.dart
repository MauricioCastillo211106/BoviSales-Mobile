import 'package:get/get.dart';
import '../../data/repositories/subscription_repository.dart';
import '../pages/webview_page.dart';

class PremiumController extends GetxController {
  final SubscriptionRepository repository;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var plans = [].obs;

  PremiumController(this.repository);

  @override
  void onInit() {
    super.onInit();
    fetchPlans();
  }

  Future<void> fetchPlans() async {
    try {
      isLoading.value = true;
      final responseData = await repository.getPlans('your_api_key_here');
      plans.assignAll(responseData['plans']);
    } catch (e) {
      errorMessage.value = 'Failed to load plans';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> subscribeToPlan(int userId, int planId) async {
    try {
      isLoading.value = true;
      final responseData = await repository.subscribeToPlan(userId, planId, 'your_api_key_here');
      if (responseData['createdSubscription'] != null) {
        final approvalUrl = responseData['createdSubscription']['transaction']['approval_url'];
        print(approvalUrl);
        if (approvalUrl != null) {
          Get.to(() => WebViewPage(url: approvalUrl));
        } else {
          Get.snackbar('Error', 'Failed to get approval URL.');
        }
      } else {
        Get.snackbar('Error', 'Failed to subscribe to plan.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to subscribe to plan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
