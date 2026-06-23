// ignore_for_file: override_on_non_overriding_member

import 'package:ecommerce_one/utils/enum/enum_servicev.dart';

class NetworkState {
  final NetworkStatus status;

  const NetworkState({this.status = NetworkStatus.initial});

  NetworkState copyWith({NetworkStatus? status}) {
    return NetworkState(status: status ?? this.status);
  }
}
