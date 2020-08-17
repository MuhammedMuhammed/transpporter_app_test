import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
   paymentMethod mpay;
   

  user({
    this.id,
    this.username,
    this.email,
    this.password,
    this.userrole,
    this.birthDate,
    this.userImg,
    this.lat,
    this.lng,
    this.mpay = paymentMethod.cash
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
      'lat':lat,
      'lng':lng,
      'mpay':mpay
    };
  }



}

enum userRole{
  driver,
  passenger,
  manager
}

enum paymentMethod{
  cash,
  bankAccount,
  paypal,
}

Future<void> insertUser(user u)async{
  final Future<Database> database = openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'transporterDatabase.db'),
);
final Database db = await database;
  db.insert("users", u.userstoMap(),
  conflictAlgorithm: ConflictAlgorithm.replace);

}

Future<List<user>> users() async{
  final Future<Database> database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'transporterDatabase.db'),
  );
  final Database db = await database;

  final List<Map<String,dynamic>> maps = await db.query('user');
  return List.generate(
    maps.length,
    (i){
      return user(
      id: maps[i]['id'],
      username: maps[i]['username'],
      email:maps[i]['email'],
      password: maps[i]['password'],
      userrole: maps[i]['userrole'],
      birthDate:maps[i]['birthDate'],
      userImg:maps[i]['userImg'],
      lat:maps[i]['lat'],
      lng:maps[i]['lng'],
      mpay:maps[i]['mpay']
      );
    }
      );
}
Future<List<user>> currentUsers(String email,String password) async{
  final Future<Database> database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'transporterDatabase.db'),
  );
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db.query('user'
  ,where: 'email = ? AND password =?',
  whereArgs: [email,password]);
  return List.generate(
    maps.length,
    (i){
      return user(
      id: maps[i]['id'],
      username: maps[i]['username'],
      email:maps[i]['email'],
      password: maps[i]['password'],
      userrole: userRole.values[maps[i]['userrole']],
      birthDate:maps[i]['birthDate'],
      userImg:maps[i]['userImg'],
      lat:maps[i]['lat'],
      lng:maps[i]['lng'],
      mpay:paymentMethod.values[maps[i]['mpay']]
      );
    }
      );
}

Future<void> updateUser(user u)async{
 final Future<Database> database = openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'transporterDatabase.db'),
  );
  
  Database db = await database;
  await db.update("users", 
  u.userstoMap(),
  where: "id =?",
  whereArgs: [u.id]);
}

Future<void> deleteUser(int id) async {
  // Get a reference to the database.
 final Future<Database> database = openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'transporterDatabase.db'),
  );

  final db = await database;

  // Remove the Dog from the Database.
  await db.delete(
    'users',
    // Use a `where` clause to delete a specific dog.
    where: "id = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}


