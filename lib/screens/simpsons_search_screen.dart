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
  Future<List<Dtosearchmodel>>? _simpsonDetailedMatches;
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
                  return Expanded(
                    child: ListView.builder(
                      itemCount: simpsonList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = simpsonList![index];
                        return itemSimpson(item);
                      },
                    ),
                  );
                } else {
                  return Text("No hay resultados.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

Widget itemSimpson(Dtosearchmodel item) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          child: Image.network(
            "https://cdn.thesimpsonsapi.com/1280${item.simpsonmodel.portaitPath}",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          child: Text(
            item.simpsonmodel.name,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

}
