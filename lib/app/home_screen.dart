// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'screens/bird_screen.dart';
import 'screens/fish_screen.dart';
import 'screens/flower_screen.dart';
import 'screens/fruit_screen.dart';
import 'widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Information Directory'),
        centerTitle: true,
        elevation: 0,
        // actions: [
        //   // IconButton(
        //   //     onPressed: () {
        //   //       print('Clicked...');
        //   //     },
        //   //     icon: Icon(Icons.notifications))

        //   GestureDetector(
        //       onDoubleTap: () {
        //         print('Clicked');
        //       },
        //       child: Icon(Icons.notification_add)),
        //   SizedBox(
        //     width: 15,
        //   ),
        // ],
      ),
      // drawer: Drawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CategoryCard(
                    name: 'Flower',
                    image:
                        'https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FlowerScreen()));
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CategoryCard(
                    name: 'Fruit',
                    image: 'https://thumbs.dreamstime.com/b/fruit-2999796.jpg',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FruitScreen()));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CategoryCard(
                    name: 'Bird',
                    image:
                        'https://images.pexels.com/photos/1661179/pexels-photo-1661179.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BirdScreen()));
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CategoryCard(
                    name: 'Fish',
                    image:
                        'https://spca.bc.ca/wp-content/uploads/fish-discus-swimming.jpg',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FishScreen()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
