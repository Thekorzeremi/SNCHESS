import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../color.dart';
import 'dart:convert';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  Map<String, dynamic>? ticketData;
  String? error;
  bool scanned = false;
  MobileScannerController controller = MobileScannerController();

  void _onDetect(BarcodeCapture capture) {
    if (scanned) return;
    final Barcode? barcode = capture.barcodes.firstOrNull;
    if (barcode == null || barcode.rawValue == null) return;
    setState(() => scanned = true);
    try {
      final data = json.decode(barcode.rawValue!);
      if (data is Map<String, dynamic> && data['qr_code'] != null) {
        setState(() {
          ticketData = data;
          error = null;
        });
      } else {
        setState(() {
          ticketData = null;
          error = 'QR code non reconnu.';
        });
      }
    } catch (e) {
      setState(() {
        ticketData = null;
        error = 'QR code non reconnu.';
      });
    }
    controller.stop();
  }

  void _restartScan() async {
    setState(() {
      ticketData = null;
      error = null;
      scanned = false;
    });
    await controller.start();
  }

  Widget _buildTicketInfo() {
    if (ticketData == null) return SizedBox();
    return Center(
      child: Card(
        color: AppColors.primary,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green[700],
                size: 48,
              ),
              const SizedBox(height: 8),
              Text(
                'Billet valide',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 18),
              Divider(color: Colors.white54),
              ListTile(
                leading: Icon(Icons.qr_code, color: Colors.white),
                title: Text(
                  'REF QR code',
                  style: TextStyle(color: Colors.white70),
                ),
                subtitle: Text(
                  '${ticketData!['qr_code']}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                leading: Icon(Icons.alt_route, color: Colors.white),
                title: Text('Trajet', style: TextStyle(color: Colors.white70)),
                subtitle: Text(
                  '${ticketData!['trajet']}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                leading: Icon(Icons.train, color: Colors.white),
                title: Text('Train', style: TextStyle(color: Colors.white70)),
                subtitle: Text(
                  '${ticketData!['train']}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                leading: Icon(Icons.departure_board, color: Colors.white),
                title: Text('Départ', style: TextStyle(color: Colors.white70)),
                subtitle: Text(
                  '${ticketData!['ville_depart']} à ${ticketData!['date_depart']}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                leading: Icon(Icons.flag, color: Colors.white),
                title: Text('Arrivée', style: TextStyle(color: Colors.white70)),
                subtitle: Text(
                  '${ticketData!['ville_arrivee']} à ${ticketData!['date_arrivee']}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                leading: Icon(Icons.event_seat, color: Colors.white),
                title: Text(
                  'Wagon & Place',
                  style: TextStyle(color: Colors.white70),
                ),
                subtitle: Text(
                  'Wagon : ${ticketData!['wagon']}  Place : ${ticketData!['place']}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                leading: Icon(Icons.euro, color: Colors.white),
                title: Text('Prix', style: TextStyle(color: Colors.white70)),
                subtitle: Text(
                  '${ticketData!['prix']} €',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildError() {
    if (error == null) return SizedBox();
    return Card(
      color: Colors.red[100],
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              error!,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.qr_code_scanner),
              label: Text('Réessayer'),
              onPressed: _restartScan,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text(
          'Vérification billet',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          if (!scanned) ...[
            Expanded(
              flex: 3,
              child: MobileScanner(
                controller: controller,
                onDetect: _onDetect,
                fit: BoxFit.contain,
                overlay: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width,
                    vertical: 24,
                  ),
                ),
              ),
            ),
          ] else ...[
            if (ticketData != null) _buildTicketInfo(),
            if (error != null) _buildError(),
          ],
        ],
      ),
    );
  }
}
