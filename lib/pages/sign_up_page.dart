import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Widgets/tex_field_input.dart';
import 'package:instagram_clone/pages/login_page.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/utils/utils.dart';
import '../utils/colors.dart';
import '../resources/auth_methods.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    // print('Starting res');
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'Success!') {
      showSnackBar(res, context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: _height / 20,
              ),
              SizedBox(
                height: _height / 20,
              ),
              Stack(
                children: [
                  if (_image != null)
                    CircleAvatar(
                      radius: _height / 20,
                      backgroundImage: MemoryImage(_image!),
                    )
                  else
                    CircleAvatar(
                      radius: _height / 20,
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                    ),
                  Positioned(
                    bottom: -10,
                    left: _height / 18,
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        selectImage();
                      },
                      icon: const Icon(Icons.add_a_photo, size: 25),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                textEditingController: _usernameController,
                isPass: false,
                hintText: "Enter your username",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                textEditingController: _emailController,
                isPass: false,
                hintText: "Enter your E-mail",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                isPass: true,
                hintText: "Enter your password",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                textEditingController: _bioController,
                isPass: false,
                hintText: "Enter your bio",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  signUpUser();
                },
                child: Container(
                  child: (_isLoading)
                      ? CircularProgressIndicator(
                          color: primaryColor,
                        )
                      : Text('Sign up'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          4,
                        ),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Have an account already? ",
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        child: Text(
                          "Log in",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
              //  login button
              //  signup redirect
            ],
          ),
        ),
      ),
    );
  }
}
