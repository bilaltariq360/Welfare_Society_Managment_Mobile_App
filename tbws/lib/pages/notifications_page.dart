import 'package:flutter/material.dart';
import '../components/notification_card.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        const Row(
          children: [
            SizedBox(width: 15),
            Icon(
              Icons.notifications_active,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              'Notifications',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView(children: [
            NotificationCard(
                name: 'Muhammad Tariq Zafar',
                dateTime: DateTime.now(),
                message:
                    'ایک مورخ اپنے عہد کی سچی اور مکمل تصویر پیش کرتا ہے۔ وہ کوئی جھوٹی بات نہیں لکھتا اور وہ کسی بات کو دہراتا نہیں۔ وہ کسی کے خلاف تعصب نہیں رکھتا ۔ کبھی کبھی دو اچھے مورخ'),
            NotificationCard(
                name: 'Chaudhary Hameed Asghar',
                dateTime: DateTime.now(),
                message:
                    'ایک مورخ اپنے عہد کی سچی اور مکمل تصویر پیش کرتا ہے۔ وہ کوئی جھوٹی بات نہیں لکھتا اور وہ کسی بات کو دہراتا نہیں۔ وہ کسی کے خلاف تعصب نہیں رکھتا ۔ کبھی کبھی دو اچھے مورخ ایک مورخ اپنے عہد کی سچی اور مکمل تصویر پیش کرتا ہے۔ وہ کوئی جھوٹی بات نہیں لکھتا اور وہ کسی بات کو دہراتا نہیں۔ وہ کسی کے خلاف تعصب نہیں رکھتا ۔ کبھی کبھی دو اچھے مورخ '),
            NotificationCard(
                name: 'Muhammad Tariq Zafar',
                dateTime: DateTime.now(),
                message:
                    'ایک مورخ اپنے عہد کی سچی اور مکمل تصویر پیش کرتا ہے۔ وہ کوئی جھوٹی بات نہیں لکھتا اور وہ کسی بات کو دہراتا نہیں۔ وہ کسی کے خلاف تعصب نہیں رکھتا ۔ کبھی کبھی دو اچھے مورخ'),
            NotificationCard(
                name: 'Chaudhary Hameed Asghar',
                dateTime: DateTime.now(),
                message:
                    'ایک مورخ اپنے عہد کی سچی اور مکمل تصویر پیش کرتا ہے۔ وہ کوئی جھوٹی بات نہیں لکھتا اور وہ کسی بات کو دہراتا نہیں۔ وہ کسی کے خلاف تعصب نہیں رکھتا ۔ کبھی کبھی دو اچھے مورخ ایک مورخ اپنے عہد کی سچی اور مکمل تصویر پیش کرتا ہے۔ وہ کوئی جھوٹی بات نہیں لکھتا اور وہ کسی بات کو دہراتا نہیں۔ وہ کسی کے خلاف تعصب نہیں رکھتا ۔ کبھی کبھی دو اچھے مورخ '),
          ]),
        ),
      ],
    );
  }
}
