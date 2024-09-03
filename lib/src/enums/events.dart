enum WebViewEvents {

  onPageStarted("ON_PAGE_STARTED"),
  onPageFinished("ON_PAGE_FINISHED"),
  onPageProgress("ON_PAGE_PROGRESS");

  final String value;

  const WebViewEvents(this.value);
}

enum AmdhaMeetingEvents {

  meetingStarted("MEETING_STARTED"),
  meetingEnded("MEETING_ENDED"),
  participantAdded("PARTICIPANT_ADDED");

  final String value;

  const AmdhaMeetingEvents(this.value);
}