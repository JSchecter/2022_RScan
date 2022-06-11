import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rscan/scan_qr.dart';
import 'package:rscan/values.dart';

class RScan extends StatelessWidget {
  const RScan({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RScan',
      // theme: ThemeData(
      //   primarySwatch: Colors.red,
      // ),
      home: const SelectLocation(title: 'SelectLocation'),
    );
  }
}

class SelectLocation extends StatefulWidget {
  const SelectLocation({Key? key, required this.title}) : super(key: key);
  final String title;


  // Positioned(
  // child: Text("${widget.date.day} ${monthAsString(widget.date.month)} ${widget.date.hour}:${widget.date.minute} EST"),
  // top: 680,
  // left: 58,
  // ),

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> with TickerProviderStateMixin {
  int _counter = 0;
  DateTime? date = DateTime.now();
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(context,  MaterialPageRoute(builder: (context) => MyHome()));
          },
          icon: Icon(Icons.close,size: 30,),
        ),
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset("assets/greencheck.json",width: 100,height: 100),
            Text(Values.locationName.toString(),

              style: Theme.of(context).textTheme.headline4,
            ),
            Positioned(
              child: Text("${date!.day} ${monthAsString(date!.month)} ${date!.hour}:${date!.minute} WIB"),
              top: 680,
              left: 58,
            ),
          ],
        ),
      ),
      // OFF : Blue Icon
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

String monthAsString(int monthNumber) {
  if (monthNumber == 1) {
    return "January 2022,";
  } else if (monthNumber == 2) {
    return "February 2022,";
  } else if (monthNumber == 3) {
    return "March 2022,";
  } else if (monthNumber == 4) {
    return "April 2022,";
  } else if (monthNumber == 5) {
    return "May 2022,";
  } else if (monthNumber == 6) {
    return "June 2022,";
  } else if (monthNumber == 7) {
    return "July 2022,";
  } else if (monthNumber == 8) {
    return "August 2022,";
  } else if (monthNumber == 9) {
    return "September 2022,";
  } else if (monthNumber == 10) {
    return "October 2022,";
  } else if (monthNumber == 11) {
    return "November 2022,";
  } else {
    return "December";
  }
}
