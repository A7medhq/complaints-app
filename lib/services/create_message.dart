import 'dart:convert';

import 'package:complaints/constants.dart';
import 'package:complaints/models/response_model.dart';
import 'package:complaints/models/single_mail.dart';
import 'package:http/http.dart' as http;
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

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseModel(
          data: Mail.fromJson(jsonDecode(response.body)), message: 'success');
    } else {
      return ResponseModel(message: 'failed');
    }
  }
}
