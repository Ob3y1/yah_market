import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {


    void _showLogoutDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("asdsds"),
            content: Text("Are you sure you want to logout?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                 Get.toNamed('log');
                },
                child: Text("Logout"),
              ),
            ],
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Sigin In"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
          SizedBox(width: 10,),
          IconButton(onPressed: (){
            Get.toNamed('edite');
          }, icon: Icon(Icons.logout))
        ],
      ),
   body:    SafeArea(child: Container(



   ))
    );
  }
}