import 'dart:async';
import 'package:flutter/material.dart';
import 'Login.dart';
class EditProfile extends StatelessWidget{

TextEditingController phoneEditingController = new TextEditingController();
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  
  @override
  Widget build(BuildContext context)
  {
    

    return  Scaffold(

    body:Container(
              color: Colors.lime,
              child: Center(

                child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,

                  children:<Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                    child:TextField(
                      decoration: InputDecoration(
                        
                        filled: true,
                        border:InputBorder.none,
                        fillColor: Colors.white,
                        hintText: "Email",
                      )
                      ,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailEditingController)),
                  Padding(
                      padding: EdgeInsets.all(5),
                    child:TextField(
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        hintText: "Password",
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordEditingController,)),
                    
                    Padding(
                      padding: EdgeInsets.all(5),
                    child:TextField(
                    decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        hintText: "Phone",
                      ),
                    keyboardType: TextInputType.phone,
                    controller: phoneEditingController,)),
                      // CheckboxListTile(
                      //   key: Key("isDriver"),
                      //   value: driver,
                      //   onChanged:(value){
                          
                      //   setState((){ driver =value;
                      
                      //   emailEditingController.text = emailEditingController.text;
                      //   passwordEditingController.text = passwordEditingController.text;  });
                      //     print(driver.toString());                  
                      //                        }
                      //                        ,
                      //   title: Text("driver"),
                      //   controlAffinity: ListTileControlAffinity.leading,
                        
                      // ),
                    FlatButton(onPressed: (){
                      
                      curUser.username= "MUHD";
                      curUser.password= passwordEditingController.text;
                      
                      curUser.birthDate= DateTime.parse("1969-07-20 20:18:04");
                      curUser.userImg="";
                      curUser.email= emailEditingController.text;
                                       }, child: Text("Edit"))

                  ]
                )), 
                
              ));

  }


}