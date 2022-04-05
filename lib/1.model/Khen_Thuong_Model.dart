class KhenThuongItem {
  String? capDoKhenThuong;
  DateTime? ngayKhenThuong;
  String? id;
  String? noiDungKhenThuong;
  String? loai;
  String? maNV;

  KhenThuongItem({
    this.capDoKhenThuong,
    this.noiDungKhenThuong,
    this.ngayKhenThuong,
    this.loai,
    this.id,
    this.maNV,
  });

  KhenThuongItem.fromJson(Map<String, dynamic> json) {
    noiDungKhenThuong = json['noiDungKhenThuong'];
    capDoKhenThuong = json['capDoKhenThuong'];
    json['ngayKhenThuong'] != null
        ? ngayKhenThuong = json['ngayKhenThuong'].toDate()
        : ngayKhenThuong = null;
    loai = json['loai'];
    maNV = json['maNV'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['capDoKhenThuong'] = this.capDoKhenThuong;
    data['noiDungKhenThuong'] = this.noiDungKhenThuong;
    data['ngayKhenThuong'] = this.ngayKhenThuong;
    data['loai'] = this.loai;
    data['id'] = this.id;
    data['maNV'] = this.maNV;
    return data;
  }
}
