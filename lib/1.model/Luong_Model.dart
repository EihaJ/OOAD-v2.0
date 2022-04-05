class HeSoLuongItem {
  num? bac;
  num? heSoBac;
  String? id;

  HeSoLuongItem({
    required this.bac,
    required this.heSoBac,
    required this.id,
  });

  HeSoLuongItem.fromJson(Map<String, dynamic> json) {
    bac = json['bac'];
    heSoBac = json['heSoBac'];
    id = json['id'];
  }
}

class NgachItem {
  String? maNgach;
  String? tenNgach;
  String? id;

  NgachItem({
    required this.maNgach,
    required this.tenNgach,
    required this.id,
  });

  NgachItem.fromJson(Map<String, dynamic> json) {
    maNgach = json['maNgach'];
    tenNgach = json['tenNgach'];
    id = json['id'];
  }
}

class ThongTinTheoNamItem {
  num? nam;
  num? bHXH;
  num? bHYT;
  num? bHTN;
  num? luongToiThieu;

  //ko cho sua nam

  ThongTinTheoNamItem.fromJson(Map<String, dynamic> json) {
    nam = json['nam'];
    bHXH = json['bHXH'];
    bHYT = json['bHYT'];
    bHTN = json['bHTN'];
    luongToiThieu = json['luongToiThieu'];
  }
}
