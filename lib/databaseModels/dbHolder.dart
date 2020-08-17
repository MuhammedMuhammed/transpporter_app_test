import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
class dbHolder{
  String directory;
  List<io.FileSystemEntity> file = new List();

  // tableCreates Function Creates TableInDataBase
  tableCreates() async{
  final Future<Database> database = openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'transporterDatabase.db'),
  onCreate: (db,version)
  {
    
    db.execute("Create Table users(id INTEGER PRIMARY KEY AUTOINCREMENT,"+ 
    "username TEXT,"+ 
    "email TEXT,"+
     "birthdate TEXT," +
     "password TEXT,"+
     "userrole INT CHECK(pType IN (0,1)),"+
     "userImg TEXT,"+
     "lat DOUBLE,"+
     "lng DOUBLE,"+
     "mpay INT CHECK( pType IN (0,1,2) )"
     ")");
    db.execute("Create Table trips(id INTEGER PRIMARY KEY,"+ 
    "startPointLat DOUBLE,"+ 
    "startPointLng DOUBLE,"+
     "endPointLat DOUBLE," +
     "endPointLng DOUBLE,"+
     "routeLength DOUBLE,"+
     "price DOUBLE,"+
     "tripTime DATETIME,"+
     "driverId INTEGER,"+
     "tripText TEXT,"+
     "FOREIGN KEY(driverId) REFERENCES users(id)"
     ")");
  db.execute("Create Table usertrips(id INTEGER PRIMARY KEY AUTOINCREMENT,"+ 
    "tripId INTEGER,"+ 
    "userId INTEGER,"+
     "passengerNum INTEGER," +
     "amount DOUBLE,"+
     "isfinished BOOLEAN,"+
     "hasDiscount BOOLEAN,"+
     "isPaid BOOLEAN,"+
    "FOREIGN KEY(userId) REFERENCES users(id),"+
    "FOREIGN KEY(tripId) REFERENCES trips(id),"+
     ")");

   db.execute("Create Table PaymentMethodsData(id INTEGER PRIMARY KEY AUTOINCREMENT,"+ 
    "method INT CHECK( pType IN (0,1,2) ),"+ 
    "userId INTEGER,"+
    "FOREIGN KEY(userId) REFERENCES users(id),"+
     ")"); 
      return db;
       },
  version: 1,
);
}
void _listofFiles() async {
        // directory = (await getApplicationDocumentsDirectory()).path;
        file = io.Directory("/").listSync();
        
        for (var fileItem in file) {
          if(basename(fileItem.path) != "dbHolder.dart" && basename(fileItem.path) != "dbHolder.dbSample")
          {
            
          }

         }  //use your folder name insted of resume.
      }
}