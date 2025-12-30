part of 'get_profile_bloc.dart';

@freezed
class GetProfileState with _$GetProfileState {
  const factory GetProfileState.initial() = _Initial;
  const factory GetProfileState.loading() = _Loading;
  const factory GetProfileState.success(UserModel user) = _Success;
  const factory GetProfileState.error(String message) = _Error;
}
