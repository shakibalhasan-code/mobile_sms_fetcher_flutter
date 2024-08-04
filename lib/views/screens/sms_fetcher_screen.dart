import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telephony/telephony.dart';
import '../../get/sms_fetcher/sms_fetcher_controller.dart';

class SmsFetcherScreen extends StatefulWidget {
  @override
  State<SmsFetcherScreen> createState() => _SmsFetcherScreenState();
}

class _SmsFetcherScreenState extends State<SmsFetcherScreen> {
  final SmsController smsController = Get.put(SmsController());

  String _formatDate(int? timestamp) {
    if (timestamp == null) return '';
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS Fetcher'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: smsController.messages.length,
          itemBuilder: (context, index) {
            SmsMessage message = smsController.messages[index];
            return ListTile(
              title: Text(message.address ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message.body ?? ''),
                  SizedBox(height: 5),
                  Text(_formatDate(message.date),
                      style: TextStyle(fontSize: 12, color: Colors.blue)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
