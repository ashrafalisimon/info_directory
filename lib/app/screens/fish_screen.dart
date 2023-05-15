// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:info_directory/app/Database/info_data.dart';
import 'package:info_directory/app/modles/fish.dart';
import 'package:info_directory/app/screens/fish_details_screen.dart';

import '../widgets/Item_card.dart';

class FishScreen extends StatefulWidget {
  const FishScreen({super.key});

  @override
  State<FishScreen> createState() => _FishScreenState();
}

class _FishScreenState extends State<FishScreen> {
  final infoData = InfoData();

  List<Fish> fishList = [];
  List<Fish> filterFishList = [];

  bool searching = false;

  getFish() {
    fishList.clear();
    filterFishList.clear();
    for (var item in infoData.fishes) {
      var fish = Fish.fromJson(item);

      fishList.add(fish);
      filterFishList.add(fish);
    }
    setState(() {});
  }

  searchItem(String keyword) {
    List<Fish> results = [];

    if (keyword.isEmpty) {
      results = fishList;
    } else {
      results = fishList
          .where((item) =>
              item.name!.toLowerCase().contains(keyword.trim().toLowerCase()) ||
              item.description!
                  .toLowerCase()
                  .contains(keyword.trim().toLowerCase()))
          .toList();
    }
    if (filterFishList.isNotEmpty) {
      filterFishList.clear();
      filterFishList.addAll(results);
    } else {
      filterFishList = results;
    }
    setState(() {});
  }

  @override
  void initState() {
    getFish();
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
            : Text('Fish List'),
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
          child: filterFishList.isNotEmpty
              ? ListView(
                  children: List.generate(filterFishList.length, (index) {
                  var fish = filterFishList[index];
                  return ListCard(
                    name: fish.name ?? "",
                    image: fish.image ?? "",
                    description: fish.description ?? "",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FishDetailsScreen(
                            fish: fish,
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
