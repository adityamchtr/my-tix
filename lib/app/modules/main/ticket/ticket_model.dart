class TicketParentItemModel {
  String id;
  String title;
  List<TicketChildItemModel> ticketChild;

  TicketParentItemModel({
    required this.id,
    this.title = "",
    required this.ticketChild,
  });
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
}