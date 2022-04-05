class DonViItem {
  String? maDV;
  String? tenDV;
  String? sdt;
  String? namThanhLap;

  DiaChi? diaChi;

  // num? tongLuong;

  String? imageUrl;
  String? id;

  DonViItem({
    this.maDV,
    this.tenDV,
    this.sdt,
    this.namThanhLap,
    this.diaChi,
    this.id,
    this.imageUrl,
    // this.tongLuong,
  });

  DonViItem.fromJson(Map<String, dynamic> json) {
    maDV = json['maDV'];
    tenDV = json['tenDV'];
    sdt = json['sdt'];
    namThanhLap = json['namThanhLap'];

    id = json['id'];
    imageUrl = json['imageUrl'];
    // tongLuong = json['tongLuong'];

    diaChi = DiaChi.fromJson(json['diaChi']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['maDV'] = this.maDV;
    data['tenDV'] = this.tenDV;
    data['sdt'] = this.sdt;
    data['namThanhLap'] = this.namThanhLap;
    data['diaChi'] = this.diaChi?.toJson();
    data['id'] = this.id;

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
