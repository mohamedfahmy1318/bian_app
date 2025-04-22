import 'package:film/features/tabs/prayer/domain/entities/pray_time_entity.dart';

class PrayTimeDm extends PrayTimeEntity {
  PrayTimeDm({
    super.code,
    super.status,
    super.data,
  });

  PrayTimeDm.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? DataTimeDm.fromJson(json['data']) : null;
  }
}

class DataTimeDm extends DataTimeEntity {
  DataTimeDm({
    super.timings,
  });

  DataTimeDm.fromJson(dynamic json) {
    timings =
        json['timings'] != null ? PrayTimingDm.fromJson(json['timings']) : null;
  }
}

class PrayTimingDm extends PrayTimingEntity {
  PrayTimingDm({
    super.fajr,
    super.sunrise,
    super.dhuhr,
    super.asr,
    super.sunset,
    super.maghrib,
    super.isha,
    super.imsak,
    super.midnight,
    super.firstthird,
    super.lastthird,
  });

  PrayTimingDm.fromJson(dynamic json) {
    fajr = json['Fajr'];
    sunrise = json['Sunrise'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    sunset = json['Sunset'];
    maghrib = json['Maghrib'];
    isha = json['Isha'];
    imsak = json['Imsak'];
    midnight = json['Midnight'];
    firstthird = json['Firstthird'];
    lastthird = json['Lastthird'];
  }
}
