import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(FontAwesomeIcons.bolt, color: Color.fromRGBO(236, 181, 15, 1),),
                    )),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  child: Text('To'),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  child: Text('To'),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}