import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CompanyName  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'A',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 16
              ),
            ),
            const Text(
              'mogus',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: 16
              ),
            ),
            IconButton(
              icon: Icon(Feather.layout),
              color: Colors.white,
              onPressed: (){},
            )
        ]),
      ),
    );
  }
}