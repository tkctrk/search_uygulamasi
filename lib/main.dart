import 'package:flutter/material.dart';

void Main()=>runApp(const SearchApp());
String secilen="";
class SearchApp extends StatelessWidget {
  const SearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
title:const Text("Search App"),
        actions: <Widget>[
          IconButton(
            icon:const Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: SearchVerileri());
            },
          )
        ],
      ),
    );
  }
}

class SearchVerileri extends SearchDelegate<String>{
  final sehirler=[
    "Adana",
    "Adıyaman",
    "Ankara",
    "İstanbul",
    "Hatay",
    "Berlin",
    "Tokyo",
    "Kastamonu",
    "New York",
    "Londra"
  ];

  final sonSehirler=[
    "Adana",
    "İstanbul",
    "Hatay",
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon:const Icon(Icons.clear),
        onPressed: (){
          query="";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon:AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ) ,
      onPressed: (){
        close(context,null.toString());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(40),
      color: Colors.indigo,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Center(
            child: Text(secilen,style:const TextStyle(fontSize: 50),)
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
     final oneriListesi=query.isEmpty ? sonSehirler:sehirler.where((p)=>p.startsWith(query)).toList();

     return ListView.builder(
       itemBuilder: (context,index)=>ListTile(
         onTap: (){
           showResults(context);
           secilen=oneriListesi[index];
         },
         leading: const Icon(Icons.location_city),
         title: RichText(
           text: TextSpan(
             text: oneriListesi[index].substring(0,query.length),
             style:const TextStyle(
               color: Colors.black,
               fontWeight: FontWeight.bold,
             ),
             children: [
               TextSpan(
                 text: oneriListesi[index].substring(query.length),
                 style:const TextStyle(color:Colors.grey)
               )
             ]
           ),
         ),
       ),
       itemCount: oneriListesi.length,
     );
  }
  
}
