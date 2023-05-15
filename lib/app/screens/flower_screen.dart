// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:info_directory/app/screens/flower_details_screen.dart';

import '../Database/info_data.dart';
import '../modles/flower.dart';
import '../widgets/Item_card.dart';

class FlowerScreen extends StatefulWidget {
  const FlowerScreen({super.key});

  @override
  State<FlowerScreen> createState() => _FlowerScreenState();
}

class _FlowerScreenState extends State<FlowerScreen> {
  final infoData = InfoData();

  List<Flower> flowerList = [];
  List<Flower> filterFlowerList = [];

  bool searching = false;

  getFlowers() {
    flowerList.clear();
    filterFlowerList.clear();

    for (var item in infoData.flowers) {
      var flower = Flower.fromJson(item);

      flowerList.add(flower);
      filterFlowerList.add(flower);
    }
    setState(() {});
  }

  searchItem(String keyword) {
    List<Flower> results = [];

    if (keyword.isEmpty) {
      results = flowerList;
    } else {
      results = flowerList
          .where((item) =>
              item.name!.toLowerCase().contains(keyword.trim().toLowerCase()) ||
              item.description!
                  .toLowerCase()
                  .contains(keyword.trim().toLowerCase()))
          .toList();
    }
    if (filterFlowerList.isNotEmpty) {
      filterFlowerList.clear();
      filterFlowerList.addAll(results);
    } else {
      filterFlowerList = results;
    }
    setState(() {});
  }

  @override
  void initState() {
    getFlowers();
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
            : Text('Flower List'),
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
          child: filterFlowerList.isNotEmpty
              ? ListView(
                  children: List.generate(filterFlowerList.length, (index) {
                  var flower = filterFlowerList[index];
                  return ListCard(
                    name: flower.name ?? "",
                    image: flower.image ?? "",
                    description: flower.description ?? "",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FlowerDetailsScreen(
                            flower: flower,
                          ),
                        ),
                      );
                    },
                  );
                }))
              : Center(
                  child: Text('No Item'),
                ),
        ),
      ),
    );
  }
}
