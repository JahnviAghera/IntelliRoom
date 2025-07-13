class AuditEntry {
  final int id;
  final String timestamp;
  final String action;
  final String status;
  final String location;
  final String ip;
  final String device;
  final String details;

  AuditEntry({
    required this.id,
    required this.timestamp,
    required this.action,
    required this.status,
    required this.location,
    required this.ip,
    required this.device,
    required this.details,
  });
}
