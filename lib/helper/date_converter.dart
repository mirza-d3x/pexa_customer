import 'package:intl/intl.dart';
import 'package:shoppe_customer/util/app_constants.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss a').format(dateTime);
  }

  static DateTime expectedDeliveryDate(DateTime dateTime) {
    return dateTime.add(const Duration(days: 10));
  }

  static String dateToTimeOnly(DateTime dateTime) {
    return DateFormat(_timeFormatter()).format(dateTime);
  }

  static String dateToDateAndTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  static String dateToDateAndTimeAm(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd ${_timeFormatter()}').format(dateTime);
  }

  static String dateTimeStringToDateTime(String dateTime) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}')
        .format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy')
        .format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static DateTime dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime);
  }

  static String isoStringToDateTimeString(String dateTime) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}')
        .format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String stringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy')
        .format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime);
  }

  static String convertTimeToTime(String time) {
    return DateFormat(_timeFormatter()).format(DateFormat('HH:mm').parse(time));
  }

  static DateTime convertStringTimeToDate(String time) {
    return DateFormat('HH:mm').parse(time);
  }

  static bool isAvailable(String start, String end,
      {DateTime? time, bool isoTime = false}) {
    DateTime currentTime;
    if (time != null) {
      currentTime = time;
    } else {
      currentTime = DateTime.now();
    }
    DateTime start0 = start != null
        ? isoTime
            ? isoStringToLocalDate(start)
            : DateFormat('HH:mm').parse(start)
        : DateTime(currentTime.year);
    DateTime end0 = end != null
        ? isoTime
            ? isoStringToLocalDate(end)
            : DateFormat('HH:mm').parse(end)
        : DateTime(
            currentTime.year, currentTime.month, currentTime.day, 23, 59);
    DateTime startTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, start0.hour, start0.minute, start0.second);
    DateTime endTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, end0.hour, end0.minute, end0.second);
    if (endTime.isBefore(startTime)) {
      if (currentTime.isBefore(startTime) && currentTime.isBefore(endTime)) {
        startTime = startTime.add(const Duration(days: -1));
      } else {
        endTime = endTime.add(const Duration(days: 1));
      }
    }
    return currentTime.isAfter(startTime) && currentTime.isBefore(endTime);
  }

  static String _timeFormatter() {
    return AppConstants.TIME_FORMAT == '24' ? 'HH:mm' : 'hh:mm a';
  }

  static int differenceInMinute(String deliveryTime, String orderTime,
      int processingTime, String scheduleAt) {
    // 'min', 'hours', 'days'
    int minTime = processingTime;
    if (deliveryTime.isNotEmpty && processingTime == null) {
      try {
        List<String> timeList = deliveryTime.split('-'); // ['15', '20']
        minTime = int.parse(timeList[0]);
      } catch (e) {}
    }
    DateTime deliveryTime0 =
        dateTimeStringToDate(scheduleAt).add(Duration(minutes: minTime));
    return deliveryTime0.difference(DateTime.now()).inMinutes;
  }

  static bool isBeforeTime(String dateTime) {
    DateTime scheduleTime = dateTimeStringToDate(dateTime);
    return scheduleTime.isBefore(DateTime.now());
  }

  static String timeAgo(
      {bool numericDates = true, required DateTime dateTime}) {
    final date2 = DateTime.now();
    final difference = date2.difference(dateTime);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
