double convertTime(double value, String from, String to) {
  const seconds = {
    'seconds': 1.0,
    'minutes': 60.0,
    'hours': 3600.0,
    'days': 86400.0,
  };
  return value * seconds[from]! / seconds[to]!;
}
