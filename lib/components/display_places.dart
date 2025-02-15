import 'dart:developer';

import 'package:airbnb/provider/favorite_provider.dart';
import 'package:airbnb/view/place_details/place_detail_screen.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayPlaces extends StatefulWidget {
  const DisplayPlaces({super.key});

  @override
  State<DisplayPlaces> createState() => _DisplayPlacesState();
}

class _DisplayPlacesState extends State<DisplayPlaces> {
  final CollectionReference placeCollection = FirebaseFirestore.instance.collection("myAppCpollection");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = FavoriteProvider.of(context);
    return StreamBuilder(
        stream: placeCollection.snapshots(),
        builder: (context, steamSnapshot) {
          if (steamSnapshot.hasData) {
            return ListView.builder(
              itemCount: steamSnapshot.data!.docs.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final place = steamSnapshot.data!.docs[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => PlaceDetailScreen(place: place)));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                height: 375,
                                width: double.infinity,
                                child: AnotherCarousel(
                                  images: place['imageUrls'].map((url) => NetworkImage(url)).toList(),
                                  dotIncreaseSize: 6,
                                  indicatorBgPadding: 5,
                                  dotBgColor: Colors.transparent,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 15,
                              right: 15,
                              child: Row(
                                children: [
                                  place['isActive'] == true
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(40),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 5,
                                            ),
                                            child: Text(
                                              "GuestFavorite",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: size.width * .03,
                                        ),
                                  Spacer(),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        Icons.favorite_outline_rounded,
                                        size: 34,
                                        color: Colors.white,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          provider.toggleFavorite(place);
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: provider.isExist(place) ? Colors.red : Colors.black54,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            vendorProfile(place)
                          ],
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        Row(
                          children: [
                            Text(
                              place['address'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.star),
                            SizedBox(width: 5),
                            Text(place['rating'].toString()),
                          ],
                        ),
                        Text(
                          "Stay with ${place['vendor']} . ${place['vendorProfession']}",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.5,
                          ),
                        ),
                        Text(
                          place['date'],
                          style: TextStyle(
                            fontSize: 16.5,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: size.height * .007),
                        RichText(
                          text: TextSpan(
                              text: "\$${place['price']}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: " night",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(height: size.height * .03)
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Positioned vendorProfile(QueryDocumentSnapshot<Object?> place) {
    return Positioned(
      bottom: 11,
      left: 10,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: Image.asset(
              "asset/images/book_cover.png",
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                place['vendorProfile'],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
