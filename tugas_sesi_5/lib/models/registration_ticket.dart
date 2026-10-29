class RegistrationTicket {
  final String id;
  final String eventTitle;
  final String fullName;
  final String nim;
  final String email;
  final String whatsapp;
  final String participantType;
  final String attendanceDate;
  final String seminarKit;
  final bool agreedToTerms;

  RegistrationTicket({
    required this.id,
    required this.eventTitle,
    required this.fullName,
    required this.nim,
    required this.email,
    required this.whatsapp,
    required this.participantType,
    required this.attendanceDate,
    required this.seminarKit,
    required this.agreedToTerms,
  });
}