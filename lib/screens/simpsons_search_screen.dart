import 'package:flutter/material.dart';
import 'package:the_simpsons/data/model/dto_search_model.dart';
import 'package:the_simpsons/data/repository.dart';

class SimpsonsSearchScreen extends StatefulWidget {
  const SimpsonsSearchScreen({super.key});

  @override
  State<SimpsonsSearchScreen> createState() => _SimpsonsSearchScreenState();
}

class _SimpsonsSearchScreenState extends State<SimpsonsSearchScreen> {
  //Future<Simpsonresponse?>? _simpsonInfo;
  //Future<Simpsonmodel?>? _simpsonDetailedInfo;
  Future<List<Dtosearchmodel?>?>? _simpsonDetailedMatches;
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
                _simpsonDetailedMatches = repository.fetchSimpsonResponses(text, 5);
                //_simpsonDetailedInfo = repository.fetchSimpsonReponseInfoByName(text);
                //_simpsonInfo = repository.fetchSimpsonReponseInfo(text);
              });
            },
          ),
          FutureBuilder(future: _simpsonDetailedMatches, builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            } else if(snapshot.hasError){
              return Text("Error: ${snapshot.error}");
            } else if(snapshot.hasData){
              var simpsonList = snapshot.data;
              return ListView.builder(
                itemCount: simpsonList?.length ?? 0,
                itemBuilder: (context, index){
                  if(simpsonList != null){
                    Text(simpsonList[index]!.simpsonmodel.name);
                  }
                });

    

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