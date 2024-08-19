import 'package:flutter/material.dart';
import 'package:blood_donnation/api.dart';

class UserDons extends StatefulWidget {
  final List<Map<String, dynamic>> dons;
  final int annonceId;

  UserDons({required this.dons, required this.annonceId});

  @override
  _UserDonsState createState() => _UserDonsState();
}

class _UserDonsState extends State<UserDons> {
  List<Map<String, dynamic>> _dons = [];
  bool _isLoading = true; // Indicateur de chargement global
  bool _isConfirming = false; // Indicateur de chargement lors de la confirmation d'un don

  @override
  void initState() {
    super.initState();
    _loadDons();
  }

  void _loadDons() async {
    setState(() {
      _isLoading = true;
    });
    // Simuler le temps de chargement des dons (si besoin)
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _dons = widget.dons;
      _isLoading = false;
    });
  }

  void _showConfirmationDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmer'),
          content: Text('Voulez-vous vraiment fermer l\'annonce ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              child: Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _closeAnnonce() async {
    try {
      await ApiService().desactiverAnnonce(widget.annonceId);
      print("Annonce fermée !");
    } catch (e) {
      print("Erreur lors de la fermeture de l'annonce : $e");
    }
  }

  Future<void> _confirmDon(int donId) async {
    setState(() {
      _isConfirming = true;
    });
    try {
      await ApiService().confirmDon(donId);
      setState(() {
        _dons = _dons.map((don) {
          if (don['id'] == donId) {
            don['etat'] = 'confirmé';
          }
          return don;
        }).toList();
      });
      // Afficher un Snackbar pour informer que le don a été confirmé
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Le don a été confirmé avec succès.')),
      );
    } catch (e) {
      print("Erreur lors de la confirmation du don : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la confirmation du don.')),
      );
    } finally {
      setState(() {
        _isConfirming = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dons associés'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Affichage du chargement initial
          : Column(
        children: [
          Expanded(
            child: ListView(
              children: _dons.map((don) {
                final isConfirmed = don['etat'] == 'confirmé';
                return Card(
                  margin: EdgeInsets.all(8.0),
                  color: isConfirmed ? Colors.grey[300] : null, // Griser l'élément si confirmé
                  child: ListTile(
                    title: Text('Donateur: ${don['user']['name']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('État: ${don['etat']}'),
                        Text('Date: ${don['created_at']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: _isConfirming && !isConfirmed
                              ? CircularProgressIndicator(strokeWidth: 2)
                              : Icon(Icons.check),
                          onPressed: isConfirmed || _isConfirming
                              ? null
                              : () async {
                            await _confirmDon(don['id']);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: isConfirmed ? null : () {
                            // Annuler le don
                            // Appeler votre API pour annuler le don
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                _showConfirmationDialog(context, _closeAnnonce);
              },
              icon: Icon(Icons.close),
              label: Text('Fermer l\'annonce'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                backgroundColor: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
