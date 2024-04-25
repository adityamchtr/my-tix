class PaymentParentItemModel {
  String id;
  String title;
  List<PaymentChildItemModel> paymentChild;

  PaymentParentItemModel({
    required this.id,
    this.title = "",
    required this.paymentChild,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'paymentChild': paymentChild.map((e) => e.toMap()).toList(),
    };
  }

  factory PaymentParentItemModel.fromMap(Map<String, dynamic> map) {
    return PaymentParentItemModel(
      id: map['id'],
      title: map['title'],
      paymentChild: List<PaymentChildItemModel>.from(map["paymentChild"].map((e) => PaymentChildItemModel.fromMap(e))),
    );
  }
}

class PaymentChildItemModel {
  String id;
  String headerId;
  String headerTitle;
  String name;
  String logo;

  PaymentChildItemModel({
    required this.id,
    required this.headerId,
    required this.headerTitle,
    required this.name,
    required this.logo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'headerId': headerId,
      'headerTitle': headerTitle,
      'name': name,
      'logo': logo,
    };
  }

  factory PaymentChildItemModel.fromMap(Map<String, dynamic> map) {
    return PaymentChildItemModel(
      id: map['id'],
      headerId: map['headerId'],
      headerTitle: map['headerTitle'],
      name: map['name'],
      logo: map['logo'],
    );
  }
}