import 'package:amdha_communication_lib/src/enums/dyte_meeting_status.dart';

class AmdhaMeeting {
  late String meetingId;
  late DateTime createdOn;

  AmdhaMeeting({required this.meetingId, required this.createdOn});

  factory AmdhaMeeting.fromMap(Map<String, dynamic> map) {
    return AmdhaMeeting(
        createdOn: DateTime.parse(map["created_on"]),
        meetingId: map["meeting_id"]);
  }

  Map<String, dynamic> toMap() =>
      {"meeting_id": meetingId, "created_on": createdOn.toIso8601String()};
}

class AzureAmdhaMeeting extends AmdhaMeeting {
  DateTime validFrom;
  DateTime validUntil;

  AzureAmdhaMeeting(
      {required super.meetingId,
      required super.createdOn,
      required this.validFrom,
      required this.validUntil});

  factory AzureAmdhaMeeting.fromMap(Map<String, dynamic> map) {
    AmdhaMeeting obj = AmdhaMeeting.fromMap(map);
    return AzureAmdhaMeeting(
        meetingId: obj.meetingId,
        createdOn: obj.createdOn,
        validFrom: DateTime.parse(map["valid_from"]),
        validUntil: DateTime.parse(map["valid_until"]));
  }

  @override
  Map<String, dynamic> toMap() => {
        "meeting_id": meetingId,
        "created_on": createdOn.toIso8601String(),
        "valid_from": validFrom.toIso8601String(),
        "valid_until": validUntil.toIso8601String()
      };
}

class DyteAmdhaMeeting extends AmdhaMeeting {
  DyteMeetingStatus status;

  DyteAmdhaMeeting(
      {required super.meetingId,
      required super.createdOn,
      required this.status});

  factory DyteAmdhaMeeting.fromMap(Map<String, dynamic> map) {
    AmdhaMeeting obj = AmdhaMeeting.fromMap(map);
    return DyteAmdhaMeeting(
        meetingId: obj.meetingId,
        createdOn: obj.createdOn,
        status: DyteMeetingStatus.values
            .firstWhere((e) => e.value == map['status']));
  }

  @override
  Map<String, dynamic> toMap() => {
        "meeting_id": meetingId,
        "created_on": createdOn.toIso8601String(),
        "status": status.value,
      };
}
