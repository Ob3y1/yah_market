import 'package:flutter/material.dart';
import 'package:flutter_application_task/Components/custom_button.dart';


class Welcome extends StatelessWidget {
  Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 48, 45, 45),
          Color.fromARGB(255, 226, 226, 226),
        ])),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 100,
          ),
          const Text(
            'Welcome ',
            style:
                TextStyle(fontSize: 30, color: Color.fromARGB(255, 235, 232, 232)),
          ),
          const SizedBox(
            height: 30,
          ),

          // GestureDetector(
          //   onTap: (){
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) =>  Sigin()));
          //   },
          // child:

          SizedBox(
            height: 30,
          ),
          //  GestureDetector(
          //    onTap: (){
          //      Navigator.push(context,
          //          MaterialPageRoute(builder: (context) => const Login()));
          //    },
          //  child:
          CustomButton(
            width: 300,
            height: 50,
            ButtonColor: Color.fromARGB(255, 71, 67, 67),
            buttonName: "Sigin In",
            fontColor: const Color.fromARGB(255, 255, 248, 248),
            fontSize: 20,
            onTap: () {
              print("asasasa");
            },
          ),
          SizedBox(
            height: 20,
          ),
          CustomButton(
            width: 300,
            height: 50,
      ButtonColor: Color.fromARGB(255, 66, 62, 62),
            buttonName: "Sigin Up ",
        fontColor: const Color.fromARGB(255, 255, 248, 248),
            fontSize: 20,
            onTap: () {
              print("object");
            },
          ),
        ]),
      ),
    );
  }
}
