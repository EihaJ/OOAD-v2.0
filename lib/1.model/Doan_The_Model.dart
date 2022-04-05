class DoanTheItem {
  String? maDT;
  String? tenDT;
  String? id;

  DoanTheItem({
    required this.maDT,
    required this.tenDT,
    required this.id,
  });

  DoanTheItem.fromJson(Map<String, dynamic> json) {
    maDT = json['maDT'];
    tenDT = json['tenDT'];
    id = json['id'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['maDT'] = this.maDT;
  //   data['tenDT'] = this.tenDT;
  //   data['id'] = this.id;
  //   return data;
  // }
}
