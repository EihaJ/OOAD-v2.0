import 'package:flutter/material.dart';
import 'package:ooad_project/Authenticate/Authenticate_service.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Loading.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  bool isPasswordVisible = true;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xffEBF0F1),
              appBar: AppBar(
                backgroundColor: Colors.white.withOpacity(0),
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/Logo.png'),
                      width: 200,
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: buildEmail(),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: buildPassword(),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                        child: Container(
                            //color: Colors.black,
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 124,
                            ),
                            child: Text('????ng Nh???p')),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(
                              0xff224E99,
                            ),
                          ),
                          elevation: MaterialStateProperty.all(2),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          setState(() => loading = true);
                          await authService
                              .signInWithEmailAndPassword(
                                  emailController.text, passwordController.text)
                              .then(
                                (uid) => {
                                  Fluttertoast.showToast(
                                      msg: '????ng Nh???p Th??nh C??ng'),
                                },
                              )
                              .catchError(
                            (e) {
                              setState(() => loading = false);
                              Fluttertoast.showToast(
                                  msg: '????ng Nh???p Kh??ng Th??nh C??ng');
                            },
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
  }

  Widget buildEmail() => TextFormField(
        controller: emailController,
        validator: (value) {
          if (value!.isEmpty) {
            return ('Xin h??y nh???p email c???a b???n');
          }
          if (!RegExp('^[a-zA-z0-9+_.-]+@[a-zA-z0-9.-]+[a-z]')
              .hasMatch(value)) {
            return ('Email kh??ng h???p chu???n');
          }
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff224E99),
            ),
          ),
          prefixIcon: Icon(
            Icons.mail_sharp,
            color: Color(0xff224E99),
          ),
          labelText: 'Email',
          suffixIcon: emailController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => emailController.clear(),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        // autofocus: true,
      );

  Widget buildPassword() => TextField(
        controller: passwordController,
        onChanged: (value) => setState(() => this.passwordController),
        onSubmitted: (value) => setState(() => this.passwordController),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff224E99),
            ),
          ),
          focusColor: Color(0xff224E99),
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Color(0xff224E99),
          ),
          labelText: 'Password',
          suffixIcon: IconButton(
            color: Color(0xff224E99),
            icon: isPasswordVisible
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
            onPressed: () =>
                setState(() => isPasswordVisible = !isPasswordVisible),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        obscureText: isPasswordVisible,
      );
}
