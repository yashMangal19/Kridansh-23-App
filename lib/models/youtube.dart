import 'dart:convert';

// Class for dynamic fields in @Youtube_Links sheet.
class YoutubeFields {
  static const String id = "id";
  static const String title = "title";
  static const String link = "link";

  static List<String> getFields() => [id, title, link];
}

// Model Class for a youtube link from @Youtube_Links sheet.
class Youtube {
  final int? id;
  final String title;
  final String link;

  // Constructor
  const Youtube({
    this.id,
    required this.title,
    required this.link,
  });

  // Function to convert model to a json dictionary.
  Map<String, dynamic> toJson() => {
        YoutubeFields.id: id,
        YoutubeFields.title: title,
        YoutubeFields.link: link,
      };

  // Function to convert json dictionary to [Youtube] model.
  static Youtube fromJson(Map<String, dynamic> json) => Youtube(
        id: jsonDecode(json[YoutubeFields.id]),
        title: json[YoutubeFields.title],
        link: json[YoutubeFields.link],
      );
}
