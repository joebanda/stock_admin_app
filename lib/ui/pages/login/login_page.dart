import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/model/master_user_model.dart';
import '../../../core/router/delegate.dart';
import '../../../core/styles/styles.dart';
import '../../../main.dart';

import '../../../core/dao/master_users_dao.dart';
import 'validators.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [
          Menu(),
          // MediaQuery.of(context).size.width >= 980
          //     ? Menu()
          //     : SizedBox(), // Responsive
          Body()
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            //TODO  _menuItem(title: 'Home'),
            //TODO  _menuItem(title: 'About us'),
              _menuItem(title: 'Contact us'),
             //TODO _menuItem(title: 'Help'),
            ],
          ),
          Row(
            children: [
             //TODO _menuItem(title: 'Sign In', isActive: true),
              //TODO _registerButton()
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuItem({String title = 'Title Menu', isActive = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 75),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            Text(
              '$title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Styles.defaultAppColor : Colors.grey,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            isActive
                ? Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: Styles.defaultAppColor,
                borderRadius: BorderRadius.circular(30),
              ),
            )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _registerButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            spreadRadius: 10,
            blurRadius: 12,
          ),
        ],
      ),
      child: Text(
        'Register',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final routerDelegate = Get.put(MyRouterDelegate());
  GlobalKey<FormState> _loginFormkey = GlobalKey<FormState>();

  bool _passwordVisible;
  bool _loginFailed ;
  bool _authenitcating;

  String _email, _password;

  bool _rememberMe = false;
  @override
  void initState() {
    super.initState();

    _passwordVisible = true;
    _loginFailed = false;
    _authenitcating = false;

    _getSavedLoginDetails();

  }

  _getSavedLoginDetails() async {

  SharedPreferences preferences = await SharedPreferences.getInstance();

    if(preferences.getString('emailKey') !='') {

      authenticateUser(preferences.getString('emailKey'),
          preferences.getString('passwordKey'));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6),
          child: Container(
            width: MediaQuery.of(context).size.width-120,
            child: _formLogin(),
          ),
        )
      ],
    );
  }

  Widget _formLogin() {
    return SafeArea(
      //minimum: EdgeInsets.all(20),
      child: Form(
        key: _loginFormkey,
        child: Column(
          children: [
            TextFormField(
              cursorColor: Colors.black,
              validator: validateEmail,
              autofocus: false,
              onSaved: (value) => _email = value.trim(),
              decoration: InputDecoration(
                hintText: 'Enter email address',
                filled: true,
                suffixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.grey,
                ),
                fillColor: Colors.blueGrey[50],
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.only(left: 30),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey[50]),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey[50]),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 30),
          TextFormField(
            autofocus: false,
            obscureText: _passwordVisible,
            validator: (value) => value.length < 4 ? "should be atleast 4 characters" : null,
            onSaved: (value) => _password = value,
            decoration: InputDecoration(
              hintText: 'Password',
              counterText: 'Forgot password?',
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: (){

                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });

                },

              ),
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

            SizedBox(height: 20.0),
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 250,
              child: CheckboxListTile(
                value: _rememberMe,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Remember me',style: TextStyle(fontSize: 16,color: Colors.grey,),),
                onChanged: (bool value) {
                  setState(() {
                    _rememberMe = !_rememberMe;
                    print('REMEMBER ME: $_rememberMe');
                  });
                },
              ),
            ),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple[100],
                    spreadRadius: 10,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: ElevatedButton(
                child: Container(
                    width: 150,
                    height: 50,
                    child: Center(

                        child: _authenitcating ?  CircularProgressIndicator() : Text("Sign In")

                    )),
               // onPressed: () => routerDelegate.pushPage(name: '/dashboard', arguments: 'hello',),
                onPressed: () {
                  //get user name and password



                  if (_loginFormkey.currentState.validate()) {

                    _loginFormkey.currentState.save();

                    setState(() {
                      _authenitcating = true;
                      _loginFailed = false;
                    });

                    authenticateUser(_email.trim(), _password);

                  } else {
                    print("form is invalid");
                  }


                  } ,

                style: ElevatedButton.styleFrom(
                  primary: Styles.defaultAppColor,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
  Container(
      child: _loginFailed ?  Text('**Invalid email or password', style: TextStyle(color: Colors.red),) :Container()


  ),
            SizedBox(height: 30),
  //TODO login with facebook, google
  /*      Row(children: [
              Expanded(
                child: Divider(
                  color: Colors.grey[300],
                  height: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Or continue with"),
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey[400],
                  height: 50,
                ),
              ),
            ]),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _loginWithButton(image: 'assets/images/google.png'),
                _loginWithButton(image: 'assets/images/github.png', isActive: true),
                _loginWithButton(image: 'assets/images/facebook.png'),
              ],
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _loginWithButton({String image, bool isActive = false}) {
    return Container(
      width: 90,
      height: 70,
      decoration: isActive
          ? BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            spreadRadius: 10,
            blurRadius: 30,
          )
        ],
        borderRadius: BorderRadius.circular(15),
      )
          : BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[400]),
      ),
      child: Center(
          child: Container(
            decoration: isActive
                ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  spreadRadius: 2,
                  blurRadius: 15,
                )
              ],
            )
                : BoxDecoration(),
            child: Image.asset(
              '$image',
              width: 35,
            ),
          )),
    );
  }

  void authenticateUser(String email, String password) {

    // routerDelegate.pushPage(name: '/dashboard', arguments: 'hello',);
    MasterUserModel masterUser = MasterUserModel();



      setState(() {
        _authenitcating = true;
        _loginFailed = false;
      });


      MasterUsersDAO.authenticateUser(email, password).then((value) async {

        if(value.length> 0){
          //user returned after authentication from masteruserdb
          MyApp.authenticatedUser =  masterUser =  value[0];
          //the database of the authenticated user
          MyApp.db_name = value[0].db_name;
          MyApp.id_autheticated_user = value[0].id;
          MyApp.job_role = value[0].job_role;
          //TODO add variable from DB
          MyApp.license_type = 'STOCKTAKE_ONLY';


          //if saver
          if(_rememberMe) {
            SharedPreferences preferences = await SharedPreferences
                .getInstance();
            preferences.setString('emailKey', _email);
            preferences.setString('passwordKey', _password);
          }


          setState(() {
            _loginFailed = false;
            _authenitcating = false;

          });
          routerDelegate.pushPage(name: '/dashboard', arguments: masterUser,);



        }else{

          setState(() {
            _loginFailed = true;
            _authenitcating = false;
          });



        }
      });



  }
}

