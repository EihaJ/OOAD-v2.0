class TrinhDoItem {
  String? maTD;
  String? tenTD;
  num? phuCap;
  String? noiCapBang;
  String? id;

  ChuyenMonItem? chuyenMon;

  TrinhDoItem({
    this.maTD,
    this.tenTD,
    this.phuCap,
    this.noiCapBang,
    this.chuyenMon,
    this.id,
  });
  TrinhDoItem.fromJson(Map<String, dynamic> json) {
    maTD = json['maTD'];
    tenTD = json['tenTD'];
    phuCap = json['phuCap'];
    noiCapBang = json['noiCapBang'];

    id = json['id'];

    chuyenMon = ChuyenMonItem.fromJson(json['chuyenMon']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['maTD'] = this.maTD;
    data['tenTD'] = this.tenTD;
    data['phuCap'] = this.phuCap;
    data['noiCapBang'] = this.noiCapBang;
    data['chuyenMon'] = this.chuyenMon?.toJson();
    data['id'] = this.id;

    return data;
  }
}

class ChuyenMonItem {
  String? maCM;
  String? tenCM;

  ChuyenMonItem({
    this.maCM,
    this.tenCM,
  });

  ChuyenMonItem.fromJson(Map<String, dynamic> json) {
    maCM = json['maCM'];
    tenCM = json['tenCM'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maCM'] = this.maCM;
    data['tenCM'] = this.tenCM;
    return data;
  }
}
