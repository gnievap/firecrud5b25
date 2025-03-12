import 'package:cloud_firestore/cloud_firestore.dart';

class ArtistModel {
  final String id;
  final String name;
  final String genre;
  final int albums;
  final int start;

  ArtistModel(
      {required this.id,
      required this.name,
      required this.genre,
      required this.albums,
      required this.start});

  // Convertir un Artist a un Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': name,
      'genero': genre,
      'albums': albums,
      'inicio': start,
    };
  }

  factory ArtistModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return ArtistModel(
      id: doc.id,
      name: doc['nombre'],
      genre: doc['genero'],
      albums: doc['albums'] as int,
      start: doc['inicio'] as int,
    );
  }
}
