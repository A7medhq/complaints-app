import 'dart:convert';

import 'package:complaints/constants.dart';
import 'package:complaints/models/response_model.dart';
import 'package:complaints/models/single_mail.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mails {
  static Future<ResponseModel> createNewMail({
    required String subject,
    required String description,
    required String senderId,
    required String archiveNumber,
    required String archiveDate,
    required String decision,
    required String statusId,
    required String finalDecision,
    required String tags,
    required String activities,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var response = await http.post(Uri.parse('$base_url/mails'), headers: {
      'Authorization': token
    }, body: {
      'subject': subject,
      'description': description,
      'sender_id': senderId,
      'archive_number': archiveNumber,
      'archive_date': archiveDate,
      'decision': decision,
      'status_id': statusId,
      'final_decision': finalDecision,
      'tags': tags,
      'activities': activities
    });

    if (response.statusCode == 200) {
      return ResponseModel(
          data: Mail.fromJson(jsonDecode(response.body)), message: 'success');
    } else {
      return ResponseModel(message: 'failed');
    }
  }

  static Future<bool> addAttachments({
    required String mailId,
    List<XFile>? images,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://palmail.betweenltd.com/api/attachments'));
    request.fields
        .addAll({'mail_id': mailId, 'title': DateTime.now().toString()});

    if (images != null) {
      for (var image in images) {
        request.files
            .add(await http.MultipartFile.fromPath('image', image.path));
      }
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return true;
    }
  }
}
