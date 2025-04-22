// connectivity_bloc.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@Injectable()
class ConnectivityCubit extends Cubit<ConnectivityState> {
  late StreamSubscription<InternetConnectionStatus> _subscription;
  final InternetConnectionChecker _checker;

  ConnectivityCubit({required InternetConnectionChecker checker})
      : _checker = checker,
        super(ConnectivityLoading()) {
    _init();
  }

  Future<void> _init() async {
    // Emit initial state
    final initialStatus = await _checker.hasConnection;
    emit(initialStatus ? ConnectivityConnected() : ConnectivityDisconnected());

    // Listen for changes
    _subscription = _checker.onStatusChange.listen((status) {
      emit(status == InternetConnectionStatus.connected
          ? ConnectivityConnected()
          : ConnectivityDisconnected());
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}

// connectivity_state.dart

abstract class ConnectivityState {}

class ConnectivityLoading extends ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {}

class ConnectivityDisconnected extends ConnectivityState {}
