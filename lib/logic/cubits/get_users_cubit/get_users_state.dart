part of 'get_users_cubit.dart';

@freezed
class GetUsersState with _$GetUsersState {
  const factory GetUsersState.loading() = _Loading;
  const factory GetUsersState.error(String error) = _Error;
  const factory GetUsersState.success(List<UserModel> model) = _Success;
}
