
import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  AuthService._();
  static AuthService authService = AuthService._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> createAccountWithEmailAndPassword(String email,String password)
  async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<String> signInAccountWithEmailAndPassword(String email,String password)
  async {
    try
    {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    }
    catch(e)
    {
      return e.toString();
    }
  }

  Future<void> signOut()
  async {
    _firebaseAuth.signOut();
  }
  User? getCurrentUser()
  {
    User? user = _firebaseAuth.currentUser;

    if(user!=null)
    {
      print("email : ${user.email}");
    }
    return user;
  }
}