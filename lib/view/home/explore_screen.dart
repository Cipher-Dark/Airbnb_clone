import 'package:airbnb/components/display_places.dart';
import 'package:airbnb/components/display_total_price.dart';
import 'package:airbnb/components/map_with_custom_info_windows.dart';
import 'package:airbnb/components/search_bar_and_filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final CollectionReference categoryCollection = FirebaseFirestore.instance.collection("AppCategory");
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SearchBarAndFilter(),
            listOfCategoryItems(size),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  DisplayTotalPrice(),
                  SizedBox(height: 15),
                  DisplayPlaces(),
                ],
              ),
            ))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MapWithCustomInfoWindows(),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> listOfCategoryItems(Size size) {
    return StreamBuilder(
      stream: categoryCollection.snapshots(),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.hasData) {
          return Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 80,
                child: Divider(
                  color: Colors.black12,
                ),
              ),
              SizedBox(
                height: size.height * .12,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: streamSnapshot.data!.docs.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectIndex = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 20,
                          right: 20,
                          left: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 32,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                streamSnapshot.data!.docs[index]['image'],
                                color: selectIndex == index ? Colors.black : Colors.black45,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              streamSnapshot.data!.docs[index]['title'],
                              style: TextStyle(
                                fontSize: 13,
                                color: selectIndex == index ? Colors.black : Colors.black45,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 3,
                              width: 50,
                              color: selectIndex == index ? Colors.black : Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}