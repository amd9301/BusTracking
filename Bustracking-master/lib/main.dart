import 'package:flutter/material.dart';
import 'package:bustracking/screen/google_map_screen.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Bus Tracking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget{
  static var position;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool mapToggle =false;
   var position ;


  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Clg bus tracking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.location_on,size:45.0,color:Colors.blue,),
            SizedBox(height:10.0),
            Text(
                'click on the icon to track your bus',
                style: TextStyle(fontSize:24,
                    fontWeight: FontWeight.bold
                )
            ),
            SizedBox(height:10.0),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:()=>Navigator.push(
          context,
          MaterialPageRoute(
            builder:(context)=>GoogleMapScreen(),
        ),
        ),
        tooltip: 'Google Map',
        child: Icon(Icons.pin_drop_outlined,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    )
    );
}
}