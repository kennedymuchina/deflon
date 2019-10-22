// import 'package:deflon/provider/app_state.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
// // import 'package:permission/permission.dart';

// class MapsSelect extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
    
//     final appState = Provider.of<AppState>(context);
//     return appState.initialPosition == null ? Container(
//       height: double.infinity,
//       width: double.infinity,
//       color: Colors.white,
//       child: Center(
//         child: CircularProgressIndicator(),
//       ),
//     ) : SafeArea(
//       child: Scaffold(
//         body: Container(
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 child: MapsFullScreen()),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 130,
//                   color: Colors.white.withOpacity(0.9),
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextField(
//                           controller: appState.locationController,
//                           textInputAction: TextInputAction.go,
//                           onSubmitted: (value) {
//                             appState.sendRequest(value);
//                           },
//                           decoration: InputDecoration(
//                             fillColor: Colors.white,
//                             contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                             hintText: "Enter Pickup point",
//                             border:
//                                 OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
//                           // controller: _searchCotroller,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextField(
//                           decoration: InputDecoration(
//                             fillColor: Colors.white,
//                             contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                             hintText: "Enter destination",
//                             border:
//                                 OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
//                           controller: appState.departureController,
//                           textInputAction: TextInputAction.go,
//                           onSubmitted: (value) {
//                             appState.sendRequest(value);
//                           },// controller: _searchCotroller,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// class MapsFullScreen extends StatefulWidget {
//   @override
//   _MapsFullScreenState createState() => _MapsFullScreenState();
// }

// class _MapsFullScreenState extends State<MapsFullScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<AppState>(context);
//       return GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: appState.initialPosition, zoom: 15.0
//         ),
//         onMapCreated: appState.onCreated,
//         myLocationEnabled: true,
//         mapType: MapType.normal,
//         compassEnabled: false,
//         markers: appState.markers,
//         onCameraMove: appState.onCameraMove,
//         polylines: appState.polyLines,
//       );
//     }
//   }