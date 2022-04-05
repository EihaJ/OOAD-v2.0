class NhanVienItem {
  String? maNV;
  String? tenNV;
  num? gioiTinh; // 1: nam, 0: nu
  String? danToc;
  String? cMND;
  String? imageUrl;

  String? id;
  String? maDonViQuanLi;
  // String? maChucVu;
  String? maNgach;

  DiaChi? diaChi;

  DateTime? ngaySinh;
  DateTime? ngayVaoTruong;
  DateTime? ngayRaTruong;

  NhanVienItem({
    // this.maChucVu,
    this.maNV,
    this.tenNV,
    this.gioiTinh,
    this.cMND,
    this.danToc,
    this.diaChi,
    this.imageUrl,
    this.ngayRaTruong,
    this.ngaySinh,
    this.ngayVaoTruong,
    this.id,
    this.maDonViQuanLi,
    this.maNgach,
  });

  NhanVienItem.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    maNV = json['maNV'];
    tenNV = json['tenNV'];
    gioiTinh = json['gioiTinh'];
    danToc = json['danToc'];
    json['ngaySinh'] != null
        ? ngaySinh = json['ngaySinh'].toDate()
        : ngaySinh = null;
    cMND = json['cMND'];
    json['ngayVaoTruong'] != null
        ? ngayVaoTruong = json['ngayVaoTruong'].toDate()
        : ngayVaoTruong = null;
    json['ngayRaTruong'] != null
        ? ngayRaTruong = json['ngayRaTruong'].toDate()
        : ngayRaTruong = null;
    maDonViQuanLi = json['maDonViQuanLi'];
    // maChucVu = json['maChucVu'];
    maNgach = json['maNgach'];
    id = json['id'];

    diaChi = DiaChi.fromJson(json['diaChi']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['maNV'] = this.maNV;
    data['tenNV'] = this.tenNV;
    data['gioiTinh'] = this.gioiTinh;
    data['danToc'] = this.danToc;
    data['ngaySinh'] = this.ngaySinh;
    data['cMND'] = this.cMND;
    data['ngayVaoTruong'] = this.ngayVaoTruong;
    data['ngayRaTruong'] = this.ngayRaTruong;
    data['diaChi'] = this.diaChi?.toJson();
    data['id'] = this.id;
    data['maDonViQuanLi'] = this.maDonViQuanLi;
    // data['maChucVu'] = this.maChucVu;
    data['maNgach'] = this.maNgach;

    return data;
  }
}

class DiaChi {
  String? soNha;
  String? phuong;
  String? quan;
  String? tp;

  DiaChi({
    this.phuong,
    this.quan,
    this.soNha,
    this.tp,
  });

  DiaChi.fromJson(Map<String, dynamic> json) {
    soNha = json['soNha'];
    phuong = json['phuong'];
    quan = json['quan'];
    tp = json['tp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soNha'] = this.soNha;
    data['phuong'] = this.phuong;
    data['quan'] = this.quan;
    data['tp'] = this.tp;
    return data;
  }
}
