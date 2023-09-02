import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoggerProvider extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('''
================================================================
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
================================================================
''');
  }
}
