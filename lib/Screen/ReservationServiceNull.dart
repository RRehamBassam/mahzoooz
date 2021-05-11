import 'package:flutter/material.dart';
class ReservationServiceNull extends StatefulWidget {
  @override
  _ReservationServiceNullState createState() => _ReservationServiceNullState();
}

class _ReservationServiceNullState extends State<ReservationServiceNull> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("لايوجد مواعيد للحجز")
        ],
      ),
    );
  }
}
