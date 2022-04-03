
import 'package:apiproject/shared/components/components.dart';
import 'package:flutter/material.dart';




class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 late var emailcontroller = TextEditingController();

 late var passwordcontroller = TextEditingController();

var formkey = GlobalKey<FormState>();
late bool isSecure =true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  defulttextformfeild(
                      controller: emailcontroller,
                      type: TextInputType.emailAddress,
                      label: 'E-mail Address',
                      prefix: Icons.email,
                      validate:(String? p0) {
                        if(p0!.isEmpty){
                          return 'enter your email addres';
                        }
                        return null;
                      },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  defulttextformfeild(
                    controller: passwordcontroller,
                    type: TextInputType.phone,
                    label: 'Password',
                    prefix: Icons.lock,
                    isSecure: isSecure,
                    suffix:isSecure? Icons.visibility_off : Icons.visibility,
                    suffixPresed: (){
                      setState(() {
                        isSecure=!isSecure;
                      });
                    },
                    validate:(String? p0) {
                      if(p0!.isEmpty){
                        return 'the password is too short';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 18,
                  ),
                  button(
                      function: () {
                        if(formkey.currentState!.validate()){
                          print(emailcontroller.text);
                          print(passwordcontroller.text);
                        }
                      },
                      text: "LOGIN"),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'don\'t have an account ?',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                            onPressed: () {}, child: const Text('Register Now')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
