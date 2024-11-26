class AttendanceModal
{
  late int id;
  late String name,room,date,status;

  AttendanceModal({required this.id,required this.name,required this.room,required this.date,required this.status});

  factory AttendanceModal.fromMap(Map m1)
  {
    return AttendanceModal(id: m1['id'], name: m1['name'], room: m1['room'], date: m1['date'], status: m1['status']);
  }
}

Map toMap(AttendanceModal attendance)
{
  return {
    'id' : attendance.id,
    'name' : attendance.name,
    'room' : attendance.room,
    'date' : attendance.date,
    'status' : attendance.status,
  };
}


