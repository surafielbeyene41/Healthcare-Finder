class Doctor {
  final String id;
  final String name;
  final String specialty;
  final List<String> availableSlots;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.availableSlots,
  });
}