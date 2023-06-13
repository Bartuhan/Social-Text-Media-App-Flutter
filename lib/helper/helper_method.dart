//Return a formatted data as String (Datayı String Geri Döndürür)

import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timeStamp) {
  DateTime dateTime = timeStamp.toDate();

  //Year
  String year = dateTime.year.toString();

  // Month
  String month = dateTime.month.toString();

  //Day
  String day = dateTime.day.toString();

  String formattedData = "$day / $month / $year";

  return formattedData;
}
