// ====================================================
// core/providers/purchase_provider.dart
// Riverpod providers for RevenueCat state
// ====================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:faseeh_kids/services/revenue_cat_service.dart';

// ─── Notifier that holds premium status ───
class PurchaseNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    return RevenueCatService.instance.refreshPremiumStatus();
  }

  Future<bool> purchase(Package package) async {
    state = const AsyncLoading();
    final success = await RevenueCatService.instance.purchase(package);
    state = AsyncData(success);
    return success;
  }

  Future<bool> restore() async {
    state = const AsyncLoading();
    final success = await RevenueCatService.instance.restorePurchases();
    state = AsyncData(success);
    return success;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final isPremium = await RevenueCatService.instance.refreshPremiumStatus();
    state = AsyncData(isPremium);
  }
}

// ─── Main premium status provider ───
final purchaseProvider = AsyncNotifierProvider<PurchaseNotifier, bool>(
  PurchaseNotifier.new,
);

// ─── Convenience: sync bool (defaults to false if loading) ───
final isPremiumProvider = Provider<bool>((ref) {
  return ref.watch(purchaseProvider).valueOrNull ?? false;
});

// ─── Per-letter access provider ───
final letterAccessProvider = Provider.family<bool, int>((ref, letterIndex) {
  final isPremium = ref.watch(isPremiumProvider);
  return RevenueCatService.instance.isLetterAccessible(letterIndex)
      || isPremium;
});

// ─── Offerings provider ───
final offeringsProvider = FutureProvider<Offerings?>((ref) async {
  return RevenueCatService.instance.getOfferings();
});
