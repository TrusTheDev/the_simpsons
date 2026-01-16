import 'package:flutter/material.dart';
import 'package:the_simpsons/data/model/simpsonModel.dart';
import 'package:the_simpsons/data/model/simpsonSimpleResponse.dart';
import 'package:the_simpsons/data/model/simpsonsResponse.dart';
import 'package:the_simpsons/data/repository.dart';

class SimpsonsSearchScreen extends StatefulWidget {
  const SimpsonsSearchScreen({super.key});

  @override
  State<SimpsonsSearchScreen> createState() => _SimpsonsSearchScreenState();
}

class _SimpsonsSearchScreenState extends State<SimpsonsSearchScreen> {
  Future<Simpsonresponse?>? _simpsonInfo;
  Future<Simpsonmodel?>? _simpsonDetailedInfo;
  Repository repository = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simpsons Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [TextField(
            decoration: InputDecoration(hintText: "Busca a un simpson", 
            prefixIcon: Icon(Icons.search), 
            border: OutlineInputBorder()),
            onChanged: (text){
              setState(() {
                _simpsonDetailedInfo = repository.fetchSimpsonReponseInfoByName(text);
                //_simpsonInfo = repository.fetchSimpsonReponseInfo(text);
              });
            },
          ),
          FutureBuilder(future: _simpsonDetailedInfo, builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            } else if(snapshot.hasError){
              Text("${snapshot.data?.name}");
              return Text("Error: ${snapshot.error}");
            } else if(snapshot.hasData){
              return Text("${snapshot.data?.name}");
            } else {
              return Text("No hay resultados.");
            }
          })
          ],
        ),
      ),
    );
  }
}