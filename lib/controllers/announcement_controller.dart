import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_khairat_admin/config/config.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/constants/headers.dart';
import 'package:my_khairat_admin/models/announcement.dart';

class AnnouncementController {
  // Get all announcements
  static Future<List<Announcement>> getAnnouncements(String mosqueID) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/announcements/get';

      Map<String, dynamic> data = {
        'mosque_id': mosqueID,
      };

      var response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      if (response.statusCode == 200) {
        List announcements = jsonDecode(response.body);

        return announcements
            .map((announcement) =>
                Announcement.fromMap(announcement as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  // Add announcement
  static Future<dynamic> addAnnouncement(
      String mosqueID, Announcement announcement, XFile image) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/announcements/add';

      Map<String, String> data = {
        'mosque_id': mosqueID,
        'announcement_title': announcement.title!,
        'announcement_content': announcement.content!,
        'announcement_date': announcement.date!,
      };

      // var response = await post(
      //   Uri.parse(url),
      //   body: jsonEncode(data),
      //   headers: headerswithToken(_token),
      // );

      var request = MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(data)
        ..headers.addAll({
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + _token,
        })
        ..files.add(await MultipartFile.fromPath('image', image.path));

      StreamedResponse stream = await request.send();

      var response = await Response.fromStream(stream);

      log(response.body);

      if (response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);

        return Announcement.fromMap(data);
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Edit announcement
  static Future<dynamic> editAnnouncement(Announcement announcement) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/announcements/edit';

      Map<String, dynamic> data = announcement.toMap();

      var response = await put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      log(response.body);

      if (response.statusCode == 200) {
        return announcement;
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Delete announcement
  static Future<bool> deleteAnnouncement(Announcement announcement) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/announcements/delete';

      Map<String, dynamic> data = announcement.toMap();

      var response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      log(response.body);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
