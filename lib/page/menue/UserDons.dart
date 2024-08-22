import 'package:flutter/material.dart';
import 'package:blood_donnation/api.dart';

import 'Historique.dart';

class UserDons extends StatefulWidget {
  final List<Map<String, dynamic>> dons;
  final int annonceId;

  UserDons({required this.dons, required this.annonceId});

  @override
  _UserDonsState createState() => _UserDonsState();
}

class _UserDonsState extends State<UserDons> {
  List<Map<String, dynamic>> _dons = [];
  bool _isLoading = true;
  Map<int, bool> _isProcessing = {};

  @override
  void initState() {
    super.initState();
    _loadDons();
  }

  void _loadDons() async {
    setState(() {
      _isLoading = true;
    });
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
      // Redirection vers la page historique après la fermeture
      Navigator.pop(context);
    } catch (e) {
      print("Erreur lors de la fermeture de l'annonce : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la fermeture de l\'annonce.')),
      );
    }
  }

  Future<void> _confirmDon(int donId) async {
    setState(() {
      _isProcessing[donId] = true;
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
        _isProcessing[donId] = false;
      });
    }
  }

  Future<void> _cancelConfirmation(int donId) async {
    setState(() {
      _isProcessing[donId] = true;
    });
    try {
      await ApiService().cancelDon(donId);
      setState(() {
        _dons = _dons.map((don) {
          if (don['id'] == donId) {
            don['etat'] = 'annulé';
          }
          return don;
        }).toList();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Le don a été annulé avec succès.')),
      );
    } catch (e) {
      print("Erreur lors de l'annulation du don : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'annulation du don.')),
      );
    } finally {
      setState(() {
        _isProcessing[donId] = false;
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
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: ListView(
              children: _dons.map((don) {
                final isConfirmed = don['etat'] == 'confirmé';
                return Card(
                  margin: EdgeInsets.all(8.0),
                  color: isConfirmed ? Colors.grey[300] : null,
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
                          icon: _isProcessing[don['id']] == true
                              ? CircularProgressIndicator(strokeWidth: 2)
                              : Icon(
                            Icons.check,
                            color: isConfirmed ? Colors.grey : Colors.green,
                          ),
                          onPressed: isConfirmed || _isProcessing[don['id']] == true
                              ? null
                              : () async {
                            await _confirmDon(don['id']);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.cancel, color: isConfirmed ? Colors.red : Colors.grey),
                          onPressed: isConfirmed && _isProcessing[don['id']] != true
                              ? () async {
                            await _cancelConfirmation(don['id']);
                          }
                              : null,
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
              label: Text('Fermer l\'annonce', style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
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
