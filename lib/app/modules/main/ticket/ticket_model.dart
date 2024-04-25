class TicketParentItemModel {
  String id;
  String title;
  List<TicketChildItemModel> ticketChild;

  TicketParentItemModel({
    required this.id,
    this.title = "",
    required this.ticketChild,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'ticketChild': ticketChild.map((e) => e.toMap()).toList(),
    };
  }

  factory TicketParentItemModel.fromMap(Map<String, dynamic> map) {
    return TicketParentItemModel(
      id: map['id'],
      title: map['title'],
      ticketChild: List<TicketChildItemModel>.from(map["ticketChild"].map((e) => TicketChildItemModel.fromMap(e))),
    );
  }
}

class TicketChildItemModel {
  String id;
  String name;
  String date;
  bool status;
  double price;
  int qty;

  TicketChildItemModel({
    required this.id,
    required this.name,
    required this.date,
    this.status = true,
    this.price = 0,
    this.qty = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'status': status,
      'price': price,
    };
  }

  factory TicketChildItemModel.fromMap(Map<String, dynamic> map) {
    return TicketChildItemModel(
      id: map['id'],
      name: map['name'],
      date: map['date'],
      status: map['status'],
      price: map['price'],
    );
  }
}