// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:info_directory/app/Database/info_data.dart';
import 'package:info_directory/app/modles/bird.dart';
import 'package:info_directory/app/screens/bird_detalis_screen.dart';

import '../widgets/Item_card.dart';

class BirdScreen extends StatefulWidget {
  const BirdScreen({super.key});

  @override
  State<BirdScreen> createState() => _BirdScreenState();
}

class _BirdScreenState extends State<BirdScreen> {
  final infoData = InfoData();

  List<Bird> birdList = [];
  List<Bird> filterBirdList = [];

  bool searching = false;

  getBird() {
    birdList.clear();
    filterBirdList.clear();
    for (var item in infoData.birds) {
      var bird = Bird.fromJson(item);

      birdList.add(bird);
      filterBirdList.add(bird);
    }
    setState(() {});
  }

  searchItem(String keyword) {
    List<Bird> results = [];

    if (keyword.isEmpty) {
      results = birdList;
    } else {
      results = birdList
          .where((item) =>
              item.name!.toLowerCase().contains(keyword.trim().toLowerCase()) ||
              item.description!
                  .toLowerCase()
                  .contains(keyword.trim().toLowerCase()))
          .toList();
    }
    if (filterBirdList.isNotEmpty) {
      filterBirdList.clear();
      filterBirdList.addAll(results);
    } else {
      filterBirdList = results;
    }
    setState(() {});
  }

  @override
  void initState() {
    getBird();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: searching
            ? TextFormField(
                style: TextStyle(fontSize: 17),
                decoration: InputDecoration(
                  hintText: 'Search by name',
                  fillColor: Colors.white70,
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        searching = false;
                      });
                    },
                    child: Icon(Icons.close),
                  ),
                ),
                onChanged: (value) {
                  searchItem(value);
                },
              )
            : Text('Bird List'),
        centerTitle: true,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                searching = true;
              });
            },
            child: searching ? Container() : Icon(Icons.search),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: filterBirdList.isNotEmpty
              ? ListView(
                  children: List.generate(filterBirdList.length, (index) {
                  var bird = filterBirdList[index];
                  return ListCard(
                    name: bird.name ?? "",
                    image: bird.image ?? "",
                    description: bird.description ?? "",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BirdDetailsScreen(
                            bird: bird,
                          ),
                        ),
                      );
                    },
                  );
                }))
              : Center(
                  child: Text('No item'),
                ),
        ),
      ),
    );
  }
}
