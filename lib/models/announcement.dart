class Announcement {
  String? id;
  String? title;
  String? content;
  String? imgURL;
  String? date;

  Announcement({
    this.id,
    this.title,
    this.content,
    this.imgURL,
    this.date,
  });

  factory Announcement.fromMap(Map<String, dynamic> map) => Announcement(
        id: map['id'].toString(),
        title: map['announcement_title'],
        content: map['announcement_content'],
        imgURL: map['announcement_img_url'],
        date: map['announcement_date'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'announcement_title': title,
        'announcement_content': content,
        'announcement_img_url': imgURL,
        'announcement_date': date,
      };
}
