import 'package:flutter/material.dart';
import 'package:ooad_project/1.model/Login_Model.dart';
import 'package:ooad_project/Authenticate/Authenticate_service.dart';
import 'package:ooad_project/Authenticate/Login.dart';
import 'package:provider/provider.dart';

import '../Trang_chu.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user == null ? Login() : TrangChu();
        } else
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
      },
    );
  }
}
