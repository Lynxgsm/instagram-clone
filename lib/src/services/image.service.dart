import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

class ImageService {
  static Future<PickedFile> takePhoto() async {
    return await ImagePicker().getImage(source: ImageSource.camera);
  }

  static Future<PickedFile> pickPhoto() async {
    return await ImagePicker().getImage(source: ImageSource.gallery);
  }

  static Future<String> sendFile(PickedFile file) async {
    String path = "";
    final StorageReference storageReference =
        FirebaseStorage().ref().child("avatars/${Path.basename(file.path)}");

    await file.readAsBytes().then((value) async {
      final StorageUploadTask uploadTask = storageReference.putData(value);
      final StreamSubscription<StorageTaskEvent> streamSubscription =
          uploadTask.events.listen((event) {
        print(event.type);
      });

      await uploadTask.onComplete;
      await storageReference.getDownloadURL().then((fileURL) {
        path = fileURL;
      });

      streamSubscription.cancel();
    });

    return path;
  }
}
