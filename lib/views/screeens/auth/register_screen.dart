import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/auth_controller.dart';
import 'login_screen.dart';



class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Uint8List? _image;
  bool _isLoading = false;
  late String email;
  late String fullname;
  late String password;

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }

  registerUser() async {
    if (_image != null) {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        String res =
            await _authController.createUser(email, fullname, password, _image);
        if (res == 'success') {
          Get.to(LoginScreen());
          Get.snackbar(
              'Регестранция прошло успешно ', 'Новый аккаунт создался ',
              backgroundColor: Colors.pink, colorText: Colors.white,
              icon: Icon(Icons.message));
          setState(() {
            _isLoading = false;
          });    
        } else {
          setState(() {
            _isLoading = false;
          });
          Get.snackbar('Что то пошло не так !', 'Не удался создать акккаун',
              backgroundColor: Colors.red, colorText: Colors.white,
              icon: Icon(Icons.message));
        }
      } else {
        Get.snackbar(
            'Данные валидацию не прошли', 'Пожалуйста попробуйте снова',
            icon: Icon(Icons.message));
      }
    } else {
      Get.snackbar('Изоброжения не выбрано', 'Пожалуйста выберите  изображению',
          margin: EdgeInsets.all(15), icon: Icon(Icons.message));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading?
      Center(child: CircularProgressIndicator(),):
       Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4),
                ),
                SizedBox(
                  height: 15,
                ),
                Stack(
                  children: [
                    _image == null
                        ? CircleAvatar(
                            radius: 64,
                            child: Icon(
                              Icons.person,
                              size: 70,
                            ),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          selectCameraImage();
                        },
                        icon: Icon(
                          Icons.photo,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Пожалюста емайл не должен быть пустым';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Email address",
                      hintText: "Enter your email address",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.pink,
                      ),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    fullname = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Пожалюста имя не должен быть пустым';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Full name",
                      hintText: "Enter your full name",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.pink,
                      ),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Пожалуста парол не должен быть пустым';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.pink,
                      ),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    registerUser();
                    
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.pink),
                    child: Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4),
                      ),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    child: Text('Alrade a have accounte '))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
