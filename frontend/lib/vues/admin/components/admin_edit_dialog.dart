import 'package:flutter/material.dart';
import '../../../color.dart';
import '../../../mocks/mock_data.dart';

class AdminEditDialog extends StatefulWidget {
  final String entity;
  final Map<String, dynamic> data;
  final void Function(Map<String, dynamic>)? onSave;
  final Set<String> nonEditableKeys;

  const AdminEditDialog({
    super.key,
    required this.entity,
    required this.data,
    this.onSave,
    this.nonEditableKeys = const {'id'},
  });

  @override
  State<AdminEditDialog> createState() => _AdminEditDialogState();
}

class _AdminEditDialogState extends State<AdminEditDialog> {
  late Map<String, TextEditingController> controllers;
  String? _selectedTramName;
  String? _selectedFromGareName;
  String? _selectedToGareName;

  @override
  void initState() {
    super.initState();
    controllers = {};
    widget.data.forEach((key, value) {
      if (!widget.nonEditableKeys.contains(key)) {
        controllers[key] = TextEditingController(text: value?.toString() ?? '');
      }
    });
    _selectedTramName = widget.data['tramId'];
    _selectedFromGareName = widget.data['fromGareId'];
    _selectedToGareName = widget.data['toGareId'];
  }

  @override
  void dispose() {
    for (final ctrl in controllers.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isVoyage = widget.entity == 'voyages';

    final List<Map<String, String>> tramList = trams.map((tram) => {
      'id': tram['id'].toString(),
      'name': '${tram['name']} (${tram['type']})',
    }).toList().cast<Map<String, String>>();
    final List<Map<String, String>> gareList = gares.map((gare) => {
      'id': gare['id'].toString(),
      'name': gare['name'].toString(),
    }).toList().cast<Map<String, String>>();

    _selectedTramName ??= isVoyage ? tramList.firstWhere((t) => t['id'] == controllers['tramId']?.text, orElse: () => {'name': ''})['name'] : null;
    _selectedFromGareName ??= isVoyage ? gareList.firstWhere((g) => g['id'] == controllers['fromGareId']?.text, orElse: () => {'name': ''})['name'] : null;
    _selectedToGareName ??= isVoyage ? gareList.firstWhere((g) => g['id'] == controllers['toGareId']?.text, orElse: () => {'name': ''})['name'] : null;

    final List<Map<String, String>> statusList = [
      {'value': 'service', 'label': 'En service'},
      {'value': 'hors service', 'label': 'Hors service'},
      {'value': 'panne', 'label': 'En panne'},
    ];

    return AlertDialog(
      backgroundColor: AppColors.card,
      title: Text('Editer ${widget.entity}', style: const TextStyle(color: AppColors.white)),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widget.data.entries.where((entry) => widget.nonEditableKeys.contains(entry.key)).map((entry) => Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Text('${entry.key} : ${entry.value}', style: const TextStyle(color: AppColors.secondary)),
              )),
              if (isVoyage) ...[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    value: tramList.firstWhere((t) => t['id'] == controllers['tramId']?.text, orElse: () => tramList.first)['id'],
                    items: tramList.map((tram) => DropdownMenuItem<String>(
                      value: tram['id'],
                      child: Text(tram['name']!, style: const TextStyle(color: AppColors.white)),
                    )).toList(),
                    dropdownColor: AppColors.primary,
                    decoration: InputDecoration(
                      labelText: 'Train',
                      labelStyle: const TextStyle(color: AppColors.secondary),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary, width: 2),
                      ),
                      filled: true,
                      fillColor: AppColors.card,
                    ),
                    style: const TextStyle(color: AppColors.white),
                    onChanged: (val) {
                      setState(() {
                        controllers['tramId']?.text = val ?? '';
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    value: gareList.firstWhere((g) => g['id'] == controllers['fromGareId']?.text, orElse: () => gareList.first)['id'],
                    items: gareList.map((gare) => DropdownMenuItem<String>(
                      value: gare['id'],
                      child: Text(gare['name']!, style: const TextStyle(color: AppColors.white)),
                    )).toList(),
                    dropdownColor: AppColors.primary,
                    decoration: InputDecoration(
                      labelText: 'Gare de départ',
                      labelStyle: const TextStyle(color: AppColors.secondary),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary, width: 2),
                      ),
                      filled: true,
                      fillColor: AppColors.card,
                    ),
                    style: const TextStyle(color: AppColors.white),
                    onChanged: (val) {
                      setState(() {
                        controllers['fromGareId']?.text = val ?? '';
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    value: gareList.firstWhere((g) => g['id'] == controllers['toGareId']?.text, orElse: () => gareList.first)['id'],
                    items: gareList.map((gare) => DropdownMenuItem<String>(
                      value: gare['id'],
                      child: Text(gare['name']!, style: const TextStyle(color: AppColors.white)),
                    )).toList(),
                    dropdownColor: AppColors.primary,
                    decoration: InputDecoration(
                      labelText: 'Gare d\'arrivée',
                      labelStyle: const TextStyle(color: AppColors.secondary),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary, width: 2),
                      ),
                      filled: true,
                      fillColor: AppColors.card,
                    ),
                    style: const TextStyle(color: AppColors.white),
                    onChanged: (val) {
                      setState(() {
                        controllers['toGareId']?.text = val ?? '';
                      });
                    },
                  ),
                ),
              ],
              ...controllers.entries.where((entry) => !isVoyage || (entry.key != 'tramId' && entry.key != 'fromGareId' && entry.key != 'toGareId')).map((entry) {
                final isTimeField = entry.key == 'duration' || entry.key == 'departureHour';
                final isDateField = entry.key == 'date' || entry.key == 'departureDate';
                final isTramStatus = widget.entity == 'trams' && entry.key == 'status';
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: isTimeField
                      ? GestureDetector(
                          onTap: () async {
                            final initialTime = entry.value.text.isNotEmpty
                                ? TimeOfDay(
                                    hour: int.tryParse(entry.value.text.split(':').first) ?? 0,
                                    minute: int.tryParse(entry.value.text.split(':').last) ?? 0,
                                  )
                                : const TimeOfDay(hour: 0, minute: 0);
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: initialTime,
                              builder: (context, child) => Center(
                                child: SizedBox(
                                  width: 400,
                                  child: Theme(
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
                                ),
                              ),
                            );
                            if (picked != null) {
                              final formatted = picked.hour.toString().padLeft(2, '0') + ':' + picked.minute.toString().padLeft(2, '0');
                              setState(() {
                                entry.value.text = formatted;
                              });
                            }
                          },
                          child: AbsorbPointer(
                            child: TextField(
                              controller: entry.value,
                              style: const TextStyle(color: AppColors.white),
                              decoration: InputDecoration(
                                labelText: entry.key,
                                labelStyle: const TextStyle(color: AppColors.secondary),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.secondary),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.secondary, width: 2),
                                ),
                                filled: true,
                                fillColor: AppColors.card,
                                suffixIcon: const Icon(Icons.access_time, color: AppColors.secondary),
                              ),
                              readOnly: true,
                            ),
                          ),
                        )
                      : isDateField
                          ? GestureDetector(
                              onTap: () async {
                                DateTime firstDate = DateTime.now();
                                DateTime initialDate;
                                try {
                                  initialDate = DateTime.parse(entry.value.text);
                                } catch (_) {
                                  initialDate = firstDate;
                                }
                                if (initialDate.isBefore(firstDate)) {
                                  initialDate = firstDate;
                                }
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: initialDate,
                                  firstDate: firstDate,
                                  lastDate: firstDate.add(Duration(days: 365)),
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
                                    entry.value.text = picked.toIso8601String().split('T').first;
                                  });
                                }
                              },
                              child: AbsorbPointer(
                                child: TextField(
                                  controller: TextEditingController(
                                    text: () {
                                      try {
                                        final d = DateTime.parse(entry.value.text);
                                        const moisNoms = [
                                          '', 'janv.', 'févr.', 'mars', 'avr.', 'mai', 'juin', 'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.'
                                        ];
                                        return '${d.day.toString().padLeft(2, '0')} ${moisNoms[d.month]} ${d.year}';
                                      } catch (_) {
                                        return '';
                                      }
                                    }(),
                                  ),
                                  style: const TextStyle(color: AppColors.white),
                                  decoration: InputDecoration(
                                    labelText: entry.key,
                                    labelStyle: const TextStyle(color: AppColors.secondary),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.secondary),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.secondary, width: 2),
                                    ),
                                    filled: true,
                                    fillColor: AppColors.card,
                                    suffixIcon: const Icon(Icons.calendar_today, color: AppColors.secondary),
                                  ),
                                  readOnly: true,
                                ),
                              ),
                            )
                          : isTramStatus
                              ? DropdownButtonFormField<String>(
                                  value: statusList.any((s) => s['value'] == controllers['status']?.text)
                                      ? controllers['status']?.text
                                      : statusList.first['value'],
                                  items: statusList
                                      .map((status) => DropdownMenuItem<String>(
                                            value: status['value'],
                                            child: Text(status['label']!, style: const TextStyle(color: AppColors.white)),
                                          ))
                                      .toList(),
                                  dropdownColor: AppColors.primary,
                                  decoration: InputDecoration(
                                    labelText: entry.key,
                                    labelStyle: const TextStyle(color: AppColors.secondary),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.secondary),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.secondary, width: 2),
                                    ),
                                    filled: true,
                                    fillColor: AppColors.card,
                                  ),
                                  style: const TextStyle(color: AppColors.white),
                                  onChanged: (val) {
                                    setState(() {
                                      controllers['status']?.text = val ?? statusList.first['value']!;
                                    });
                                  },
                                )
                              : TextField(
                                  controller: entry.value,
                                  style: const TextStyle(color: AppColors.white),
                                  decoration: InputDecoration(
                                    labelText: entry.key,
                                    labelStyle: const TextStyle(color: AppColors.secondary),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.secondary),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.secondary, width: 2),
                                    ),
                                    filled: true,
                                    fillColor: AppColors.card,
                                  ),
                            ),
                );
              }),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler', style: TextStyle(color: AppColors.secondary)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary, foregroundColor: AppColors.primary),
          onPressed: () {
            final newData = <String, dynamic>{};
            widget.data.forEach((key, value) {
              if (widget.nonEditableKeys.contains(key)) {
                newData[key] = value;
              }
            });
            controllers.forEach((key, ctrl) {
              newData[key] = ctrl.text;
            });
            if (widget.onSave != null) widget.onSave!(newData);
            Navigator.pop(context);
          },
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }
}