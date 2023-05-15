// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:info_directory/app/Database/info_data.dart';
import 'package:info_directory/app/modles/fruit.dart';
import 'package:info_directory/app/screens/fruit_details_screen.dart';

import '../widgets/Item_card.dart';

class FruitScreen extends StatefulWidget {
  const FruitScreen({super.key});

  @override
  State<FruitScreen> createState() => _FruitScreenState();
}

class _FruitScreenState extends State<FruitScreen> {
  final infoData = InfoData();

  List<Fruit> fruitList = [];
  List<Fruit> filterFruitList = [];

  bool searching = false;

  getFruit() {
    fruitList.clear();
    filterFruitList.clear();
    for (var item in infoData.fruits) {
      var fruit = Fruit.fromJson(item);

      fruitList.add(fruit);
      filterFruitList.add(fruit);
    }
    setState(() {});
  }

  searchItem(String keyword) {
    List<Fruit> results = [];

    if (keyword.isEmpty) {
      results = fruitList;
    } else {
      results = fruitList
          .where((item) =>
              item.name!.toLowerCase().contains(keyword.trim().toLowerCase()) ||
              item.description!
                  .toLowerCase()
                  .contains(keyword.trim().toLowerCase()))
          .toList();
    }
    if (filterFruitList.isNotEmpty) {
      filterFruitList.clear();
      filterFruitList.addAll(results);
    } else {
      filterFruitList = results;
    }
    setState(() {});
  }

  @override
  void initState() {
    getFruit();
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
            : Text('Fruit List'),
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
          child: filterFruitList.isNotEmpty
              ? ListView(
                  children: List.generate(filterFruitList.length, (index) {
                  var fruit = filterFruitList[index];
                  return ListCard(
                    name: fruit.name ?? "",
                    image: fruit.image ?? "",
                    description: fruit.description ?? "",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FruitDetailsScreen(
                            fruit: fruit,
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
