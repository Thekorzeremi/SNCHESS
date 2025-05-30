import 'package:flutter/material.dart';
import '../../color.dart';
import '../../mocks/mock_data.dart';
import '../../services/formatDateService.dart';
import 'components/admin_entity_card.dart';
import 'components/admin_tabs.dart';
import 'components/admin_entity_list.dart';
import 'components/admin_edit_dialog.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  String selected = 'users';

  final List<Map<String, String>> _tabs = const [
    {'key': 'users', 'label': 'Users'},
    {'key': 'gares', 'label': 'Gares'},
    {'key': 'trams', 'label': 'Trams'},
    {'key': 'voyages', 'label': 'Voyages'},
  ];

  void _showEditDialog(BuildContext context, String entity, Map<String, dynamic> data, {void Function(Map<String, dynamic>)? onSave}) {
    showDialog(
      context: context,
      builder: (context) => AdminEditDialog(
        entity: entity,
        data: data,
        onSave: onSave,
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String entity, dynamic data, VoidCallback onDeleteConfirmed) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text('Confirmer la suppression', style: TextStyle(color: AppColors.white)),
        content: const Text('Êtes-vous sûr de vouloir supprimer cet élément ?', style: TextStyle(color: AppColors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler', style: TextStyle(color: AppColors.secondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: AppColors.white),
            onPressed: () {
              Navigator.pop(context);
              onDeleteConfirmed();
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildUserCards() {
    return users.entries.map((entry) {
      final user = entry.value;
      return AdminEntityCard(
        infoWidgets: [
          Row(
            children: const [
              Icon(Icons.person, color: AppColors.secondary),
              SizedBox(width: 8),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text('Email : ${user['email']}', style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          if (user['ticket'] != null)
            Row(
              children: [
                const SizedBox(width: 32),
                Text('Tickets : ${user['ticket'].length}', style: const TextStyle(color: AppColors.white)),
              ],
            ),
        ],
        onEdit: null,
        onDelete: null,
      );
    }).toList();
  }

  List<Widget> _buildGareCards() {
    return gares.map((gare) {
      return AdminEntityCard(
        infoWidgets: [
          Row(
            children: const [
              Icon(Icons.location_on, color: AppColors.secondary),
              SizedBox(width: 8),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text('Nom : ${gare['name']}', style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text('Latitude : ${gare['latitude']}', style: const TextStyle(color: AppColors.white)),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text('Longitude : ${gare['longitude']}', style: const TextStyle(color: AppColors.white)),
            ],
          ),
        ],
        onEdit: () { _showEditDialog(context, 'gares', gare); },
        onDelete: () {
          _showDeleteDialog(context, 'gares', gare, () {
            setState(() {
              gares.remove(gare);
            });
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildTramCards() {
    return trams.map((tram) {
      return AdminEntityCard(
        infoWidgets: [
          Row(
            children: const [
              Icon(Icons.directions_transit, color: AppColors.secondary),
              SizedBox(width: 8),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text('Nom : ${tram['name']}', style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text('Type : ${tram['type']}', style: const TextStyle(color: AppColors.white)),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text('Statut : ${tram['status']}', style: const TextStyle(color: AppColors.white)),
            ],
          ),
        ],
        onEdit: () { _showEditDialog(context, 'trams', tram); },
        onDelete: () {
          _showDeleteDialog(context, 'trams', tram, () {
            setState(() {
              trams.remove(tram);
            });
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildVoyageCards() {
    return voyages.map((voyage) {

      final tram = trams.firstWhere((t) => t['id'] == voyage['tramId'], orElse: () => {'name': 'N/A', 'type': ''});
      final gareDepart = gares.firstWhere((g) => g['id'] == voyage['fromGareId'], orElse: () => {'name': 'N/A'});
      final gareArrivee = gares.firstWhere((g) => g['id'] == voyage['toGareId'], orElse: () => {'name': 'N/A'});
      String date = voyage['departureDate'] ?? '';
      String heure = voyage['departureHour'] ?? '';

      return AdminEntityCard(
        infoWidgets: [
          Row(
            children: const [
              Icon(Icons.train, color: AppColors.secondary),
              SizedBox(width: 8),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text('Train : ${tram['name']} (${tram['type']})', style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text('Départ : ${gareDepart['name']}', style: const TextStyle(color: AppColors.white)),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text('Arrivée : ${gareArrivee['name']}', style: const TextStyle(color: AppColors.white)),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text('Date : $date $heure', style: const TextStyle(color: AppColors.white)),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text('Durée : ${formatDuration(voyage['duration'])}', style: const TextStyle(color: AppColors.white)),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text('Prix : ${voyage['price']} €', style: const TextStyle(color: AppColors.secondary)),
            ],
          ),
        ],
        onEdit: () { _showEditDialog(context, 'voyages', voyage); },
        onDelete: () {
          _showDeleteDialog(context, 'voyages', voyage, () {
            setState(() {
              voyages.remove(voyage);
            });
          });
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> entityCards = [];

    if (selected == 'users') {
      entityCards = _buildUserCards();
    } else if (selected == 'gares') {
      entityCards = _buildGareCards();
    } else if (selected == 'trams') {
      entityCards = _buildTramCards();
    } else if (selected == 'voyages') {
      entityCards = _buildVoyageCards();
    }

    void handleAdd() {
      if (selected == 'users') {
        final newUser = {'email': '', 'ticket': []};
        _showEditDialog(context, 'users', newUser, onSave: (data) {
          setState(() {
            users[DateTime.now().millisecondsSinceEpoch.toString()] = data;
          });
        });
      } else if (selected == 'gares') {
        final newGare = {'name': '', 'latitude': '', 'longitude': ''};
        _showEditDialog(context, 'gares', newGare, onSave: (data) {
          setState(() {
            gares.add(data);
          });
        });
      } else if (selected == 'trams') {
        final newTram = {'name': '', 'type': '', 'status': ''};
        _showEditDialog(context, 'trams', newTram, onSave: (data) {
          setState(() {
            trams.add(data);
          });
        });
      } else if (selected == 'voyages') {
        final newVoyage = {
          'tramId': '',
          'fromGareId': '',
          'toGareId': '',
          'departureDate': '',
          'departureHour': '',
          'duration': '',
          'price': '',
        };
        _showEditDialog(context, 'voyages', newVoyage, onSave: (data) {
          setState(() {
            voyages.add(data);
          });
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin', style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: Container(
        color: AppColors.primary,
        child: Column(
          children: [
            const SizedBox(height: 16),
            AdminTabs(
              selected: selected,
              tabs: _tabs,
              onSelect: (key) => setState(() => selected = key),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (selected != 'users')
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: AppColors.primary,
                      ),
                      onPressed: handleAdd,
                      icon: const Icon(Icons.add),
                      label: Text('Ajouter'),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: AdminEntityList(children: entityCards),
            ),
          ],
        ),
      ),
    );
  }
}
