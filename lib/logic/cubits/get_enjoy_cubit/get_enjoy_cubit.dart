import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:millioner_admin/core/functions/upload_image_func.dart';
import 'package:millioner_admin/logic/model/enjoy_model.dart';

part 'get_enjoy_state.dart';
part 'get_enjoy_cubit.freezed.dart';

class GetEnjoyCubit extends Cubit<GetEnjoyState> {
  GetEnjoyCubit() : super(const GetEnjoyState.initial());

  getEnjoy(String ref) async {
    emit(const GetEnjoyState.loading());
    CollectionReference firestore = FirebaseFirestore.instance.collection(ref);

    try {
      final enjoyList = await firestore.get();
      List<EnjoyModel> enjoys = [];

      for (var e in enjoyList.docs) {
        enjoys.add(EnjoyModel.fromQuerySnapshot(e));
      }
      emit(GetEnjoyState.success(enjoys));
    } catch (e) {
      emit(GetEnjoyState.error(e.toString()));
    }
  }

  addEnjoy(EnjoyModel model, String ref) async {
    emit(const GetEnjoyState.loading());
    CollectionReference firestore = FirebaseFirestore.instance.collection(ref);
    final imageUrl = await uploadImage(File(model.image));
    try {
      await firestore
          .doc(model.id)
          .set(model.copyWith(image: imageUrl).toJson());
      emit(const GetEnjoyState.successAdd());
    } catch (e) {
      emit(GetEnjoyState.error(e.toString()));
    }
  }

  deleteEnjoy(String id, String ref) async {
    emit(const GetEnjoyState.loading());
    DocumentReference firestore =
        FirebaseFirestore.instance.collection(ref).doc(id);
    try {
      await firestore.delete();
      getEnjoy(ref);
      emit(const GetEnjoyState.successAdd());
    } catch (e) {
      emit(GetEnjoyState.error(e.toString()));
    }
  }
}
