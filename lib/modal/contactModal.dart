class ContactModal
{
  int phone,id;
  String name,email;

  ContactModal({required this.id,required this.phone,required this.name,required this.email});

  factory ContactModal.fromMap(Map m1)
  {
    return ContactModal(id: m1['id'],phone: m1['phone'], name: m1['name'], email: m1['email']);
  }
}

Map toMap(ContactModal contact)
{
  return {
    'id' : contact.id,
    'name' : contact.name,
    'phone' : contact.phone,
    'email' : contact.email,
  };
}