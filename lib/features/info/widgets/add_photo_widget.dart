import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:millioner_admin/helpers/app_colors.dart';

class AddPhotoWidget extends StatefulWidget {
  const AddPhotoWidget({
    super.key,
    required this.onSelected,
  });
  final Function(String? image) onSelected;

  @override
  State<AddPhotoWidget> createState() => _AddPhotoWidgetState();
}

class _AddPhotoWidgetState extends State<AddPhotoWidget> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.color38B6FFBLue,
          ),
          child: InkWell(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              XFile? imageFrom = await picker.pickImage(
                source: ImageSource.gallery,
                preferredCameraDevice: CameraDevice.rear,
              );
              if (imageFrom != null) {
                image = File(imageFrom.path);
                setState(() {});
                widget.onSelected(image!.path);
              }
            },
            child: image == null
                ? const Icon(
                    Icons.add,
                    size: 50,
                    color: AppColors.white,
                  )
                : Image.file(
                    image!,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        image == null
            ? const SizedBox()
            : Positioned(
                top: 5,
                right: 5,
                child: InkWell(
                  onTap: () {
                    image = null;
                    setState(() {});
                    widget.onSelected(null);
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.white.withOpacity(0.5),
                    child: const Icon(
                      Icons.delete,
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
