import 'package:flutter/widgets.dart';

extension SafeAsyncContext<T extends StatefulWidget> on State<T> {
  /// Ejecuta un callback solo si el widget sigue montado después de un async gap.
  Future<void> safeAsyncCallback(Future<void> Function() callback) async {
    await Future.delayed(Duration.zero); // opcional, para que sea más explícito
    if (!mounted) return;
    await callback();
  }
}
