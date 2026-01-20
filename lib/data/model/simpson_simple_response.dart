class SimpsonSimpleResponse {
  final int id;
  final String name;
  SimpsonSimpleResponse({required this.name, required this.id});

  factory SimpsonSimpleResponse.fromJson(Map<String, dynamic> json){
    return SimpsonSimpleResponse(name: json['name'], id: json['id']);
    
  }
}