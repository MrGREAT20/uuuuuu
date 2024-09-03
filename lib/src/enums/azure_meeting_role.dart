enum AzureMeetingRole {
  presenter("Presenter"),
  attendee("Attendee"),
  consumer("Consumer");

  final String value;

  const AzureMeetingRole(this.value);
}
