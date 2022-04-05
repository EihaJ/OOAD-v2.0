import 'package:cloud_firestore/cloud_firestore.dart';
import '../1.model/Don_Vi_Model.dart';
import '../1.model/Chuc_Vu_Model.dart';
import '../1.model/Chuc_Vu_Detail_Model.dart';
import '../1.model/Doan_The_Model.dart';
import '../1.model/Doan_The_Detail_Model.dart';
import '../1.model/Luong_Model.dart';
import '../1.model/Trinh_Do_Model.dart';
import '../1.model/Trinh_Do_Detail_Model.dart';
import '../1.model/Than_Nhan_Model.dart';
import '../1.model/Khen_Thuong_Model.dart';

import '../1.model/Nhan_Vien_Model.dart';

class GetDonViCollection {
  static Future<List<DonViItem>> getDonViItem(String query) async {
    final response =
        await FirebaseFirestore.instance.collection('donViCollection').get();

    return response.docs
        .map(
      (e) => DonViItem.fromJson(e.data()),
    )
        .where((item) {
      final maDVLower = item.maDV!.toLowerCase();
      final tenDVLower = item.tenDV!.toLowerCase();
      final searchLower = query.toLowerCase();

      return maDVLower.contains(searchLower) ||
          tenDVLower.contains(searchLower);
    }).toList();
  }
}

class GetChucVuCollection {
  static Future<List<ChucVuItem>> getChucVuItem(String query) async {
    final response =
        await FirebaseFirestore.instance.collection('chucVuCollection').get();

    return response.docs
        .map(
      (e) => ChucVuItem.fromJson(e.data()),
    )
        .where((item) {
      final maCVLower = item.maCV!.toLowerCase();
      final tenCVLower = item.tenCV!.toLowerCase();
      final searchLower = query.toLowerCase();

      return maCVLower.contains(searchLower) ||
          tenCVLower.contains(searchLower);
    }).toList();
  }
}

class GetChucVuDetailCollection {
  static Future<List<ChucVuDetailItem>> getChucVuDetailItem(
      String query, String? chucVuId) async {
    final response = await FirebaseFirestore.instance
        .collection('chucVuCollection')
        .doc(chucVuId)
        .collection('chucVuDetailCollection')
        .get();

    return response.docs
        .map(
      (e) => ChucVuDetailItem.fromJson(e.data()),
    )
        .where((item) {
      final _tenDVLower = item.tenNV!.toLowerCase();
      final _searchLower = query.toLowerCase();

      return _tenDVLower.contains(_searchLower);
    }).toList();
  }
}

class GetDoanTheCollection {
  static Future<List<DoanTheItem>> getDoanTheItem(String query) async {
    final response =
        await FirebaseFirestore.instance.collection('doanTheCollection').get();

    return response.docs
        .map(
      (e) => DoanTheItem.fromJson(e.data()),
    )
        .where((item) {
      final _maDVLower = item.maDT!.toLowerCase();
      final _tenDVLower = item.tenDT!.toLowerCase();
      final _searchLower = query.toLowerCase();

      return _maDVLower.contains(_searchLower) ||
          _tenDVLower.contains(_searchLower);
    }).toList();
  }
}

class GetDoanTheDetailCollection {
  static Future<List<DoanTheDetailItem>> getDoanTheDetailItem(
      String query, String doanTheId) async {
    final response = await FirebaseFirestore.instance
        .collection('doanTheCollection')
        .doc(doanTheId)
        .collection('doanTheDetailCollection')
        .get();

    return response.docs
        .map(
      (e) => DoanTheDetailItem.fromJson(e.data()),
    )
        .where((item) {
      final _tenNVLower = item.tenNV!.toLowerCase();
      final _searchLower = query.toLowerCase();

      return _tenNVLower.contains(_searchLower);
    }).toList();
  }
}

class GetNhanVienCollection {
  static Future<List<NhanVienItem>> getNhanVienItem(String query) async {
    final response =
        await FirebaseFirestore.instance.collection('nhanVienCollection').get();

    return response.docs
        .map(
      (e) => NhanVienItem.fromJson(e.data()),
    )
        .where((item) {
      final _maNVLower = item.maNV!.toLowerCase();
      final _tenNVLower = item.tenNV!.toLowerCase();
      final _searchLower = query.toLowerCase();

      return _maNVLower.contains(_searchLower) ||
          _tenNVLower.contains(_searchLower);
    }).toList();
  }

  static Future<List<NhanVienItem>> getNhanVienItemInDonVi(
      String query, String maDV) async {
    final response =
        await FirebaseFirestore.instance.collection('nhanVienCollection').get();

    return response.docs
        .map(
      (e) => NhanVienItem.fromJson(e.data()),
    )
        .where((item) {
      final _maDV = item.maDonViQuanLi!;
      final _maNVLower = item.maNV!.toLowerCase();
      final _tenNVLower = item.tenNV!.toLowerCase();
      final _searchLower = query.toLowerCase();

      return _maDV == maDV && _maNVLower.contains(_searchLower) ||
          _tenNVLower.contains(_searchLower) && _maDV == maDV;
    }).toList();
  }
}

class GetTrinhDoCollection {
  static Future<List<TrinhDoItem>> getTrinhDoItem(String query) async {
    final response =
        await FirebaseFirestore.instance.collection('trinhDoCollection').get();

    return response.docs
        .map(
      (e) => TrinhDoItem.fromJson(e.data()),
    )
        .where((item) {
      final maTDLower = item.maTD!.toLowerCase();
      final tenTDLower = item.tenTD!.toLowerCase();
      final searchLower = query.toLowerCase();

      return maTDLower.contains(searchLower) ||
          tenTDLower.contains(searchLower);
    }).toList();
  }
}

class GetTrinhDoDetailCollection {
  static Future<List<TrinhDoDetailItem>> getTrinhDoDetailItem(
      String query, String trinhDoId) async {
    final response = await FirebaseFirestore.instance
        .collection('trinhDoCollection')
        .doc(trinhDoId)
        .collection('trinhDoDetailCollection')
        .get();

    return response.docs
        .map(
      (e) => TrinhDoDetailItem.fromJson(e.data()),
    )
        .where((item) {
      final _tenNVLower = item.tenNV!.toLowerCase();
      final _searchLower = query.toLowerCase();

      return _tenNVLower.contains(_searchLower);
    }).toList();
  }
}

class GetThanNhanCollection {
  static Future<List<ThanNhanItem>> getThanNhanItem(
      String query, String maNV) async {
    final response =
        await FirebaseFirestore.instance.collection('thanNhanCollection').get();

    return response.docs
        .map(
      (e) => ThanNhanItem.fromJson(e.data()),
    )
        .where((item) {
      final _maNV = item.maNV!;
      final tenTNLower = item.tenTN!.toLowerCase();
      final searchLower = query.toLowerCase();

      return tenTNLower.contains(searchLower) && _maNV == maNV;
    }).toList();
  }
}

class GetKhenThuongCollection {
  static Future<List<KhenThuongItem>> getKhenThuongItem(
      String query, String maNV) async {
    final response = await FirebaseFirestore.instance
        .collection('khenThuongCollection')
        .get();

    return response.docs
        .map(
      (e) => KhenThuongItem.fromJson(e.data()),
    )
        .where((item) {
      final _maNV = item.maNV;
      final _loai = item.loai!.toLowerCase();
      final _noiDungKhenThuongLower = item.noiDungKhenThuong!.toLowerCase();
      final _searchLower = query.toLowerCase();

      return _loai.contains(_searchLower) ||
          _noiDungKhenThuongLower.contains(_searchLower) && _maNV == maNV;
    }).toList();
  }
}

class GetLuongCollection {
  static var _instance = FirebaseFirestore.instance
      .collection('luongCollection')
      .doc('mB9bA4WJ9PonXqQh5Mf9');

  static Future<List<HeSoLuongItem>> getHeSoLuongItem(String id) async {
    final response = await _instance
        .collection('ngachCollection')
        .doc(id)
        .collection('heSoLuong')
        .get();

    return response.docs
        .map(
          (e) => HeSoLuongItem.fromJson(e.data()),
        )
        .toList();
  }

  static Future<List<NgachItem>> getNgachItem() async {
    final response = await _instance.collection('ngachCollection').get();

    return response.docs
        .map(
          (e) => NgachItem.fromJson(e.data()),
        )
        .toList();
  }

  static Future<List<ThongTinTheoNamItem>> getThongTinTheoNamItem() async {
    final response =
        await _instance.collection('thongTinTheoNamCollection').get();

    return response.docs
        .map(
          (e) => ThongTinTheoNamItem.fromJson(e.data()),
        )
        .toList();
  }
}
