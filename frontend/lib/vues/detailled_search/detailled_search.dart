import 'package:flutter/material.dart';
import '../../color.dart';
import 'components/traveler_card.dart';
import 'components/station_dialog.dart';
import 'components/show_price.dart';
import '../filtered_travels/filtered_travels.dart';
import '../../mocks/mock_data.dart';
import '../../services/firebaseAuthentificationService.dart';

class DetailledSearch extends StatefulWidget {
  const DetailledSearch({super.key});

  @override
  State<DetailledSearch> createState() => _DetailledSearchState();
}

class _DetailledSearchState extends State<DetailledSearch>
    with SingleTickerProviderStateMixin {
  List<String> get garesList => gares.map((g) => g['name'] as String).toList();

  String? gareDepart;
  String? gareArrivee;
  DateTime? dateDepart;
  double _rotationAngle = 1.5708; // 90° en radians
  bool isVoyageurSelected = false;
  bool isAnimalSelected = false;
  bool isVeloSelected = false;

  // TODO: Ajouter la récupération des gares depuis Firebase RDB

  @override
  Widget build(BuildContext context) {
    if (dateDepart == null) {
      dateDepart = DateTime.now();
    }

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          'Recherche',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Départ',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: gareDepart == null
                                ? Text(
                                    'Choisissez...',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    gareDepart!,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (context) => StationDialog(
                                  gares: garesList,
                                  onSelected: (gare) =>
                                      setState(() => gareDepart = gare),
                                  title: 'Sélectionnez la gare de départ',
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: AnimatedRotation(
                              turns:
                                  _rotationAngle /
                                  (2 *
                                      3.141592653589793), // OBLIGE DE ROTATE AVEC PI
                              duration: Duration(milliseconds: 300),
                              child: Icon(
                                Icons.swap_vert,
                                color: AppColors.white,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                final tmp = gareDepart;
                                gareDepart = gareArrivee;
                                gareArrivee = tmp;
                                _rotationAngle +=
                                    3.141592653589793; // Ajoute 180° (π radians) (OBLIGE DE ROTATE AVEC PI)
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Arrivée',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: gareArrivee == null
                                ? Text(
                                    'Choisissez...',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    gareArrivee!,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (context) => StationDialog(
                                  gares: garesList,
                                  onSelected: (gare) =>
                                      setState(() => gareArrivee = gare),
                                  title: 'Sélectionnez la gare d\'arrivée',
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Divider(color: AppColors.primary, height: 2),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              dateDepart == null
                                  ? 'Date de départ'
                                  : '${dateDepart!.day.toString().padLeft(2, '0')} ${_mois(dateDepart!.month)} ${dateDepart!.year}',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: dateDepart ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  Duration(days: 365),
                                ),
                                builder: (context, child) => Theme(
                                  data: ThemeData.dark().copyWith(
                                    colorScheme: const ColorScheme.dark(
                                      primary: AppColors.secondary,
                                      onPrimary: AppColors.white,
                                      surface: AppColors.card,
                                      onSurface: AppColors.white,
                                    ),
                                    dialogBackgroundColor: AppColors.card,
                                  ),
                                  child: child!,
                                ),
                              );
                              if (picked != null) {
                                setState(() {
                                  dateDepart = picked;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Qui voyage ?',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TravelerCard(
                    icon: Icons.person_outline,
                    label: 'Voyageur',
                    selected: isVoyageurSelected,
                    onTap: () {
                      setState(() {
                        isVoyageurSelected = !isVoyageurSelected;
                      });
                    },
                  ),
                  TravelerCard(
                    icon: Icons.pets,
                    label: 'Animal',
                    selected: isAnimalSelected,
                    onTap: () {
                      setState(() {
                        isAnimalSelected = !isAnimalSelected;
                      });
                    },
                  ),
                  TravelerCard(
                    icon: Icons.directions_bike,
                    label: 'Vélo',
                    selected: isVeloSelected,
                    onTap: () {
                      setState(() {
                        isVeloSelected = !isVeloSelected;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => UserCardDialog(),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFFFD580),
                        child: Text(
                          FirebaseAuthentificationService().getUserInitial(),
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${FirebaseAuthentificationService().getCurrentUserInformation()?["displayName"]}',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Carte Avantage',
                              style: TextStyle(color: AppColors.white),
                            ),
                            Text(
                              'Sans carte de fidélité',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: ShowPriceButton(
                  onPressed: () {
                    if (gareDepart == null || gareDepart!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Veuillez renseigner la gare de départ.',
                          ),
                        ),
                      );
                      return;
                    }
                    if (gareArrivee == null || gareArrivee!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Veuillez renseigner la gare d\'arrivée.',
                          ),
                        ),
                      );
                      return;
                    }
                    if (dateDepart == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Veuillez renseigner la date de départ.',
                          ),
                        ),
                      );
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilteredTravels(
                          gareDepart: gareDepart!,
                          gareArrivee: gareArrivee!,
                          dateDepart: dateDepart!,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _mois(int mois) {
    const moisNoms = [
      '',
      'janv.',
      'févr.',
      'mars',
      'avr.',
      'mai',
      'juin',
      'juil.',
      'août',
      'sept.',
      'oct.',
      'nov.',
      'déc.',
    ];
    return moisNoms[mois];
  }
}

class UserCardDialog extends StatelessWidget {
  const UserCardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Informations voyageur',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(Icons.close, color: AppColors.secondary),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFFFFD580),
                radius: 28,
                child: Text(
                  FirebaseAuthentificationService().getUserInitial(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              SizedBox(width: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FirebaseAuthentificationService()
                            .getCurrentUserInformation()?['displayName'] ??
                        '',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Carte Avantage',
                    style: TextStyle(color: AppColors.secondary, fontSize: 15),
                  ),
                  Text(
                    'Sans carte de fidélité',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Text(
            'Profitez de tous vos avantages et suivez vos statuts de fidélité ici.',
            style: TextStyle(color: AppColors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
