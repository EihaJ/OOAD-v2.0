import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ooad_project/Chung/round_image.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageChanged extends StatefulWidget {
  final Function(String imageUrl) onFileChanged;

  ImageChanged({required this.onFileChanged});

  @override
  _ImageChangedState createState() => _ImageChangedState();
}

class _ImageChangedState extends State<ImageChanged> {
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageUrl == null)
          GestureDetector(
            onTap: () => _selectImage(),
            child: Container(
              height: 176,
              width: 176,
              color: Colors.transparent,
              child: Image(
                image: AssetImage('assets/NoImage.png'),
              ),
            ),
          ),
        if (imageUrl != null)
          GestureDetector(
            onTap: () => _selectImage(),
            child: AppRoundImage.url(
              imageUrl!,
              width: 176,
              height: 176,
            ),
          ),

        // SizedBox(height: 10),
      ],
    );
  }

  Future _selectImage() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.camera_alt,
              ),
              title: Text('Máy ảnh'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(
                  ImageSource.camera,
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.filter,
              ),
              title: Text('Chọn file có sẵn'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(
                  ImageSource.gallery,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 50,
    );
    if (pickedFile == null) {
      return;
    }

    var file = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) {
      return;
    }

    file = await compressImagePath(file.path, 35);

    await _uploadFile(file.path);
    var task = _uploadFile(file.path);
  }

  Future<File> compressImagePath(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result!;
  }

  Future _uploadFile(String path) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now().toIso8601String() + p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();
    print(fileUrl);

    setState(() {
      imageUrl = fileUrl;
    });

    widget.onFileChanged(fileUrl);
  }
}
