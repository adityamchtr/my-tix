class EventItemModel {
   String image;
   String id;
   String title;
   String desc;
   bool isEnded;
   bool isLiked;

   EventItemModel({
    required this.image,
    required this.id,
    required this.title,
    required this.desc,
    this.isEnded = false,
    this.isLiked = false,
  });

   Map<String, dynamic> toMap() {
    return {
      'image': image,
      'id': id,
      'title': title,
      'desc': desc,
      'isEnded': isEnded,
      'isLiked': isLiked,
    };
  }

  factory EventItemModel.fromMap(Map<String, dynamic> map) {
    return EventItemModel(
      image: map['image'],
      id: map['id'],
      title: map['title'],
      desc: map['desc'],
      isEnded: map['isEnded'] ?? false,
      isLiked: map['isLiked'] ?? false,
    );
  }
}