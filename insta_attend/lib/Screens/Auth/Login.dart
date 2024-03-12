import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:insta_attend/Database%20Services/AuthService.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;
  late TextEditingController passwordController;


  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;


    return Container(
      decoration: BoxDecoration(
        image: screenWidth>900 ?
        DecorationImage(image: AssetImage("assets/images/Web background.png"),fit: BoxFit.cover)
            : DecorationImage(image: AssetImage("assets/images/Mob Background.png"),fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: 500,
            width: screenWidth>900 ? 500 : 300,
            child: Center(
              child: BlurryContainer(
                color: Colors.grey.shade100,
                blur: 12,
                  borderRadius: BorderRadius.circular(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset("assets/images/img.png", width: 150,),
                      SizedBox(
                        height: 20,
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText('Login using your admin credentials !',textStyle: TextStyle(fontSize: 23, fontFamily: "Typewriter"), speed: Duration(milliseconds: 80)),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                            ),
                            hintText: "Enter Email",
                            labelText: "Enter Email"
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70,
                            vertical: 10
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: "Enter Password",
                              labelText: "Enter Password"
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      AnimatedButton(
                        borderColor: Color(0xFFfda085),
                        backgroundColor: Colors.transparent,
                        selectedTextColor: Colors.white,
                        borderRadius: 15,
                        selectedGradientColor: LinearGradient(colors: [
                          Color(0xFFf6d365),
                          Color(0xFFfda085)
                        ]),
                        width: 200,
                          animatedOn: AnimatedOn.onHover,
                          transitionType: TransitionType.TOP_CENTER_ROUNDER,
                          text: "Login",
                          textStyle: TextStyle(
                            color: Color(0xFFfda085)
                          ),
                          onPress: (){
                        AuthService.loginUser(emailController.text, passwordController.text, context);
                        emailController.clear();
                        passwordController.clear();
                      })
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
