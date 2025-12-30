import 'package:bloc/bloc.dart';
import 'package:flutter_story_app/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_story_app/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_profile_event.dart';
part 'get_profile_state.dart';
part 'get_profile_bloc.freezed.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  final AuthRemoteDatasource _datasource;
  GetProfileBloc(this._datasource) : super(GetProfileState.initial()) {
    on<_GetProfile>(_onGetProfile);
  }

  Future<void> _onGetProfile(
    _GetProfile event,
    Emitter<GetProfileState> emit,
  ) async {
    emit(const GetProfileState.loading());

    final result = await _datasource.getProfile();

    result.fold(
      (error) => emit(GetProfileState.error(error)),
      (user) => emit(GetProfileState.success(user)),
    );
  }
}
