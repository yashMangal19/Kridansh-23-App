import 'dart:convert';

// Class for dynamic fields in @Matches_Day1, @Matches_Day2, @Matches_Day3 sheet.
class MatchFields {
  static const String id = "id";
  static const String team1 = "team1";
  static const String team2 = "team2";
  static const String location = "location";
  static const String time = "time";
  static const String sport = "sport";

  static List<String> getFields() => [id, team1, team2, location, time, sport];
}

// Model Class for a match from @Matches_Day1, @Matches_Day2, @Matches_Day3 sheet.
class Match {
  final int? id;
  final String team1;
  final String team2;
  final String location;
  final String time;
  final String sport;

  // Constructor
  const Match({
    this.id,
    required this.team1,
    required this.team2,
    required this.location,
    required this.time,
    required this.sport,
  });

  // Function to convert model to a json dictionary.
  Map<String, dynamic> toJson() => {
        MatchFields.id: id,
        MatchFields.team1: team1,
        MatchFields.team2: team2,
        MatchFields.location: location,
        MatchFields.time: time,
        MatchFields.sport: sport,
      };

  // Function to convert json dictionary to [Match] model.
  static Match fromJson(Map<String, dynamic> json) => Match(
        id: jsonDecode(json[MatchFields.id]),
        team1: json[MatchFields.team1],
        team2: json[MatchFields.team2],
        location: json[MatchFields.location],
        time: json[MatchFields.time],
        sport: json[MatchFields.sport],
      );
}
