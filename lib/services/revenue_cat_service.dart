// ====================================================
// services/revenue_cat_service.dart
// RevenueCat Integration — Faseeh Kids Monetization
// ====================================================
//
// نموذج الاشتراك:
//   FREE:    أول 5 حروف (أ ب ت ث ج) — قيمة حقيقية مجانية
//   PREMIUM: 28 حرفاً كاملاً + وضع الوالدين + أنشطة متقدمة
//
// الأسعار المقترحة:
//   faseeh_monthly  → $2.99/شهر
//   faseeh_yearly   → $14.99/سنة (وفر 58%)
//   faseeh_lifetime → $29.99 مرة واحدة
// ====================================================

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  static final RevenueCatService _instance = RevenueCatService._internal();
  factory RevenueCatService() => _instance;
  RevenueCatService._internal();

  static RevenueCatService get instance => _instance;

  // ─── API Keys (replace with real keys from RevenueCat Dashboard) ───
  static const String _googleApiKey = 'goog_YOUR_REVENUECAT_KEY_HERE';
  static const String _appleApiKey  = 'appl_YOUR_REVENUECAT_KEY_HERE';

  // ─── Entitlement identifier (defined in RevenueCat dashboard) ───
  static const String premiumEntitlement = 'faseeh_premium';

  // ─── Product identifiers ───
  static const String monthlyId  = 'faseeh_monthly';
  static const String yearlyId   = 'faseeh_yearly';
  static const String lifetimeId = 'faseeh_lifetime';

  // ─── Free tier: first 5 letters always free ───
  static const int freeLetterCount = 5;

  bool _isInitialized = false;
  bool _isPremium = false;
  CustomerInfo? _customerInfo;

  bool get isPremium => _isPremium;
  CustomerInfo? get customerInfo => _customerInfo;

  // ─── Initialize RevenueCat ───
  Future<void> init({String? userId}) async {
    if (_isInitialized) return;
    try {
      await Purchases.setLogLevel(LogLevel.warn);

      final config = PurchasesConfiguration(
        Platform.isAndroid ? _googleApiKey : _appleApiKey,
      )..appUserID = userId;

      await Purchases.configure(config);
      _isInitialized = true;

      // Immediately check premium status
      await refreshPremiumStatus();

      debugPrint('RevenueCatService: ✅ Initialized. isPremium=$_isPremium');
    } catch (e) {
      debugPrint('RevenueCatService: ❌ Init error — $e');
    }
  }

  // ─── Refresh premium entitlement status ───
  Future<bool> refreshPremiumStatus() async {
    try {
      _customerInfo = await Purchases.getCustomerInfo();
      _isPremium = _customerInfo!
          .entitlements
          .active
          .containsKey(premiumEntitlement);
      return _isPremium;
    } catch (e) {
      debugPrint('RevenueCatService: refreshPremiumStatus error — $e');
      return false;
    }
  }

  // ─── Fetch available offerings ───
  Future<Offerings?> getOfferings() async {
    try {
      return await Purchases.getOfferings();
    } catch (e) {
      debugPrint('RevenueCatService: getOfferings error — $e');
      return null;
    }
  }

  // ─── Purchase a package ───
  Future<bool> purchase(Package package) async {
    try {
      final result = await Purchases.purchasePackage(package);
      _customerInfo = result.customerInfo;
      _isPremium = _customerInfo!.entitlements.active.containsKey(premiumEntitlement);
      return _isPremium;
    } on PurchasesErrorCode catch (e) {
      if (e == PurchasesErrorCode.purchaseCancelledError) {
        debugPrint('RevenueCatService: User cancelled purchase');
      } else {
        debugPrint('RevenueCatService: Purchase error — $e');
      }
      return false;
    } catch (e) {
      debugPrint('RevenueCatService: Unexpected purchase error — $e');
      return false;
    }
  }

  // ─── Restore purchases ───
  Future<bool> restorePurchases() async {
    try {
      final info = await Purchases.restorePurchases();
      _customerInfo = info;
      _isPremium = info.entitlements.active.containsKey(premiumEntitlement);
      return _isPremium;
    } catch (e) {
      debugPrint('RevenueCatService: Restore error — $e');
      return false;
    }
  }

  // ─── Check if a specific letter index is accessible ───
  /// Letters 0-4 (first 5) are always free.
  /// Letters 5-27 require premium.
  bool isLetterAccessible(int letterIndex) {
    if (letterIndex < freeLetterCount) return true;
    return _isPremium;
  }

  // ─── Identify user (call after login) ───
  Future<void> identifyUser(String userId) async {
    try {
      await Purchases.logIn(userId);
      await refreshPremiumStatus();
    } catch (e) {
      debugPrint('RevenueCatService: identifyUser error — $e');
    }
  }

  // ─── Logout (call on profile switch) ───
  Future<void> logout() async {
    try {
      await Purchases.logOut();
      _isPremium = false;
      _customerInfo = null;
    } catch (e) {
      debugPrint('RevenueCatService: logout error — $e');
    }
  }
}
