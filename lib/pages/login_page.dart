import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/pages/sign_up_page.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import '../Widgets/tex_field_input.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  void loginUser()async {
    setState((){
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);
    setState((){
      isLoading = false;
    });
    if(res == 'Success!'){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
    else{
      showSnackBar(res, context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize? EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width)/3): EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          // height: MediaQuery.of(context).size.height/2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Flexible(child: Container(), flex: 2,),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 100,
              ),
              TextFieldInput(
                textEditingController: _emailController,
                isPass: false,
                hintText: "Enter your E-mail",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                isPass: true,
                hintText: "Enter your password",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () => loginUser(),
                child: Container(
                  child: (isLoading)?Center(child: CircularProgressIndicator(color: primaryColor,),):Text('Log in'),
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
                        "Don't have an account? ",
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        child: Text(
                          "Sign up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(),),);
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
