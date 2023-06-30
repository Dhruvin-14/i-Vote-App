import 'package:electionzz/LoginAndSignUp/log_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'VoterAndNominiee/enter_code.dart';
import 'Components/CardWithIconAndText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Head/generate_code.dart';
import 'constants.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selected = "";
  String userName = "";
  String errorMessage = "";

  final _auth = FirebaseAuth.instance;
  FirebaseUser registeredUser;
  String userID;

  Future<bool> _onBackPressed() {
    return Future.value(true);
  }

  // Checking if the User has Registered
  _currentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          registeredUser = user;
          userID = registeredUser.uid;
        });
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } catch (e) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  _showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 550.0,
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.settings,
                          color: Color(0xFF),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "How it Works",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            color: kMainColor,
                            fontFamily: kFontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: kMainColor.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("VOTER", style: kHowItWorksHeading),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "\n▪ Voter is the one who performs his/her duty to vote in the election.\n\n▪ All the voter needs to do is to enter the code given by the head. \n\n▪ A voter can vote when the head starts the election.\n\n▪ The winner will be displayed at the end of the election according to the head's privacy to display the winner.\n",
                      style: kHowItWorksTextStyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: kMainColor.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("NOMINEE \n", style: kHowItWorksHeading),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "▪ Nominee is the one who stands in the election.\n\n▪ All the nominees need to do is enter the code given by the head \n\n▪ When the head starts the election the Voter will be allowed to vote \n\n▪ The winner will be displayed at the end of the election according to the head's privacy to display the winner.\n",
                      style: kHowItWorksTextStyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: kMainColor.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("HEAD \n", style: kHowItWorksHeading),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                        "▪ Head is the one who creates a new room to conduct an election \n\n▪ All the things head needs to do is select the election option and fill up the other requirements\n\n▪ Press the \"Let's Go\" button and then give the election a tag and press the \'Create a Room\" button\n\n▪ You will be promoted to the head's profile all you need to do is give the CODE to all the participants whom you want to join the election\n\n▪ You will have the control over the following :-\n\n▪ Add or Remove the unwanted participants\n▪ Start and Stop the Election\n▪ View Nominiee + Total Votes \n▪ Choose whom you wanna show the result of election\n",
                        style: kHowItWorksTextStyle),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void letsGoButtonOnPressed() {
    setState(() {
      if (userName != "" && selected != "") {
        errorMessage = "";
        if (selected == "VOTER" || selected == "NOMINEE") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EnterCode(
                        userName: userName,
                        selection: selected,
                        userID: userID,
                      )));
        } else if (selected == "ELECTION") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GenerateCode(
                        userName: userName,
                        userID: userID,
                      )));
        }
      } else {
        errorMessage = "";
        if (selected == "") {
          setState(() {
            errorMessage += "Voter OR Nominee OR Election...? \n";
          });
        }
        if (userName == "") {
          setState(() {
            errorMessage += "User Name...?";
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: _onBackPressed,
          child: Column(children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                    child: Hero(
                      tag: "logo",
                      child: Text(
                        "i-Vote",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontFamily: "Dark"),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Icon(
                        Icons.assessment,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Center Box
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Center Container
                      Container(
                        height: 200.0,
                        child: Image(
                          image: AssetImage("assets/6383.jpg"),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // Three Rounded Buttons
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected = "VOTER";
                                  });
                                },
                                child: CardWithIconAndText(
                                  selected: selected,
                                  icon: Icons.touch_app,
                                  text: "VOTER",
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected = "NOMINEE";
                                  });
                                },
                                child: CardWithIconAndText(
                                  selected: selected,
                                  icon: Icons.perm_identity,
                                  // icon: Elusive.up_hand,
                                  text: "NOMINEE",
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected = "ELECTION";
                                  });
                                },
                                child: CardWithIconAndText(
                                  selected: selected,
                                  icon: Icons.star,
                                  text: "ELECTION",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 15.0,
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        height: 56.5,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              userName = value;
                            });
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: kMainColor,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15.0)),
                              hintText: "Username",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 17.0,
                              )),
                        ),
                      ),

                      SizedBox(
                        height: 5.0,
                      ),

                      // Letzz Go Button
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100.0),
                        child: TextButton(
                          onPressed: () {
                            // Checking the Validity of the User Name
                            final validChar = RegExp(r'^[a-zA-Z0-9 ]');
                            if (validChar.hasMatch(userName)) {
                              letsGoButtonOnPressed();
                            } else {
                              setState(() {
                                errorMessage = "Invalid Username";
                              });
                            }
                          },
                          child: Text("Let's Go", style: kButtonTextStyle),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFF3362af)),
                          shape: MaterialStateProperty.all( RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),),),
                      ),
                      Container(
                        child: Text(errorMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kMainColor,
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
