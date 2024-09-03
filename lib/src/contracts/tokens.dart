class AzureTokens {
  String identity;
  String token;
  DateTime expiresOn;

  AzureTokens(
      {required this.token, required this.identity, required this.expiresOn});

  factory AzureTokens.fromMap(Map<String, dynamic> map) {
    return AzureTokens(
        identity: map["identity"],
        token: map["token"],
        expiresOn: DateTime.parse(map["expiresOn"]));
  }

  Map<String, dynamic> toMap() => {
        "identity": identity,
        "token": token,
        "expires_on": expiresOn.toIso8601String()
      };
}

class DyteTokens {
  String participantId;
  String token;
  String dyteParticipantId;

  DyteTokens(
      {required this.token, required this.participantId, required this.dyteParticipantId});

  factory DyteTokens.fromMap(Map<String, dynamic> map) {
    return DyteTokens(
        participantId: map["participant_id"],
        token: map["token"],
        dyteParticipantId: map["dyte_participant_id"]);
  }

  Map<String, dynamic> toMap() => {
        "participant_id": participantId,
        "token": token,
        "dyte_participant_id": dyteParticipantId
      };
}