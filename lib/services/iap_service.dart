import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IAPService {
  static const String _productId = 'unlock_pro';
  final InAppPurchase _iap = InAppPurchase.instance;
  final ValueNotifier<bool> isProNotifier = ValueNotifier<bool>(false);
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  bool get isPro => isProNotifier.value;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    isProNotifier.value = prefs.getBool('isPro') ?? false;

    final bool isAvailable = await _iap.isAvailable();
    if (!isAvailable) {
      print('In-App Purchase is not available');
      return;
    }

    final productDetailsResponse = await _iap.queryProductDetails({_productId});
    if (productDetailsResponse.productDetails.isEmpty) {
      print('No products found');
      return;
    }

    final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;
    _subscription = purchaseUpdated.listen(
          (purchaseDetailsList) {
        _handlePurchaseUpdates(purchaseDetailsList);
      },
      onDone: () {
        _subscription?.cancel();
      },
      onError: (error) {
        print('Purchase stream error: $error');
      },
    );
  }

  Future<void> purchasePro() async {
    final productDetailsResponse = await _iap.queryProductDetails({_productId});
    if (productDetailsResponse.productDetails.isEmpty) {
      print('Product not found');
      return;
    }

    final productDetail = productDetailsResponse.productDetails.first;
    final purchaseParam = PurchaseParam(productDetails: productDetail);
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.productID == _productId) {
        if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isPro', true);
          isProNotifier.value = true;
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await _iap.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  void dispose() {
    _subscription?.cancel();
    isProNotifier.dispose();
  }
}