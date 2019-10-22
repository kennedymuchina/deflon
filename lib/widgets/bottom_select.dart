

import 'package:deflon/pages/book_ride.dart';
import 'package:flutter/material.dart';

class BottomSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: (){
              // print('search button clicked');
              Navigator.push(context, MaterialPageRoute(builder: (_) => BookRide()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2.0,
                    spreadRadius: 2.0
                  )
                ]
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                  child: FlatButton.icon(color: Colors.white, onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => BookRide()));
                  },
                  icon: Icon(Icons.search),
                  label: Text('Where to?')))),
          ),
        ),
        ListTile(
            leading: Icon(Icons.history),
            title: Text('The Junction Mall'),
            subtitle: Text('Ngong Road, Nairobi, Kenya'),
          ),
        ListTile(
            leading: Icon(Icons.history),
            title: Text('Owashika Road'),
            subtitle: Text('Lavington, Nairobi, Kenya'),
        ),
      ],
    );
  }
}
