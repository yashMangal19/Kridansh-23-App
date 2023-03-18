import 'dart:convert';

// Class for dynamic fields in @Leaderboard sheet.
class TeamFields {
  static const String id = "id";
  static const String team = "team";
  static const String points = "points";

  static List<String> getFields() => [id, team, points];
}

// Model Class for a match from @Leaderboard sheet.
class Team {
  final int? id;
  final String team;
  final int points;

  // Constructor
  const Team({
    this.id,
    required this.team,
    required this.points,
  });

  // Function to convert model to a json dictionary.
  Map<String, dynamic> toJson() => {
        TeamFields.id: id,
        TeamFields.team: team,
        TeamFields.points: points,
      };

  // Function to convert json dictionary to [Team] model.
  static Team fromJson(Map<String, dynamic> json) => Team(
        id: jsonDecode(json[TeamFields.id]),
        team: json[TeamFields.team],
        points: jsonDecode(json[TeamFields.points]),
      );
}
