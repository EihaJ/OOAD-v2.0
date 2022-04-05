class ChucVuDetailItem {
  String? tenNV;
  DateTime? ngayVao;
  DateTime? ngayRa;
  String? id;
  String? maNV;

  ChucVuDetailItem({
    this.tenNV,
    this.ngayVao,
    this.ngayRa,
    this.id,
    this.maNV,
  });

  ChucVuDetailItem.fromJson(Map<String, dynamic> json) {
    maNV = json['maNV'];
    tenNV = json['tenNV'];
    json['ngayVao'] != null
        ? ngayVao = json['ngayVao'].toDate()
        : ngayVao = null;
    json['ngayRa'] != null ? ngayRa = json['ngayRa'].toDate() : ngayRa = null;
    id = json['id'];
  }
}
