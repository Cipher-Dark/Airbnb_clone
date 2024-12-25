import 'package:airbnb/components/my_icon_button.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> place;
  const PlaceDetailScreen({super.key, required this.place});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: size.height * .35,
                  child: AnotherCarousel(
                    images: widget.place['imageUrls'].map((url) => NetworkImage(url)).toList(),
                    showIndicator: false,
                    dotBgColor: Colors.transparent,
                    onImageChange: (p0, p1) {
                      setState(() {
                        currentIndex = p1;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black45,
                    ),
                    child: Text(
                      "${currentIndex + 1} / ${widget.place['imageUrls'].length}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  top: 25,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: MyIconButton(icon: Icons.arrow_back_ios_new),
                        ),
                        MyIconButton(icon: Icons.share_outlined),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {},
                          child: MyIconButton(icon: Icons.favorite_border),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
