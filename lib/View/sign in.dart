
import 'package:final_exam/Provider/provider.dart';
import 'package:final_exam/View/sign%20up.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../services/authServices.dart';
import 'my text field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<TodoProvider>(context);
    var providerFalse = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 26),),
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp(),));
              }, child: Text("you don't have account ? SignUp"),),
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
                  await AuthService.authService.signInAccountWithEmailAndPassword(providerTrue.txtEmail.text, providerTrue.txtPass.text);
                  providerFalse.clearAll();
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
                  child: Text('SignIn',style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
