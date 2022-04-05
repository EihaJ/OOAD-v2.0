class ThanNhanItem {
  String? maNV;
  String? tenTN;
  String? moiQH;
  String? ngheNghiep;

  DateTime? ngaySinh;

  String? id;

  ThanNhanItem({
    this.maNV,
    this.tenTN,
    this.moiQH,
    this.ngheNghiep,
    this.ngaySinh,
    this.id,

    // this.tongLuong,
  });

  ThanNhanItem.fromJson(Map<String, dynamic> json) {
    maNV = json['maNV'];
    tenTN = json['tenTN'];
    moiQH = json['moiQH'];
    ngheNghiep = json['ngheNghiep'];
    json['ngaySinh'] != null
        ? ngaySinh = json['ngaySinh'].toDate()
        : ngaySinh = null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maNV'] = this.maNV;
    data['tenTN'] = this.tenTN;
    data['moiQH'] = this.moiQH;
    data['ngheNghiep'] = this.ngheNghiep;
    data['ngaySinh'] = this.ngaySinh;
    data['id'] = this.id;

    return data;
  }
}
