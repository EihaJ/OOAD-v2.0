import 'package:ooad_project/1.model/Luong_Model.dart';

import '../Chung/navigation.dart';
import '../Chung/drawer.dart';
import '../Chung/bottom_navigation.dart';
import '../Chung/floating_action_button.dart';
import '../Chung/search_widget.dart';
import '../database/database.dart';
import 'dart:async';

import '../1.model/Luong_Model.dart';
import '../1.model/Don_Vi_Model.dart';
import '../1.model/Nhan_Vien_Model.dart';
import '../Nhan_vien/Nhan_vien_Detail.dart';

import 'package:flutter/material.dart';

class LuongDonVi extends StatefulWidget {
  final DonViItem donVi;
  LuongDonVi({required this.donVi});
  @override
  _LuongDonViState createState() => _LuongDonViState();
}

class _LuongDonViState extends State<LuongDonVi> {
  List<NhanVienItem> nhanVienItems = [];
  List<NgachItem> ngachItems = [];
  List<List<HeSoLuongItem>> heSoLuongItems = [];
  List<ThongTinTheoNamItem> thongTinTheoNamItems = [];

  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  Future init() async {
    final nhanVienItems = await GetNhanVienCollection.getNhanVienItemInDonVi(
        query, widget.donVi.maDV!);

    final ngachItems = await GetLuongCollection.getNgachItem();

    var heSoLuongItems =
        List<List<HeSoLuongItem>>.generate(ngachItems.length, (_) => []);

    for (int i = 0; i < ngachItems.length; i++) {
      heSoLuongItems[i] =
          await GetLuongCollection.getHeSoLuongItem(ngachItems[i].id!);
    }

    final thongTinTheoNamItems =
        await GetLuongCollection.getThongTinTheoNamItem();

    setState(() {
      this.nhanVienItems = nhanVienItems;
      this.ngachItems = ngachItems;
      this.heSoLuongItems = heSoLuongItems;
      this.thongTinTheoNamItems = thongTinTheoNamItems;
    });
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 100),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navigation(
          tittleText: 'Quản lý Lương',
          backgroundOpacity: 0,
          elevationHeight: 0,
        ),
        drawer: CustomDrawer(),
        floatingActionButton: CustomFloatingActionButton(flag: 6),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        body: Column(
          children: [
            Image(
              image: AssetImage('assets/Luong.png'),
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment(1, 0),
              child: customSearch(),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: nhanVienItems.length,
                itemBuilder: (context, index) {
                  if (index == 0)
                    return Column(
                      children: [
                        Container(
                          width: 382,
                          height: 46,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff558FFF),
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 243,
                                alignment: Alignment.center,
                                child: Text(
                                  'Tên Nhân Viên',
                                  style: TextStyle(
                                    fontFamily: 'HelveticalNeue',
                                    fontSize: 22.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.blueAccent[200],
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Lương',
                                  style: TextStyle(
                                    fontFamily: 'HelveticalNeue',
                                    fontSize: 22.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                width: 136,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff558FFF),
                              ),
                            ),
                            width: 382,
                            height: 117,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: 243,
                                  alignment: Alignment.center,
                                  child: Text(
                                    nhanVienItems[index].tenNV!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  color: Colors.blueAccent[200],
                                ),
                                for (int i = 0; i < ngachItems.length; i++)
                                  if (ngachItems[i].maNgach ==
                                      nhanVienItems[index].maNgach)
                                    for (int j = 0;
                                        j < heSoLuongItems[i].length;
                                        j++)
                                      if (((DateTime.now().year -
                                                  nhanVienItems[i]
                                                      .ngayVaoTruong!
                                                      .year) ~/
                                              3) ==
                                          heSoLuongItems[i][j].bac)
                                        for (int z = 0;
                                            z < thongTinTheoNamItems.length;
                                            z++)
                                          if (thongTinTheoNamItems[z].nam ==
                                              DateTime.now().year)

                                            //TODO: voi heSoLuongItems dung thi tao 1 Container chua Text so luong bang cach tinh trong do
                                            Container(
                                              width: 136,
                                              alignment: Alignment.center,
                                              child: Text(
                                                ((heSoLuongItems[i][j].heSoBac!
                                                            // + he so phu
                                                            *
                                                            thongTinTheoNamItems[
                                                                    z]
                                                                .luongToiThieu!) -
                                                        (thongTinTheoNamItems[
                                                                        z]
                                                                    .bHTN! +
                                                                thongTinTheoNamItems[
                                                                        z]
                                                                    .bHXH! +
                                                                thongTinTheoNamItems[
                                                                        z]
                                                                    .bHYT!) *
                                                            (heSoLuongItems[i]
                                                                        [j]
                                                                    .heSoBac! *
                                                                thongTinTheoNamItems[
                                                                        z]
                                                                    .luongToiThieu!)
                                                    //+ luong phu cap
                                                    )
                                                    .toString(),

                                                //TODO: get maNgach tu nhan vien de tinh

                                                style: TextStyle(
                                                  fontFamily: 'HelveticaNeue',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NhanVienDetail(
                                    nhanVien: nhanVienItems[index]),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  else if (index == nhanVienItems.length - 1)
                    return GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff558FFF),
                              ),
                            ),
                            width: 382,
                            height: 117,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: 243,
                                  alignment: Alignment.center,
                                  child: Text(
                                    nhanVienItems[index].tenNV!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  color: Colors.blueAccent[200],
                                ),
                                Container(
                                  width: 136,
                                  alignment: Alignment.center,
                                  child: Text(
                                    nhanVienItems[index].maNV!,
                                    style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NhanVienDetail(nhanVien: nhanVienItems[index]),
                          ),
                        );
                      },
                    );
                  else
                    return GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff558FFF),
                              ),
                            ),
                            width: 382,
                            height: 117,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: 243,
                                  alignment: Alignment.center,
                                  child: Text(
                                    nhanVienItems[index].tenNV!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  color: Colors.blueAccent[200],
                                ),
                                Container(
                                  width: 136,
                                  alignment: Alignment.center,
                                  child: Text(
                                    nhanVienItems[index].maNV!,
                                    style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NhanVienDetail(nhanVien: nhanVienItems[index]),
                          ),
                        );
                      },
                    );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }

  Widget customSearch() => SearchWidget(
        text: query,
        onChanged: searchItem,
      );
  Future searchItem(String query) async => debounce(() async {
        final nhanVienItems =
            await GetNhanVienCollection.getNhanVienItem(query);

        setState(() {
          this.query = query;
          this.nhanVienItems = nhanVienItems;
        });
      });
}
