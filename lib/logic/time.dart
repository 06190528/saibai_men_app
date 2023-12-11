DateTimeToString(DateTime dateTime) {
  return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
}

DurationToString(Duration duration) {
  if (duration.inHours == 0) {
    return "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:"
        "${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  } else {
    return "${duration.inHours.toString().padLeft(2, '0')}:"
        "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:"
        "${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }
}
