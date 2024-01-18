import 'package:flutter/material.dart';

class mydata extends StatefulWidget {
  const mydata({required Key key}) : super(key: key);

  @override
  _mydataState createState() {
    return _mydataState();
  }
}

class _mydataState extends State<mydata> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  const Column(
      children:[
        Text('data'),
        Text('My Data',style: TextStyle(color: Colors.black,height:25)),
      ]),
    );
  }
}