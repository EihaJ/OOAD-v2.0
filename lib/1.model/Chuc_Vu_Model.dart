class ChucVuItem {
  String? maCV;
  String? tenCV;
  num? heSo;
  String? id;

  ChucVuItem({
    required this.maCV,
    required this.tenCV,
    required this.id,
    required this.heSo,
  });

  ChucVuItem.fromJson(Map<String, dynamic> json) {
    maCV = json['maCV'];
    tenCV = json['tenCV'];
    id = json['id'];
    heSo = json['heSo'];
  }
}

// class HeSoPhuCap {
//   String? nam;
//   num? heSo;
//   String? id;

//   HeSoPhuCap({
//     required this.nam,
//     required this.heSo,
//     required this.id,
//   });

//   HeSoPhuCap.fromJson(Map<String, dynamic> json) {
//     nam = json['nam'];
//     heSo = json['heSo'];
//     id = json['id'];
//   }
// }
