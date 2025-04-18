import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AvatarWidget extends StatefulWidget {
  final File? avatar;
  final Function(ImageSource) onImagePicked;

  const AvatarWidget(
      {Key? key, required this.avatar, required this.onImagePicked})
      : super(key: key);

  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.yellow[700],
          backgroundImage:
              widget.avatar != null ? FileImage(widget.avatar!) : null,
          child: widget.avatar == null
              ? Icon(Icons.person, size: 60, color: Colors.white)
              : null,
        ),
        FloatingActionButton(
          mini: true,
          backgroundColor: Colors.green[700],
          onPressed: () => widget.onImagePicked(ImageSource.gallery),
          child: Icon(Icons.camera_alt, color: Colors.white),
        ),
      ],
    );
  }
}
