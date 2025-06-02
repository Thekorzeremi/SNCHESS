import 'package:flutter/material.dart';
import '../../color.dart';
import '../../services/firebaseDatabaseService.dart';
import '../../services/formatDateService.dart';
import 'components/admin_entity_card.dart';
import 'components/admin_tabs.dart';
import 'components/admin_entity_list.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final FirebaseDatabaseService _dbService = FirebaseDatabaseService();
  bool _loading = false;
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> gares = [];
  List<Map<String, dynamic>> voyages = [];
  List<Map<String, dynamic>> trams = [];

  String selected = 'users';

  final List<Map<String, String>> _tabs = const [
    {'key': 'users', 'label': 'Users'},
    {'key': 'gares', 'label': 'Gares'},
    {'key': 'trams', 'label': 'Trams'},
    {'key': 'voyages', 'label': 'Voyages'},
  ];

  Future<void> _refreshData() async {
    setState(() => _loading = true);
    users = await _dbService.getUsers();
    voyages = await _dbService.getTrips();
    gares = await _dbService.getStations();
    final tramSet = <String, Map<String, dynamic>>{};
    for (final v in voyages) {
      final vehicle = v['trip']?['vehicle'];
      if (vehicle != null && vehicle['name'] != null) {
        tramSet[vehicle['name']] = vehicle;
      }
    }
    trams = tramSet.values.toList();
    setState(() => _loading = false);
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  List<Widget> _buildUserCards() {
    return users.asMap().entries.map((entry) {
      final index = entry.key + 1; // DB indexation commence à 1
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
              Text(
                'Email : ${user['email']}',
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (user['ticket'] != null)
            Row(
              children: [
                const SizedBox(width: 32),
                Text(
                  'Tickets : ${user['ticket'].length}',
                  style: const TextStyle(color: AppColors.white),
                ),
              ],
            ),
        ],
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
              Text(
                'Nom : ${gare['city'] ?? gare['name']}',
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text(
                'Latitude : ${gare['coordinate']?['latitude'] ?? gare['latitude']}',
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text(
                'Longitude : ${gare['coordinate']?['longitude'] ?? gare['longitude']}',
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
        ],
        onEdit: null,
        onDelete: null,
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
              Text(
                'Nom : ${tram['name']}',
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text(
                'Type : ${tram['type']}',
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text(
                'Statut : ${tram['status']}',
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
        ],
      );
    }).toList();
  }

  List<Widget> _buildVoyageCards() {
    return voyages.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final voyage = entry.value;
      final trip = voyage['trip'] ?? {};
      final route = trip['route'] ?? {};
      final vehicle = trip['vehicle'] ?? {};
      final from = route['fromStation'] ?? {};
      final to = route['toStation'] ?? {};
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
              Text(
                'Train : ${vehicle['name']} (${vehicle['type']})',
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text(
                'Départ : ${from['city']}',
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text(
                'Arrivée : ${to['city']}',
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text(
                'Date départ : ${from['datetime']}',
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text(
                'Date arrivée : ${to['datetime']}',
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              Text(
                'Prix : ${trip['price']} €',
                style: const TextStyle(color: AppColors.secondary),
              ),
            ],
          ),
        ]
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

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator(color: AppColors.secondary))
            : Column(
                children: [
                  AdminTabs(
                    selected: selected,
                    tabs: _tabs,
                    onSelect: (key) async {
                      setState(() => selected = key);
                      await _refreshData();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _tabs.firstWhere((t) => t['key'] == selected)['label']!,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(child: AdminEntityList(children: entityCards)),
                ],
              ),
      ),
    );
  }
}
