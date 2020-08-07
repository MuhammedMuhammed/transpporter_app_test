class user{
   int id;
   String username;
   String email;
   String password;
   String userImg;
   userRole userrole;
   DateTime birthDate;
   double lat;
   double lng;

  user({
    this.id,
    this.username,
    this.email,
    this.password,
    this.userrole,
    this.birthDate,
    this.userImg,
    this.lat,
    this.lng
  })
  {
    userstoMap();
  }
  
  Map<String, dynamic> userstoMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'userImg': userImg,
      'userrole': userrole,
      'birthDate':birthDate,
    };
  }

}

enum userRole{
  driver,
  passenger,
  manager
}

