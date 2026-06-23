import 'dart:async';
import 'package:ecommerce_one/controller/network_state.dart';
import 'package:ecommerce_one/utils/enum/enum_servicev.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkCubit extends Cubit<NetworkState> {
  late final InternetConnectionChecker _checker;
  StreamSubscription? _subscription;

  NetworkCubit() : super(const NetworkState()) {
    _init();
  }

  void _init() async {
    _checker = InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 1), // ⬅️ زمن الانتظار
      checkInterval: const Duration(seconds: 1), // ⬅️ كل كم ثانية يفحص
    );
    // Initial check
    final hasInternet = await _checker.hasConnection;
    _emitStatus(hasInternet);

    // Real-time internet listener
    _subscription = _checker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        _emitStatus(true);
      } else {
        _emitStatus(false);
      }
    });
  }

  void _emitStatus(bool isConnected) {
    final newStatus =
        isConnected ? NetworkStatus.connected : NetworkStatus.disconnected;

    if (state.status != newStatus) {
      emit(state.copyWith(status: newStatus));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
