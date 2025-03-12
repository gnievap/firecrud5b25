import 'package:firecrud5b25/models/artist_model.dart';
import 'package:firecrud5b25/services/cloud_firestore_service.dart';
import 'package:flutter/material.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({super.key});

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  final CloudFirestoreService _cloudFirestoreService = CloudFirestoreService();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _generoController = TextEditingController();
  final TextEditingController _inicioController = TextEditingController();
  final TextEditingController _albumsController = TextEditingController();

  void insertArtist() {
    
    _cloudFirestoreService.insertArtist('artistas', 
      {
        'nombre': _nombreController.text,
        'genero': _generoController.text,
        'albums': int.parse(_albumsController.text),
        'inicio': int.parse(_inicioController.text),
      }      
    );
    _nombreController.clear();
    _generoController.clear();
    _albumsController.clear();
    _inicioController.clear();
  }

  void deleteArtist(String docId) {
    _cloudFirestoreService.deleteArtist('artistas', docId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis artistas de Spotify'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          TextField(
            controller: _generoController,
            decoration: const InputDecoration(labelText: 'Género'),
          ),
          TextField(
            controller: _albumsController,
            decoration: const InputDecoration(labelText: 'Albums'),
          ),
          TextField(
            controller: _inicioController,
            decoration: const InputDecoration(labelText: 'Inicio'),
          ),
          ElevatedButton(
            onPressed: insertArtist,
            child: const Text('Agregar artista'),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _cloudFirestoreService.getArtists('artistas'),
              builder: (context, AsyncSnapshot<List<ArtistModel>> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error : ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return ListView(
                  children: snapshot.data!.map((ArtistModel artist) {
                    return ListTile(
                      title: Text(artist.name),
                      subtitle: Text('Genero: ${artist.genre}'),
                      onTap: null,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteArtist(artist.id),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
