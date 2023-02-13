import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){

  runApp(const MyClock());
}

class MyClock extends StatefulWidget {
  const MyClock({Key? key}) : super(key: key);

  @override
  State<MyClock> createState() => _MyClockState();
}

class _MyClockState extends State<MyClock> {
  Timer? timer;

  final TextEditingController Thoughtscontroller = TextEditingController();

  String Thoughts = '' ;
  String SaveTime = '' ;

  updateSeconds() {
    timer = Timer.periodic(
      Duration(seconds: 1),
          (Timer timer) => setState(
            () {},
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    updateSeconds();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Builder(

        builder: (BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              actions: [InkWell(
                onTap: (){
                  setState(() {

                  });
                },
                  child: Icon(Icons.save,color: Colors.black,size: 40,))],
              backgroundColor: Colors.white54,
              title: Text("MY CLOCK",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                SizedBox(height: 130),
                Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 5,
                            blurRadius: 15,
                            color: Colors.black,
                          ),
                        ],
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        SaveTime =
                        "${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour} : ${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute} : ${DateTime.now().second < 10 ? "0${DateTime.now().second}" : DateTime.now().second} ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  color: Colors.white70,
                  child: SizedBox(
                    width: 180,
                    height: 50,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: Thoughtscontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Thoughts",
                        hintText: "Your Thoughts",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  child: Text(
                    "Save Data",
                    style: TextStyle(color: Colors.black,fontSize: 25),
                  ),
                  onPressed: () async {
                    setData() async {
                      SharedPreferences pref =
                      await SharedPreferences.getInstance();

                      await pref.setString('thoughts', Thoughtscontroller.text) ?? '';
                      await pref.setString('currently',"${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour} : ${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute} : ${DateTime.now().second < 10 ? "0${DateTime.now().second}" : DateTime.now().second}");
                    }
                    SharedPreferences pref =
                    await SharedPreferences.getInstance();

                    print(pref.getString('thoughts'));
                    print(pref.getString('currently'));

                    setState(() {
                      setData();
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  }
