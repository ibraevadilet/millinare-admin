part of 'get_info_cubit.dart';

@freezed
class GetInfoState with _$GetInfoState {
  const factory GetInfoState.initial() = _Initial;
  const factory GetInfoState.loading() = _Loading;
  const factory GetInfoState.error(String error) = _Error;
  const factory GetInfoState.success(List<InfoModel> model) = _Success;
  const factory GetInfoState.successAdd() = _SuccessAdd;

  const GetInfoState._();
  bool get isLoading => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
}
