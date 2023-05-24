part of 'get_enjoy_cubit.dart';

@freezed
class GetEnjoyState with _$GetEnjoyState {
  const factory GetEnjoyState.initial() = _Initial;
  const factory GetEnjoyState.loading() = _Loading;
  const factory GetEnjoyState.error(String error) = _Error;
  const factory GetEnjoyState.success(List<EnjoyModel> model) = _Success;
  const factory GetEnjoyState.successAdd() = _SuccessAdd;

  const GetEnjoyState._();
  bool get isLoading => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
}
