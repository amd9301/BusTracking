import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../direction_model.dart';
import '../directions_repository.dart';
import '../screen/netpie2020.dart';
import 'DistancePage.dart';


class GoogleMapScreen extends StatefulWidget {


  
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen>
{
  NETPIE2020 netpie2020;
  Set<Marker> _markers ={ };
  double x=17.7184 ;
  double y =83.3188 ;
  double latitude;
  double longitude;
  double _latitude =1;
  double _longitude =1;
  var locationMessage ="";
  Directions _info;
  var distance;
  //Latitudes and longitudes of buses
  double b1lat=17.7184;
  double b1long=83.3188;
  double b2lat=17.7142;
  double b2long=83.3237;
  double b3lat=17.777122;
  double b3long=83.361575;
  double b4lat=17.8205;
  double b4long=83.3423;
  var distanceInMeters;
  Future<double> get_location() async

  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    _latitude= position.latitude;
    return position.longitude;
  }

  distanceBetween(lat1,long1,lat2,long2)
  {
    distanceInMeters = Geolocator.distanceBetween(lat1, long1, lat2, long2);
    print("distance");
    print(distanceInMeters/1000);
    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder:(context)=>DistancePage(),
      ),
    );*/

  }


  void myNew()  async{
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    print(position.latitude);
    latitude =17.7204;
    longitude =83.3168;
     }

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(17.7294,83.3093),
    zoom: 14.5,
  );

   _newmethod1(){
    double _locationinmeters = GeolocatorPlatform.instance.distanceBetween(latitude,longitude,17.7294,83.3093);
     distance = _locationinmeters;

  }
  //This is for pressing the text buttons in appbar
  OnPressedFunction(latitude,longitude)
  async {
    final GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(latitude,longitude),
            zoom: 18.5,
            tilt: 60.0),
      ),
    );
    distanceBetween(_latitude, _longitude,latitude,longitude);
  }

  onMarkerPressed(latitude,longitude)
  {
    distanceBetween(_latitude, _longitude,latitude,longitude);
  }

  Completer<GoogleMapController> _controller = Completer();
  Marker _home;
  Marker _bus1; 
  Marker _bus2;
  Marker _bus3;
  Marker _bus4;


  Future<void> _onMapCreated(GoogleMapController controller) async {

    _controller.complete(controller);
    
    setState(() {
      _markers.add(
       _home= new Marker(markerId: MarkerId('1'),
        position:  new LatLng(_latitude,_longitude),
        infoWindow: InfoWindow(
          title: 'home',
          snippet: 'user home',
        )
        ),        
      );
      
    });
    setState(() {
      _markers.add(
     _bus1= Marker(markerId: MarkerId('2'),
        position: new LatLng(x,y),
        infoWindow: InfoWindow(
          title: 'bus 1',
        snippet: 'this bus is at a distance of 8 Km from home ',
          onTap: ()=>onMarkerPressed(x, y)
        )
      )
        );
     
    });
    setState(() {
      _markers.add(
       _bus2= Marker(markerId: MarkerId('3'),
        position:  new LatLng(17.7142,83.3237),
        infoWindow: InfoWindow(
          title: 'Bus 2',
        snippet: 'the bus is  at a distance of 1.1 km ',

        )
        )
      );
    });
    setState(() {
      _markers.add(
      _bus3=  Marker(markerId: MarkerId('4'),
        position: new  LatLng(17.777122,83.361575),
        infoWindow: InfoWindow(
          title: 'bus 3',
        snippet: 'this bus is at yendada junction at a distance of 8.1 Km from rk beach takes 19 min',

        )
        )
      );
    });
     setState(() {
      _markers.add(
       Marker(markerId: MarkerId('5'),
        position: LatLng(17.7413,83.3345),
        infoWindow: InfoWindow(
          title: 'bus 4',
        snippet: 'this bus is currently at mvp colony ',

                )
        )
      );
    });
    setState(() {
      _markers.add(
        _bus4= Marker(markerId: MarkerId('7'),
        position: LatLng(17.8205,83.3423),
        infoWindow: InfoWindow(
          title: 'bus 5',
        snippet: 'this  bus has reached college',

                )
        )
      );
    }
    );
    // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin:LatLng(17.7294,83.3093), destination: LatLng(17.8205,83.3423),);
      setState(() => _info = directions);
      
  }
  @override
   Widget build(BuildContext Context) {
    return Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.white,
          title: Text('Bus tracking'),
          centerTitle: true,
          actions: [
            if(_home != null)
          TextButton(
            onPressed: () => OnPressedFunction(_latitude,_longitude),
          child:Text("home"),
          ),
          TextButton(
              onPressed: ()=>OnPressedFunction(x,y) ,
              child:Text("bus 1")
          ),
          TextButton(
              onPressed: (){
                OnPressedFunction(b2lat,b2long);
    },
              child:Text("bus 2")
          ),
          TextButton(
              onPressed: () =>OnPressedFunction(b3lat,b3long)
              ,child:Text("bus 3")
          ),
          TextButton(
              onPressed: () => OnPressedFunction(b4lat,b4long),
              //  onLongPress: ()=>OnMarkerPressed(),
              child:Text("bus 4")
          )
          ],
        ),
        body:Stack(
          alignment: Alignment.center,
          children:[
            GoogleMap(
           onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target:LatLng(17.7294,83.3093),
              zoom:13.5,
               ),
        ),
       
         if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
              child: Text(
                 distance,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom:20,
              left: 10,
              child: new Text('${distanceInMeters/1000}'),

            ),
            Positioned(
                bottom: 30,
                left: 10,
                child: ElevatedButton(
              onPressed: ()async {
                _longitude= await get_location();
                print(_latitude);
                print(_longitude);
                setState(() {
                  _markers.add(
                      _bus2= Marker(
                          markerId: MarkerId('1'),
                          position:  new LatLng(_latitude,_longitude),
                          infoWindow: InfoWindow(
                            title: 'Home',
                            snippet: 'This is your location ',

                          )
                      )
                  );
                });
              },
              child: Text("Get Location"),
            ))
    ]
    
      ),
        floatingActionButton: FloatingActionButton(

        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () async {
           final GoogleMapController mapController = await _controller.future;
         mapController .animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info.bounds, 30.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        );
        },
          child:const Icon(Icons.center_focus_strong),
      ),
    );
  }
}