import 'package:flutter/material.dart';

class MapWithCustomInfoWindows extends StatefulWidget {
  const MapWithCustomInfoWindows({super.key});

  @override
  State<MapWithCustomInfoWindows> createState() => _MapWithCustomInfoWindowsState();
}

class _MapWithCustomInfoWindowsState extends State<MapWithCustomInfoWindows> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FloatingActionButton.extended(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          showModalBottomSheet(
              clipBehavior: Clip.none,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: Colors.white,
                  height: size.height * .77,
                  width: size.width,
                );
              });
        },
        label: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Text(
                "Map",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.map_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 5),
            ],
          ),
        ));
  }
}
