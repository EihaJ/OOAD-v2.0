import '../1.model/Luong_Model.dart';
import '../database/database.dart';

class ListLuong {
  Future init(String? maDV) async {
    String query = '';
    List tongLuong;

    final nhanVienItems =
        await GetNhanVienCollection.getNhanVienItemInDonVi(query, maDV!);
    final ngachItems = await GetLuongCollection.getNgachItem();

    // final List<List<NgachItem>> heSoLuongItems = ngachItems.
    for (int i = 0; i < ngachItems.length; i++) {
      for (int j = 0; j < nhanVienItems.length; j++) {
        if (ngachItems[i].maNgach == nhanVienItems[i].maNgach) {
          final heSoLuongItems = await GetLuongCollection.getHeSoLuongItem(
              nhanVienItems[i].maNgach!);
        }
      }
    }

    final thongTinTheoNamItems =
        await GetLuongCollection.getThongTinTheoNamItem();

    for (int i = 0; i < ngachItems.length; i++) {
      for (int j = 0; j < thongTinTheoNamItems.length; j++) {}
    }
  }
}
