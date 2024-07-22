import 'package:bovi_sales/data/datasources/subscription_remote_data_source.dart';

class SubscriptionRepository {
  final SubscriptionRemoteDataSource remoteDataSource;

  SubscriptionRepository(this.remoteDataSource);

  Future<Map<String, dynamic>> getTransactions(int userId) async {
    return await remoteDataSource.fetchTransactions(userId);
  }

  Future<Map<String, dynamic>> getPlans(String token) async {
    return await remoteDataSource.fetchPlans(token);
  }

  Future<Map<String, dynamic>> subscribeToPlan(int userId, int planId, String s) async {
    return await remoteDataSource.subscribeToPlan(userId, planId);
  }

  Future<Map<String, dynamic>?> getSubscriptionStatus(int userId, String token) async {
    return await remoteDataSource.fetchSubscription(userId, token);
  }

}
