import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,

      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,

        title: Text('SignUp'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0,left: 12,right: 12),
          child: Column(
            children: [
              SizedBox(height: 200,),
              TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  label: Text('email'),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  label: Text('password'),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextButton(onPressed: () {
                Navigator.of(context).pushNamed('/signIn');
              }, child: Text("You have account ?. Sign In",style: TextStyle(color: Colors.black),),),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () async {
                  Navigator.of(context).pushNamed('/home');
                },
                child: Container(
                  height: 42,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Text('SignUp',style: TextStyle(color: Colors.white,fontSize: 16),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
