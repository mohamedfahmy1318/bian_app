class PrayTimeEntity {
  PrayTimeEntity({
    this.code,
    this.status,
    this.data,
  });

  num? code;
  String? status;
  DataTimeEntity? data;
}

class DataTimeEntity {
  DataTimeEntity({
    this.timings,
  });

  PrayTimingEntity? timings;
}

class PrayTimingEntity {
  PrayTimingEntity({
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.imsak,
    this.midnight,
    this.firstthird,
    this.lastthird,
  });

  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? imsak;
  String? midnight;
  String? firstthird;
  String? lastthird;
}
