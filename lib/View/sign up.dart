import 'package:final_exam/Provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../services/authServices.dart';
import 'my text field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<TodoProvider>(context);
    var providerFalse = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 26),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0,right: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(name: 'Email', controller: providerTrue.txtEmail),
              SizedBox(height: 20,),
              MyTextField(name: 'Password', controller: providerTrue.txtPass),
              SizedBox(height: 20,),
              TextButton(onPressed: () {

              }, child: Text("you have account ? SignIn"),),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: ()  {
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    image: DecorationImage(fit: BoxFit.cover,image: NetworkImage('https://banner2.cleanpng.com/20181108/vqy/kisspng-youtube-google-logo-google-images-google-account-consulting-crm-the-1-recommended-crm-for-g-suite-1713925083723.webp'),),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () async {
                  await AuthService.authService.createAccountWithEmailAndPassword(providerTrue.txtEmail.text, providerTrue.txtPass.text);
                  Navigator.of(context).pushNamed('/home');
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.black,
                  ),
                  alignment: Alignment.center,
                  child: Text('SignUp',style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}