import 'package:bloc/bloc.dart';
import 'package:flutter_story_app/data/datasources/auth_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRemoteDatasource _datasource;

  LogoutBloc(this._datasource) : super(LogoutState.initial()) {
    on<_Logout>(_onLogout);
  }

  Future<void> _onLogout(_Logout event, Emitter<LogoutState> emit) async {
    emit(const LogoutState.loading());

    final result = await _datasource.logout();

    result.fold(
      (error) => emit(LogoutState.error(error)),
      (_) => emit(const LogoutState.success()),
    );
  }
}
