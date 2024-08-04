import 'package:get/get.dart';
import 'package:telephony/telephony.dart';
import 'package:permission_handler/permission_handler.dart';


class SmsController extends GetxController {
  final Telephony telephony = Telephony.instance;
  var messages = <SmsMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    _requestPermissions();
    _fetchSms();
    _listenForIncomingSms();

  }

  Future<void> _requestPermissions() async {
    if (await Permission.sms.request().isGranted) {
      print("SMS permissions granted");
    }
  }

  Future<void> _fetchSms() async {
    bool? permissionsGranted = await telephony.requestSmsPermissions;
    if (permissionsGranted == true) {
      List<SmsMessage> fetchedMessages = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY,SmsColumn.DATE],
      );
      messages.assignAll(fetchedMessages);
      print("Fetched ${fetchedMessages[0]}");
    }
  }

  void _listenForIncomingSms() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        messages.add(message);
        print("New SMS received: ${message.body}");
      },
      listenInBackground: true,
      onBackgroundMessage: _onBackgroundMessage,
    );
  }

  static void _onBackgroundMessage(SmsMessage message) {
    print("Background SMS received: ${message.body}");
  }
}
