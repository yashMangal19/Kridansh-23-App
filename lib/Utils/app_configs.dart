import 'package:package_info_plus/package_info_plus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/constants.dart';

class AppConfigs{
  Map<String, dynamic>? configJson;

  Future<void> initialize() async{
    await _fetchConfigs();
  }


  Future<dynamic> _fetchConfigs() async{
    var url = 'https://soumik-roy.github.io/Kridansh-App-Configs/configs.json';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      debugPrint(responseData.toString());
      configJson = responseData['data'];
    }
  }

  Future<bool> isLatestVersion() async{
    if(configJson==null){
      await initialize();
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    // return version==configJson!['ios_latest_version'];

    return version==configJson!['latest_version'];
    // return version==configJson!['debug_latest_version'];

  }

  Future<String> appUpdateUrl() async{
    if(configJson==null){
      await initialize();
    }

    return configJson?['playstore_url']??"";
  }

  // Future<void> setAppSecret() async{
  //   if(configJson==null){
  //     await initialize();
  //   }
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('app_secret', configJson!['app_secret']);
  // }

  // Future<void> setIosUpdateLink() async{
  //   if(configJson==null){
  //     await initialize();
  //   }
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('ios_update_link', configJson!['ios_update_link']);
  // }
}
