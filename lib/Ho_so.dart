import 'package:flutter/material.dart';
import 'package:ooad_project/Chung/navigation.dart';
import 'package:provider/provider.dart';
import '1.model/Login_Model.dart';

import 'Authenticate/Authenticate_service.dart';
import 'Chung/image_changed.dart';

class HoSo extends StatefulWidget {
  @override
  State<HoSo> createState() => _HoSoState();
}

class _HoSoState extends State<HoSo> {
  String imageUrl =
      'https://firebasestorage.googleapis.com/v0/b/ooad-93565.appspot.com/o/images%2FNoImage.png?alt=media&token=4f1c0833-6deb-4f72-a308-f97dfc1ffa60';
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return SafeArea(
      child: Scaffold(
        appBar: Navigation(
          elevationHeight: 15,
          backgroundOpacity: 0.65,
          tittleText: 'Hồ Sơ',
        ),
        body: Column(
          children: [
            Container(
              height: 211,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff6691FF).withOpacity(0.7),
                    Color(0xff7D8AFF).withOpacity(0.95),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 17,
                    ),
                    height: double.infinity,
                    width: 169,
                    // color: Colors.black,

                    child: ImageChanged(
                      onFileChanged: (imageUrl) {
                        setState(
                          () {
                            this.imageUrl = imageUrl;
                          },
                        );
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 60),
                      Text(
                        'Eiha Jewitt',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          fontSize: 31.3,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: Color(0xff000955).withOpacity(0.3),
                          ),
                          margin: EdgeInsets.only(left: 2),
                          padding: EdgeInsets.fromLTRB(8.5, 6, 14, 6),
                          child: Row(
                            children: [
                              Icon(
                                Icons.power_settings_new_outlined,
                                color: Color(0xff000955),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Đăng xuất',
                                style: TextStyle(
                                  fontFamily: 'HelveticaNeue',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  //color: Color(0xff000955),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          await authService.signOut();
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
