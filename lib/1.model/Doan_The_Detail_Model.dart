class DoanTheDetailItem {
  String? tenNV;
  DateTime? ngayVao;
  DateTime? ngayRa;
  String? id;
  String? maNV;

  DoanTheDetailItem({
    this.tenNV,
    this.maNV,
    this.ngayVao,
    this.ngayRa,
    this.id,
  });

  DoanTheDetailItem.fromJson(Map<String, dynamic> json) {
    maNV = json['maNV'];
    tenNV = json['tenNV'];
    json['ngayVao'] != null
        ? ngayVao = json['ngayVao'].toDate()
        : ngayVao = null;
    json['ngayRa'] != null ? ngayRa = json['ngayRa'].toDate() : ngayRa = null;
    id = json['id'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['tenNV'] = this.tenNV;
  //   data['maNV'] = this.maNV;
  //   data['ngayVao'] = this.ngayVao;
  //   data['ngayRa'] = this.ngayRa;
  //   data['id'] = this.id;
  //   return data;
  // }
}
