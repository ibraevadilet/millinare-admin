import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:millioner_admin/logic/cubits/get_enjoy_cubit/get_enjoy_cubit.dart';
import 'package:millioner_admin/logic/model/enjoy_model.dart';
import 'package:millioner_admin/widgets/custom_app_bar.dart';
import 'package:millioner_admin/widgets/custom_button.dart';
import 'package:millioner_admin/widgets/custom_text_field.dart';
import 'package:millioner_admin/widgets/spaces.dart';
import 'package:millioner_admin/widgets/styled_toasts.dart';
import 'package:shimmer/shimmer.dart';

class EnjoyRedactorScreen extends StatefulWidget {
  const EnjoyRedactorScreen({
    super.key,
    required this.model,
    required this.ref,
  });
  final EnjoyModel model;
  final String ref;

  @override
  State<EnjoyRedactorScreen> createState() => _EnjoyRedactorScreenState();
}

class _EnjoyRedactorScreenState extends State<EnjoyRedactorScreen> {
  late final titleController = TextEditingController(text: widget.model.title);
  late final descriptionController =
      TextEditingController(text: widget.model.description);
  late final urlController = TextEditingController(text: widget.model.url);

  String? image;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetEnjoyCubit(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Редактирование'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Flexible(
                  child: image != null
                      ? Stack(
                          children: [
                            SizedBox(
                              width: getWidth(context),
                              child: Image.file(
                                File(image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 20,
                              top: 20,
                              child: InkWell(
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  XFile? imageFrom = await picker.pickImage(
                                    source: ImageSource.gallery,
                                    preferredCameraDevice: CameraDevice.rear,
                                  );
                                  if (imageFrom != null) {
                                    image = imageFrom.path;
                                    setState(() {});
                                  }
                                },
                                child: const CircleAvatar(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: widget.model.image,
                              placeholder: (_, url) {
                                return SizedBox(
                                  width: getWidth(context),
                                  height: 200,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(0.4),
                                    highlightColor: Colors.white,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              imageBuilder: (_, imageProvider) {
                                return CachedNetworkImage(
                                  imageUrl: widget.model.image,
                                  width: getWidth(context),
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                            Positioned(
                              right: 20,
                              top: 20,
                              child: InkWell(
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  XFile? imageFrom = await picker.pickImage(
                                    source: ImageSource.gallery,
                                    preferredCameraDevice: CameraDevice.rear,
                                  );
                                  if (imageFrom != null) {
                                    image = imageFrom.path;
                                    setState(() {});
                                  }
                                },
                                child: const CircleAvatar(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                ),
                const SizedBox(height: 12),
                const Text('Название:'),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: '',
                  controller: titleController,
                ),
                const SizedBox(height: 12),
                const Text('Описание:'),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: '',
                  controller: descriptionController,
                ),
                const SizedBox(height: 12),
                const Text('Ссылка:'),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: '',
                  controller: urlController,
                ),
                const Spacer(),
                BlocConsumer<GetEnjoyCubit, GetEnjoyState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      successAdd: () {
                        showSuccessSnackBar('Успншно обновлен!');
                        Navigator.pop(context);
                      },
                    );
                  },
                  builder: (context, state) {
                    return CustomButton(
                      isLoading: state.isLoading,
                      text: 'Обновить',
                      onPressed: () async {
                        await context.read<GetEnjoyCubit>().updateEnjoy(
                              EnjoyModel(
                                description: descriptionController.text,
                                title: titleController.text,
                                image: image!,
                                id: widget.model.id,
                                url: urlController.text,
                              ),
                              widget.model.id,
                              widget.ref,
                            );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
