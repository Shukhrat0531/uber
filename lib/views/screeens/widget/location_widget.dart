import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/store-1.png',
              width: 30,
            ),
            SizedBox(width: 15,),
            Image.asset(
              'assets/icons/pickicon.png',
              width: 30,
            ),
            SizedBox(width: 8,),
            Flexible(child: SizedBox(
              width: 300,
              child: TextFormField(
                decoration: InputDecoration(
                  
                  hintText: 'Current loaction',
                  labelText: 'Current loaction',
                  border: InputBorder.none,
                  isDense: true
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
