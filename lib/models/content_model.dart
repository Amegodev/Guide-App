class ContentModel {
  String title;
  String imageUrl;
  String content;


  ContentModel({String title, String imageUrl, String content}) {
    this.title = title;
    this.imageUrl = imageUrl;
    this.content = content;
  }

  Map<String, dynamic> toJson() {
    return {
      "imageUrl": this.imageUrl,
      "title": this.title,
      "content": this.content,
    };
  }

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      imageUrl: json["imageUrl"],
      title: json["title"],
      content: json["content"],
    );
  }
//

}