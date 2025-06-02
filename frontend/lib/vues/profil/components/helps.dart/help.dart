import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snct/color.dart';
import 'package:snct/vues/profil/components/helps.dart/compensation_page.dart';
import 'package:ionicons/ionicons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BlockHelps extends StatelessWidget {
  const BlockHelps({super.key});

  void _showContactPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Ionicons.call_outline, size: 40, color: Colors.green),
            SizedBox(height: 12),
            Text(
              "Service client",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "0 800 123 456",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: "0 800 123 456"));
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Numéro copié dans le presse-papiers"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              icon: Icon(Icons.copy),
              label: Text("Copier le numéro"),
            ),
          ],
        ),
      ),
    );
  }

  void _showBulletinForm(BuildContext context) {
    final referenceController = TextEditingController();
    DateTime? selectedDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Bulletin de retard",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: referenceController,
                    cursorColor: AppColors.secondary,
                    decoration: InputDecoration(
                      labelText: 'Référence du voyage',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final now = DateTime.now();
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: now.subtract(Duration(days: 365)),
                        lastDate: now,
                        builder: (context, child) => Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: ColorScheme.dark(
                              primary: AppColors.secondary,
                              surface: AppColors.card,
                            ),
                          ),
                          child: child!,
                        ),
                      );
                      if (pickedDate != null) {
                        setModalState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 8,
                      ),
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white30),
                        ),
                      ),
                      child: Text(
                        selectedDate != null
                            ? "Date du voyage : ${selectedDate!.toLocal().toString().split(' ')[0]}"
                            : "Choisir la date du voyage",
                        style: TextStyle(
                          color: selectedDate != null
                              ? Colors.white
                              : Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final ref = referenceController.text.trim();
                      final email =
                          FirebaseAuth.instance.currentUser?.email ??
                          'adresse inconnue';

                      if (ref.isEmpty || selectedDate == null) {
                        return;
                      }

                      Navigator.of(context).pop();

                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          backgroundColor: AppColors.card,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 48,
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Bulletin envoyé",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Un bulletin de retard a été envoyé à $email pour le voyage $ref du ${selectedDate!.toLocal().toString().split(' ')[0]}",
                                style: TextStyle(color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Envoyer le bulletin"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            "Aide",
            style: TextStyle(color: AppColors.white, fontSize: 22),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => CompensationPage()));
          },
          child: Container(
            height: 50,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.card,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Compensation en cas de retard",
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
                Icon(Ionicons.document_text, color: AppColors.secondary),
              ],
            ),
          ),
        ),

        SizedBox(height: 10),
        GestureDetector(
          onTap: () => _showBulletinForm(context),
          child: Container(
            height: 50,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.card,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bulletin de retard",
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
                Icon(Ionicons.arrow_redo_outline, color: AppColors.secondary),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () => _showContactPopup(context),
          child: Container(
            height: 50,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.card,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Contacter le service client",
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
                Icon(Ionicons.call_outline, color: AppColors.secondary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
