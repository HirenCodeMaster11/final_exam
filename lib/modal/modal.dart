class TodoModal
{
  late int id;
  late String title,status,description;
  DateTime date;

  TodoModal({required this.id,required this.title,required this.date,required this.status,required this.description,});

  factory TodoModal.fromMap(Map m1)
  {
    return TodoModal(id: m1['id'], title: m1['title'],date: m1['date'],status: m1['status'],description: m1['description']);
  }
}

Map toMap(TodoModal todo)
{
  return {
    'id' : todo.id,
    'title' : todo.title,
    'date' : todo.date,
    'status' : todo.status,
    'description' : todo.description,
  };
}
