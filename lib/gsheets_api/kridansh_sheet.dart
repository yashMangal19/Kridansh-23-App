import 'package:flutter/foundation.dart';
import 'package:gsheets/gsheets.dart';
import 'package:kridansh_23_app/models/team.dart';
import '../models/youtube.dart';
import '../models/match.dart';

/*
@KridanshSheetApi contains functions for getting the database google sheet named @Kridansh_23_App_Database
Reference Link - https://docs.google.com/spreadsheets/d/1ZYPfBc8x5r-QMnt0iKoJ_HAJ3VCKFQOCfDB8ySRWIQA/edit#gid=0
 */
class KridanshSheetApi {
  // Initialising the credentials from the json file downloaded from the google cloud console after enabling @Google Sheets API
  static const _credentials = r''' 
  {
  "type": "service_account",
  "project_id": "kridansh-23-app",
  "private_key_id": "06fe6a9f4972700820fe9eac388bdd683ae18021",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCjfV58qUOda8US\n64Af38EzfZfZEbEgU4NidmhaV8/kTMGMUYQXRaxqOJ2Gyrm4U4sjPUfzJcMASXuR\nbHIdxRG0+5qUFdES/91m9/zxEcpi51CTff4ooZQVa5/AFICj2ELVc7zc8+6aGBzS\n2NJt/WCeiZtjKiHMwnvDPJTzm1fJ3otyTqBH0Yv5SiHM79W2a+zKj94gBOtZGakx\n1VTzGNxZU7Ch5SY1XUiYtY3ye8skxFThhjDYyyWdQc3syMwpm/7s8tq3Ot3cUucu\nIRpiB1n9qgqDU/SX6N0N+GpwQWBE5kfkStzhAFnt7uTv4apNxii6d1x5JuaTnD08\n21stmZgnAgMBAAECggEAD9aBKkjIJ5O9S41r4+qXD/1pPJqa/aY0J/w6NLz6re5a\nS6pz8Os2KN4jiIooFA69KmSb4pa0aC6LiCAo1/BzkYRUSmc9/Kiz0pn7M4FaiVqe\nSC41n8sItPXa9nkl/c62qXClCa9J3JIHF3fwvr4D4lKIrpfHdCDHwOH5Y2DCUD2/\n7HaDJe1DlQiwJjmPZn381JpLzi/5QKvLt442d84dzHtQbaisSF+dKUb4XmRo6ZJB\nOLTzIN6jISkr4WzkQC+HEv46Fh0ZjWl5BiLTpHVPQgQ2g1DK8bqvQZix5aM9LHGS\nty+UyhOzT8hjoJK7ppWV1Ukuib0P9VKJoClylUBB4QKBgQDgVgrGZ2CKpQIVFEky\n0pNDlHdFvcdtQnWIybHgILRUUbeKC3hmWsRtrkh7ssQeisrVd5R7Kqt1NbOazQPD\nXvJaR2WiXEWQX3NCoum4bU241k5wK6MuMMt/Ebwi9C5TFJTM0zDpnqunueyZKV50\n3vNnGTH85UN8w/3i2xOdwGI+hwKBgQC6kMJKc9foUvXHJ8AyFFF+firN8+MErb2T\nE396ThJKKh8RUZH9T149C2r7aW0sT1TGl1HyFyH3oqmjLRJhBUYAuNO4eP2psqYx\nUzHF+IfiFiQvcmDaMYcermiWSb1qF0E0SKx9S94UM1zIdCcrrO/kgd2xBMYCqFhB\nNL5xRsuhYQKBgQCv8cuxoBKPqqrfbXGbcpwdPKvu/tESWDVmewoPBpdoKk8Q7b4Y\nSMgWXcJrgeFfMuuyUH8bunOPEfczSefRqv3Y4HZNyKCmgrYbZTp5cwCqHyqVvyPU\nbmCr4HT11R0f+9xYaKrMD64BdkiiN1flwZaVHaWe+xDbIbxV2AyihOiIsQKBgFml\nY2apIW8GJglrZWPq9XnFoEXUUhqWbYh1jwSy7QDsGn+U5YSFla/Zg6+I6ienewHu\nBjdAvFakt8SrzLAH+6ovJbT3llPrfwYmhr0s/gY6Q2r1F+rgb5/jiGfmyPhocjFw\nVkniobStNYEwpv3KnH79lAwSUh9GyxmSAYymywQhAoGBANZK8RC58uOVSER+Inom\nmDlsGj4+UK715bkMlf3O7wa7oZVmHwrybyTMAvAQmAIWuV4xtLJdCgUtd6xdTsOi\n/Ff5ugQsbqfTVViW5zyd5uLMEMa5HPvPzQkaF6EOh0dozrHD/jhcM6ZuMMVpnnCS\nKqfWVXRLvWf81KJ5593fupYL\n-----END PRIVATE KEY-----\n",
  "client_email": "kridansh-23-app@kridansh-23-app.iam.gserviceaccount.com",
  "client_id": "111704217952554112894",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/kridansh-23-app%40kridansh-23-app.iam.gserviceaccount.com"
}

  ''';

  // Google sheets ID extracted from the Reference Link mentioned above.
  static const _spreadsheetId = '1ZYPfBc8x5r-QMnt0iKoJ_HAJ3VCKFQOCfDB8ySRWIQA';

  // Initialising the whole database sheet named @Kridansh_23_App_Database
  static final _kridanshSheets = GSheets(_credentials);

  // #################################################################################

  /*
  Youtube Sheet named @Youtube_Links which contains the youtube highlight links.
  @Function - [initYoutubeSheet] function gets the @Youtube_Links sheet and if its first row is empty then initialises it with youtube model fields.
  @CommonFunction - [_getWorksheet] is a function that gets the sheet if not available created one.
  @Function - [getYoutubeById] gets a link by an id.
  @Function - [getAllYoutube] gets all youtube links.
   */
  static Worksheet? _youtubeSheet;

  static Future initYoutubeSheet() async {
    try {
      final spreadsheet = await _kridanshSheets.spreadsheet(_spreadsheetId);
      _youtubeSheet = await _getWorksheet(spreadsheet, title: 'Youtube_Links');
      final firstRow = YoutubeFields.getFields();
      _youtubeSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      if (kDebugMode) {
        print("Init error: $e");
      }
    }
  }

  static Future<Youtube?> getYoutubeById(int id) async {
    if (_youtubeSheet == null) return null;

    final json = await _youtubeSheet!.values.map.rowByKey(id, fromColumn: 1);

    return json == null ? null : Youtube.fromJson(json);
  }

  static Future<List<Youtube>> getAllYoutube() async {
    if (_youtubeSheet == null) return <Youtube>[];

    final youtubeLinks = await _youtubeSheet!.values.map.allRows();
    return youtubeLinks == null
        ? <Youtube>[]
        : youtubeLinks.map(Youtube.fromJson).toList();
  }

  // #################################################################################

  /*
  Matches Sheet named @Matches which contains the list of match for all 7 days.
  @Function - [initMatchesSheet] function gets the @Matches_Day1 sheet and if its first row is empty then initialises it with match model fields.
  @CommonFunction - [_getWorksheet] is a private function that gets the sheet is not available created one.
  @Function - [getMatchById] gets a match by an id.
  @Function - [getAllMatches] gets all matches.
   */
  static Worksheet? _matchListSheet;

  static Future initMatchesSheet() async {
    try {
      final spreadsheet = await _kridanshSheets.spreadsheet(_spreadsheetId);
      _matchListSheet = await _getWorksheet(spreadsheet, title: 'Matches');
      final firstRow = MatchFields.getFields();
      _matchListSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      if (kDebugMode) {
        print("Init error: $e");
      }
    }
  }

  static Future<Match?> getMatchById(int id) async {
    if (_matchListSheet == null) return null;

    final json = await _matchListSheet!.values.map.rowByKey(id, fromColumn: 1);

    return json == null ? null : Match.fromJson(json);
  }

  static Future<List<Match>> getAllMatches() async {
    if (_matchListSheet == null) return <Match>[];

    final matchesList = await _matchListSheet!.values.map.allRows();
    return matchesList == null
        ? <Match>[]
        : matchesList.map(Match.fromJson).toList();
  }

  // #################################################################################

  /*
  Matches Day1 Sheet named @Matches_Day1 which contains the list of match details of day1.
  @Function - [initMatchesDay1Sheet] function gets the @Matches_Day1 sheet and if its first row is empty then initialises it with match model fields.
  @CommonFunction - [_getWorksheet] is a private function that gets the sheet is not available created one.
  @Function - [getMatchesDay1ById] gets a match by an id.
  @Function - [getAllMatchesDay1] gets all matches of day1.
   */
  // static Worksheet? _matchListDay1Sheet;
  //
  // static Future initMatchesDay1Sheet() async {
  //   try {
  //     final spreadsheet = await _kridanshSheets.spreadsheet(_spreadsheetId);
  //     _matchListDay1Sheet =
  //         await _getWorksheet(spreadsheet, title: 'Matches_Day1');
  //     final firstRow = MatchFields.getFields();
  //     _matchListDay1Sheet!.values.insertRow(1, firstRow);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Init error: $e");
  //     }
  //   }
  // }
  //
  // static Future<Match?> getMatchesDay1ById(int id) async {
  //   if (_matchListDay1Sheet == null) return null;
  //
  //   final json =
  //       await _matchListDay1Sheet!.values.map.rowByKey(id, fromColumn: 1);
  //
  //   return json == null ? null : Match.fromJson(json);
  // }
  //
  // static Future<List<Match>> getAllMatchesDay1() async {
  //   if (_matchListDay1Sheet == null) return <Match>[];
  //
  //   final matchesDay1List = await _matchListDay1Sheet!.values.map.allRows();
  //   return matchesDay1List == null
  //       ? <Match>[]
  //       : matchesDay1List.map(Match.fromJson).toList();
  // }
  //
  // // #################################################################################
  //
  // /*
  // Matches Day1 Sheet named @Matches_Day1 which contains the list of match details of day1.
  // @Function - [initMatchesDay1Sheet] function gets the @Matches_Day1 sheet and if its first row is empty then initialises it with match model fields.
  // @CommonFunction - [_getWorksheet] is a private function that gets the sheet is not available created one.
  // @Function - [getMatchesDay1ById] gets a match by an id.
  // @Function - [getAllMatchesDay1] gets all matches of day1.
  //  */
  // static Worksheet? _matchListDay2Sheet;
  //
  // static Future initMatchesDay2Sheet() async {
  //   try {
  //     final spreadsheet = await _kridanshSheets.spreadsheet(_spreadsheetId);
  //     _matchListDay2Sheet =
  //         await _getWorksheet(spreadsheet, title: 'Matches_Day2');
  //     final firstRow = MatchFields.getFields();
  //     _matchListDay2Sheet!.values.insertRow(1, firstRow);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Init error: $e");
  //     }
  //   }
  // }
  //
  // static Future<Match?> getMatchesDay2ById(int id) async {
  //   if (_matchListDay2Sheet == null) return null;
  //
  //   final json =
  //       await _matchListDay2Sheet!.values.map.rowByKey(id, fromColumn: 1);
  //
  //   return json == null ? null : Match.fromJson(json);
  // }
  //
  // static Future<List<Match>> getAllMatchesDay2() async {
  //   if (_matchListDay2Sheet == null) return <Match>[];
  //
  //   final matchesDay1List = await _matchListDay2Sheet!.values.map.allRows();
  //   return matchesDay1List == null
  //       ? <Match>[]
  //       : matchesDay1List.map(Match.fromJson).toList();
  // }
  //
  // // #################################################################################
  //
  // /*
  // Matches Day1 Sheet named @Matches_Day1 which contains the list of match details of day1.
  // @Function - [initMatchesDay1Sheet] function gets the @Matches_Day1 sheet and if its first row is empty then initialises it with [Match] model fields.
  // @CommonFunction - [_getWorksheet] is a private function that gets the sheet is not available created one.
  // @Function - [getMatchesDay1ById] gets a match by an id.
  // @Function - [getAllMatchesDay1] gets all matches of day1.
  //  */
  // static Worksheet? _matchListDay3Sheet;
  //
  // static Future initMatchesDay3Sheet() async {
  //   try {
  //     final spreadsheet = await _kridanshSheets.spreadsheet(_spreadsheetId);
  //     _matchListDay3Sheet =
  //         await _getWorksheet(spreadsheet, title: 'Matches_Day3');
  //     final firstRow = MatchFields.getFields();
  //     _matchListDay3Sheet!.values.insertRow(1, firstRow);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Init error: $e");
  //     }
  //   }
  // }
  //
  // static Future<Match?> getMatchesDay3ById(int id) async {
  //   if (_matchListDay3Sheet == null) return null;
  //
  //   final json =
  //       await _matchListDay3Sheet!.values.map.rowByKey(id, fromColumn: 1);
  //
  //   return json == null ? null : Match.fromJson(json);
  // }
  //
  // static Future<List<Match>> getAllMatchesDay3() async {
  //   if (_matchListDay3Sheet == null) return <Match>[];
  //
  //   final matchesDay1List = await _matchListDay3Sheet!.values.map.allRows();
  //   return matchesDay1List == null
  //       ? <Match>[]
  //       : matchesDay1List.map(Match.fromJson).toList();
  // }

  // #################################################################################

  /*
  Leaderboard Sheet named @Leaderboard which contains the list of teams in ranked order.
  @Function - [initLeaderboardSheet] function gets the @Leaderboard sheet and if its first row is empty then initialises it with [Team] model fields.
  @CommonFunction - [_getWorksheet] is a private function that gets the sheet is not available created one.
  @Function - [getTeamById] gets a team by an id/rank.
  @Function - [getAllTeams] gets all teams in ranked order.
   */
  static Worksheet? _leaderboardSheet;

  static Future initLeaderboardSheet() async {
    try {
      final spreadsheet = await _kridanshSheets.spreadsheet(_spreadsheetId);
      _leaderboardSheet =
          await _getWorksheet(spreadsheet, title: 'Leaderboard');
      final firstRow = TeamFields.getFields();
      _leaderboardSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      if (kDebugMode) {
        print("Init error: $e");
      }
    }
  }

  static Future<Team?> getTeamById(int id) async {
    if (_leaderboardSheet == null) return null;

    final json =
        await _leaderboardSheet!.values.map.rowByKey(id, fromColumn: 1);

    return json == null ? null : Team.fromJson(json);
  }

  static Future<List<Team>> getAllTeams() async {
    if (_leaderboardSheet == null) return <Team>[];

    final teamsList = await _leaderboardSheet!.values.map.allRows();
    return teamsList == null ? <Team>[] : teamsList.map(Team.fromJson).toList();
  }

  // #################################################################################

  // Common functions
  // 1. [_getWorksheet] is a function that gets the sheet if not available created one.
  static Future<Worksheet?> _getWorksheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }
}
