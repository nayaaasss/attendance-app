import 'package:intl/intl.dart';


//memanggil data secara real time dgn cara memanggil class yg ada di intl
void setDateTime(Function(String, String, String) onDateTimeSet) {
  var dateNow = DateTime.now();
  var dateFormat = DateFormat('dd mm yyyy');
  var dateTime = DateFormat('hh:mm:ss');

  String date = dateFormat.format(dateNow);
  String time = dateTime.format(dateNow);
  String currentDate = '$date | $time';

  onDateTimeSet(date, time, currentDate);
}

// nge set attendanceStatus
void setAttendanceStatus(Function(String) onStatusSet) {
  //variable penampung
  var dateNow = DateTime.now();
  var hour = int.parse(DateFormat('HH').format(dateNow)); //int.parse itu digunakan untuk menjadi string
  var minute = int.parse(DateFormat('MM').format(dateNow));

  
  String attendanceStatus;
  if (hour < 7 || (hour == 7 && minute == 00)) { // kalau absen kurang dri jam 7 atau jam 7 pas itu statusnya hadir
    attendanceStatus = "Attend";
  } else if (hour > 7 || (hour == 7 && minute >= 01)) { // kalau absen lebih dari jam
    attendanceStatus = "Late";
  } else {
    attendanceStatus = "Absent";
  }

  onStatusSet(attendanceStatus);
}