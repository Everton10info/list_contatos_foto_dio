import 'package:image_picker/image_picker.dart';

class ImagePickerCustomer {
  static Future<XFile?> take() async {
    final ImagePicker picker = ImagePicker();

    return await picker.pickImage(source: ImageSource.camera);
  }
}
