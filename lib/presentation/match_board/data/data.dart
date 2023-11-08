import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:most_sport/widgets/other/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataRepository {
  final String apiKey = '6b5e993ad23a4d155b992de4e5db82a6';
  final String apiHost = 'v3.football.api-sports.io';
  final String endpoint = 'fixtures';

  Future<Map<String, dynamic>> fetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String lastUpdateDate = prefs.getString('lastUpdateDate') ?? '';
    final String todayDate = getCurrentDate();
    if (lastUpdateDate != todayDate) {
      final response = await http.get(
        Uri.https(apiHost, endpoint, {'date': todayDate}),
        headers: {
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host': apiHost,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await prefs.setString('lastUpdateDate', todayDate);
        await prefs.setString('cachedData', json.encode(data));
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      final String cachedData = prefs.getString('cachedData') ?? '';
      if (cachedData.isNotEmpty) {
        return json.decode(cachedData);
      } else {
        throw Exception('Cached data is empty');
      }
    }
  }
  Future<Map<String, dynamic>> fetchDataByDay(String date) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String lastUpdateDate = prefs.getString('lastUpdateDate') ?? '';
    if (lastUpdateDate != date) {
      final response = await http.get(
        Uri.https(apiHost, endpoint, {'date': date}),
        headers: {
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host': apiHost,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await prefs.setString('lastUpdateDate', date);
        await prefs.setString('cachedData', json.encode(data));
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      final String cachedData = prefs.getString('cachedData') ?? '';
      if (cachedData.isNotEmpty) {
        return json.decode(cachedData);
      } else {
        throw Exception('Cached data is empty');
      }
    }
  }
}
