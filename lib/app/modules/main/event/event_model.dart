class EventItemModel {
   String id;
   String title;
   bool isEnded;
   bool isLiked;

   EventItemModel({
    required this.id,
    required this.title,
    this.isEnded = false,
    this.isLiked = false,
  });
}