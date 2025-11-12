import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, size: 26),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount:5 ,
        itemBuilder: (context,index){
          return ListTile(
            title: Text('Mahfujar'),
            subtitle: Text('mahfuj'),
          );
        }),
    );
  }
}