import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ooad_project/Authenticate/Authenticate_service.dart';
import 'package:provider/provider.dart';

import 'Authenticate/Authenticate_service.dart';
import 'Authenticate/Login.dart';
import 'Authenticate/Wrapper.dart';

import 'Don_vi/Don_vi.dart';

import 'Chuc_vu/Chuc_vu.dart';

import 'Nhan_vien/Nhan_vien.dart';

import 'Doan_the/Doan_the.dart';

import 'Luong/Luong.dart';

import 'Trinh_do/Trinh_do.dart';

import 'Than_nhan/Don_vi_nhan_vien_than_nhan.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xff005BC7),
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        // home: DoanThe(),
        // // in TrangChu(),
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/DonVi': (context) => DonVi(),
          '/DoanThe': (context) => DoanThe(),
          '/ChucVu': (context) => ChucVu(),
          '/NhanVien': (context) => NhanVien(),
          '/TrinhDo': (context) => TrinhDo(),
          '/Luong': (context) => Luong(),
          '/ThanNhan': (context) => DonViThanNhan(),
        },
      ),
    );
  }
}
