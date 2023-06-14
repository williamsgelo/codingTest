class Message {
  final String subject;
  final String message;
  final String display;

  Message({
    required this.subject,
    required this.message,
    required this.display,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      subject: json['subject'],
      message: json['message'],
      display: json['display'],
    );
  }
}
