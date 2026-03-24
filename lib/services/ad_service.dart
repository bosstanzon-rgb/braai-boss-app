import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  AdService._();

  static final AdService instance = AdService._();

  bool _isInitialized = false;
  String? _lastError;

  bool get isInitialized => _isInitialized;
  String? get lastError => _lastError;

  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    try {
      if (kIsWeb) {
        _lastError = 'Ads not supported on web.';
        _isInitialized = false;
        return;
      }

      await MobileAds.instance.initialize();
      _isInitialized = true;
      _lastError = null;
    } catch (error) {
      _lastError = error.toString();
      _isInitialized = false;
    }
  }
}

