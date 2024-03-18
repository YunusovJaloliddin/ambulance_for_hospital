import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import '../models/booking.dart';


abstract interface class INotificationRepository {
  Future<void> postNotification(
      Booking booking,
    String token,
    String name,
  );
}

class NotificationRepository implements INotificationRepository {
  @override
  Future<void> postNotification(
    Booking booking,
    String token,
    String name,
  ) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":
          "Bearer AAAApeOD_O8:APA91bHEIaFRj42ww6gUKuh1yAFaYT0-TWHC2eIft6Lx_aySrAAZYFJda5zwb2qPPJpQyRj3USCHiNMVjeQIFeJAwNAlIVS_1LIH_rTaBSl45Tm-bA66PaawZtxBkOhmcKSD8PHcjKx1"    };
    Map<String, Object?> body = {
      "notification": {"title": name, "body": booking.reason},
      "registration_ids": [
        token,
      ],
      "click_action": "FLUTTER_NOTIFICATION_CLICK"
    };
    final uri = Uri.parse('https://fcm.googleapis.com/fcm/send');
    try {
      Response response =
          await post(uri, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
      } else {
        throw Error();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
