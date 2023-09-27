// import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///Function to select image from gallery or camera
  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }
  //функция для загрузки изображений

  _uploadImageToStorege(Uint8List? image) async {
   Reference ref = _storage.ref().child('profileimage').child(_auth.currentUser!.uid);
   UploadTask uploadTask = ref.putData(image!);

   TaskSnapshot snapshot = await uploadTask;
   String dawnloadUrl = await  snapshot.ref.getDownloadURL();
   return dawnloadUrl;
  }

  //Функиция для создание ползавателей

  Future<String> createUser(
      String email, String fullname, String password, Uint8List? image) async {
    String res = 'some erroe';

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

          String downloadUrl = await  _uploadImageToStorege(image);
      await _firestore.collection('buyers').doc(userCredential.user!.uid).set({
        'fullname': fullname,
        'profileImage': downloadUrl,
        'email': email,
        'byerId': userCredential.user!.uid
      });
      res = 'success';
    } catch (e) {
      print('Ошибка при создании пользователя: $e');
      res = e.toString();
    }
    return res;
  }

  //Автаризация ползавателя 
  Future<String> loginUser(String email,String password) async {
    String res ='sum error';

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
