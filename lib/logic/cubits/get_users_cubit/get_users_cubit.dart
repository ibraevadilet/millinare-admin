import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:millioner_admin/logic/model/user_model.dart';

part 'get_users_state.dart';
part 'get_users_cubit.freezed.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  GetUsersCubit() : super(const GetUsersState.loading()) {
    getUsers();
  }

  getUsers() async {
    CollectionReference firestore =
        FirebaseFirestore.instance.collection('users');

    try {
      final usersList = await firestore.get();
      List<UserModel> users = [];

      for (var e in usersList.docs) {
        users.add(UserModel.fromQuerySnapshot(e));
      }
      emit(GetUsersState.success(users));
    } catch (e) {
      emit(GetUsersState.error(e.toString()));
    }
  }

  deleteUser(String id) async {
    DocumentReference firestore =
        FirebaseFirestore.instance.collection('users').doc(id);
    try {
      await firestore.delete();
      getUsers();
    } catch (e) {
      emit(GetUsersState.error(e.toString()));
    }
  }
}
