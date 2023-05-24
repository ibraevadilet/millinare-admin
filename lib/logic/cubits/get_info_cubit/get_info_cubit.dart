import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:millioner_admin/core/functions/upload_image_func.dart';
import 'package:millioner_admin/logic/model/info_model.dart';

part 'get_info_state.dart';
part 'get_info_cubit.freezed.dart';

class GetInfoCubit extends Cubit<GetInfoState> {
  GetInfoCubit() : super(const GetInfoState.initial());

  getInfo() async {
    emit(const GetInfoState.loading());
    CollectionReference firestore =
        FirebaseFirestore.instance.collection('info');

    try {
      final infoList = await firestore.get();
      List<InfoModel> infos = [];

      for (var e in infoList.docs) {
        infos.add(InfoModel.fromQuerySnapshot(e));
      }
      emit(GetInfoState.success(infos));
    } catch (e) {
      emit(GetInfoState.error(e.toString()));
    }
  }

  addInfo(InfoModel model) async {
    emit(const GetInfoState.loading());
    CollectionReference firestore =
        FirebaseFirestore.instance.collection('info');
    final imageUrl = await uploadImage(File(model.image));
    try {
      await firestore
          .doc(model.id)
          .set(model.copyWith(image: imageUrl).toJson());
      emit(const GetInfoState.successAdd());
    } catch (e) {
      emit(GetInfoState.error(e.toString()));
    }
  }

  deleteInfo(String id) async {
    emit(const GetInfoState.loading());
    DocumentReference firestore =
        FirebaseFirestore.instance.collection('info').doc(id);
    try {
      await firestore.delete();
      getInfo();
      emit(const GetInfoState.successAdd());
    } catch (e) {
      emit(GetInfoState.error(e.toString()));
    }
  }
}
