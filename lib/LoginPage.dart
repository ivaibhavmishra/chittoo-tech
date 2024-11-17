import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Signup.dart';
import 'FirstPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  //bool isEmpty=0 as bool;
  final _formKey = GlobalKey<FormState>();
  final _key =  GlobalKey<ScaffoldState>();


  void initState(){

    Firebase.initializeApp();
    super.initState();
  }
  void Validate_email(){
    final bool isValid =  EmailValidator.validate(_email.text.trim());
    if(!isValid){
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("your email is wrong.")));
    }else{
      return null;//ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("")));
    }
  }
  void Validate_password(){
    if(_pass.text.length<6){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password must be of six letters")));
    }
  }
  // final GoogleSignIn googleSignIn = new GoogleSignIn();
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // late SharedPreferences preferences;
  // bool loading = false;
  // bool isLogedin = false;

  // void initState() {
  //   super.initState();
  //   isSignedIn();
  // }
  //
  // void isSignedIn() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   preferences = await SharedPreferences.getInstance();
  //   isLogedin = await googleSignIn.isSignedIn();
  //   if (isLogedin == true) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => Firstpage()));
  //   }
  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  @override
  Widget build(BuildContext context) {

    MediaQuery.of(context).viewInsets.bottom;

    String value = _email.text;
    String pass = _pass.text;
    return Scaffold(
        body:Stack(
          children: [



            Container(
              color: Colors.black.withOpacity(0.4),
              width: double.infinity,
              height: double.infinity,
            ),



            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      SizedBox(height: 0,),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                            alignment: Alignment.topCenter,
                            ),
                      ),
                      Padding(padding: const EdgeInsets.all(8),
                          child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.redAccent,
                              elevation: 0,
                              child: MaterialButton(
                                onPressed: () async {print("pressed");Logout();
                                }, child: Text("Want to Logout existing account >>>",style: TextStyle(color: Colors.white),),)

                          )),
                      Padding(padding: const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.3),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              controller: _email,
                              decoration: InputDecoration(
                                hintText: "Email",
                                icon: Icon(Icons.alternate_email),
                                border: InputBorder.none,
                              ),



                            ),
                          ),
                        ),
                      ),


                      Padding(padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.3),
                          elevation: 0,
                          child: Padding(padding: const EdgeInsets.only(left: 12),
                            child: TextFormField(
                              controller: _pass,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                icon: Icon(Icons.lock_outline),
                              ),

                            ),
                          ),

                        ),),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(padding: EdgeInsets.all(8),

                              child: InkWell(
                                onTap: (){},
                                child:Text(
                                    "Forgot Password",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                            ),
                            // Padding(padding: const EdgeInsets.all(8),
                            // child: InkWell(
                            //   onTap: (){
                            //    // Navigator.push(context, MaterialPageRoute(builder: context=>SignUp()));
                            //   },
                            //   child: Text("Create an account",
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(color: Colors.black),),
                            // ),),
                          ],
                        ),
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                          child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blueAccent,
                              elevation: 0,
                              child: MaterialButton(
                                onPressed: () async { Validate_email();print("pressed");
                                FirebaseAuth.instance.signInWithEmailAndPassword
                                  (email: _email.text, password: _pass.text).then((
                                    value){
                                  print("looged in"); Navigator.push(context, MaterialPageRoute(builder: (context)=> FirstPage()));
                                }).onError(((error, stackTrace) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account not registerd")));
                                }));Validate_password();
                                } , child: Text("Login", style: TextStyle(color: Colors.white),),)

                          )),

                      Padding(padding: const EdgeInsets.all(8),
                          child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.redAccent,
                              elevation: 0,
                              child: MaterialButton(
                                onPressed: () async {print("pressed");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> Sign_up()));
                                }, child: Text("Create an account",style: TextStyle(color: Colors.white),),)

                          )),



                    ],
                  ),

                ),
              ),
            ),



          ],),

        bottomNavigationBar:
        Container(
            child: Padding(padding: const EdgeInsets.all(8),
                child: MaterialButton(onPressed: (){SignInWithGoogle();},color: Colors.redAccent,
                  child: Text("Sign in / Sign up with google"),)))

    );

  }
  SignInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FirstPage(),
        ));
    // ignore: use_build_context_synchronously

  }
  Logout() async{
    try{await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    }
    on FirebaseAuthException catch(e){
      throw e.message!;
    } on FormatException catch(e) {
      throw e.message!;
    } catch(e){
      throw("unable to logout, try again latter");
    }


  }

}

// Column(
// children: <Widget>[ SizedBox(height :100,),
// SizedBox(height: 50),
// TextField(controller: _email, decoration: InputDecoration(hintText: "Enter your email",
// filled: true),),
// SizedBox(height: 5),
// TextField(controller: _pass, decoration: InputDecoration(hintText: "Enter your Password",
// filled: true ),obscureText: true),
// ]))
