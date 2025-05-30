import 'package:flutter/material.dart';
import 'package:frontend/color.dart';
import 'package:frontend/vues/components/text_form_field.dart';

class BlockBenefits extends StatelessWidget {
  const BlockBenefits({super.key});

  void _showNavigrosOrderForm(BuildContext context) {
    final addressController = TextEditingController();
    final cityController = TextEditingController();
    final zipController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          top: 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Commande du pass Navigros",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              MyInputField(label: "Adresse", controller: addressController),
              const SizedBox(height: 12),
              MyInputField(label: "Ville", controller: cityController),
              const SizedBox(height: 12),
              MyInputField(label: "Code postal", controller: zipController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
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
                          children: const [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 48,
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Pass commandé !",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Vous allez recevoir votre carte à l’adresse indiquée.",
                              style: TextStyle(color: Colors.white70),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Commander"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            "Vos avantages",
            style: TextStyle(color: AppColors.white, fontSize: 22),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () => _showNavigrosOrderForm(context),
          child: Container(
            height: 65,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.card,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Commander votre Navigros",
                      style: TextStyle(color: AppColors.white, fontSize: 16),
                    ),
                    Text(
                      "Recevez la gratuitement chez vous !",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.secondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
