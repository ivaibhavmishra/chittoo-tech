import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'FirstPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';


class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  @override
  final CollectionReference _user = FirebaseFirestore.instance.collection("user detail");

  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _confirmpass = TextEditingController();
  TextEditingController _phoneno = TextEditingController();
  bool hidepass = true;
  bool isEmailcorrect = false;
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
      return null;
    }
  }
  void Validate_phoneno(){
    if (_phoneno.text.length<10){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mobile number must be of 10 characters")));
    }
  }

  void Validate_password(){
    if(_pass.text.length<6){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password must be of six letters")));
    }
  }
  void Confirm_password(){
    if (_confirmpass.text != _pass.text){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password do not match")));
    }
  }

  //void main() {
  //String email = String.parse(_email.text);
  //final bool isValid = EmailValidator.validate(email);

  //print('Email is valid? ' + (isValid ? 'yes' : 'no'));

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

    //bool isEmailcorrect = false;
    String value = _email.text;
    String pass = _pass.text;
    String confirm = _confirmpass.text;
    return Scaffold(bottomNavigationBar: Container(
      child: Padding(padding: const EdgeInsets.all(8),
          child: MaterialButton(onPressed: (){SignInWithGoogle();},color: Colors.redAccent,
            child: Text("Sign up with google"),)

      ),
    ),
        body: Stack( children: [



          Container(
            color: Colors.black.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
              padding: const EdgeInsets.only(top: 100,),
              child: Center(
                  child: Form(
                      key: _formKey,
                      child: ListView(
                          children: [SizedBox(height: 0,),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                  alignment: Alignment.topCenter,
                                  ),
                            ),
                            Padding(padding: const EdgeInsets.fromLTRB(
                                14, 8, 14, 8),
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0),
                                    child: ListTile(

                                      title: TextFormField(
                                        controller: _name,
                                        decoration: InputDecoration(
                                          hintText: "Full Name",
                                          icon: Icon(Icons.person_outline),
                                          border: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value == null) {
                                            return "Fill the name ";
                                          }
                                          return "null";
                                        },
                                      ),

                                    )),
                              ),
                            ),
                            Padding(padding: const EdgeInsets.fromLTRB(
                                14, 8, 14, 8),
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0),
                                    child: ListTile(

                                      title: TextFormField(
                                        controller: _phoneno,
                                        decoration: InputDecoration(
                                          hintText: "Mobile number",
                                          icon: Icon(Icons.phone),
                                          border: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value == null) {
                                            return "Fill the mobile no. ";
                                          }
                                          return "null";
                                        },
                                      ),

                                    )),
                              ),
                            ),

                            Padding(padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 26.0),
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

                            Padding(padding: const EdgeInsets.fromLTRB(
                                14, 8, 14, 8),
                              child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.4),
                                  elevation: 0,
                                  child: Padding(padding: const EdgeInsets
                                      .only(left: 12),
                                    child: ListTile(
                                      title: TextFormField(
                                        controller: _pass,
                                        obscureText: hidepass,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password (atleast 6 character)",

                                          icon: Icon(Icons.lock_outline),
                                        ),

                                      ),
                                      trailing: IconButton(onPressed: (){
                                        setState(() {
                                          hidepass = !hidepass;
                                        });
                                      }, icon:Icon(Icons.remove_red_eye)),

                                    ),)

                              ),),
                            Padding(padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: Padding(padding: const EdgeInsets.only(left: 12.0),
                                    child:ListTile(
                                      title: TextFormField(
                                        controller: _confirmpass,
                                        obscureText: hidepass,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Confirm Password",
                                          icon: Icon(Icons.lock_outline),
                                        ),
                                        validator: (value){
                                          if(value== null){
                                            return"The password field cannot be empty";
                                          }else if(value.length <6){
                                            return "Password must be atleast 6 character long";
                                          }else if (_pass.text != value){
                                            return("Password is different from above");
                                          }
                                        },
                                      ),
                                      trailing: IconButton(onPressed: (){
                                        setState(() {
                                          hidepass = !hidepass;
                                        });
                                      }, icon: Icon(Icons.remove_red_eye),
                                      ),
                                    )),
                              ),),


                            Padding(padding: const EdgeInsets.fromLTRB(
                              14, 8, 14, 8,),


                                child: Material(
                                    borderRadius: BorderRadius.circular(
                                        20),
                                    color: Colors.blueAccent,
                                    elevation: 0,
                                    child: MaterialButton(
                                      onPressed: () async {Validate_phoneno();
                                      Validate_email();Validate_password();Confirm_password();
                                      print("pressed");
                                      FirebaseAuth.instance.createUserWithEmailAndPassword
                                        (email: _email.text,
                                          password: _pass.text).then((
                                          value)
                                      {_user.add({"Name": _name.text, "Email": _email.text, "Mobile Number" : _phoneno.text});
                                      print("Sucessfully registered");
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => FirstPage()));
                                      }).onError(((error, stackTrace) {
                                        print(error);ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Already an account exist with this email id")));
                                      }));
                                      }, minWidth: MediaQuery.of(context).size.width, child: Text("Sign up"),))),

                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(padding: EdgeInsets.fromLTRB(120, 8,20, 80),

                                        child: InkWell(
                                          onTap: (){Navigator.pop(context);},
                                          child:Text(
                                              "I already have an account.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ),
                                      ),
                                    ]))])

                  )

              )

          )]));
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

class DatabaseMethod{
  Future addUserInfoToDB(String userId, Map<String , dynamic> userInfoMap){
    return FirebaseFirestore.instance.collection("users").doc(userId).set(userInfoMap);
  }
  Future<DocumentSnapshot> getUserFromDB(String userId) async{
    return FirebaseFirestore.instance.collection("users").doc(userId).get();
  }
}