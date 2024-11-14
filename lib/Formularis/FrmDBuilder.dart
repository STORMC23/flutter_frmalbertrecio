import 'package:flutter/material.dart'; // Paquet principal de Flutter per a la interfície d'usuari.
import 'package:flutter_form_builder/flutter_form_builder.dart'; // Paquet per construir formularis fàcilment.
import 'package:intl/intl.dart'; // Paquet per treballar amb dates i hores.

class FrmDBuilder extends StatefulWidget {
  @override
  _FrmDState createState() => _FrmDState();
}

class _FrmDState extends State<FrmDBuilder> {
  // Llistes de països i tecnologies per a la selecció.
  final List<String> paisos = ['Afganistan', 'Albània', 'Algèria', 'Andorra', 'Angola', 'Argentina', 'Armènia', 'Austràlia', 'Àustria', 'Azerbaidjan'];
  final List<String> tecnologies = ['HTML', 'CSS', 'React', 'Dart', 'TypeScript', 'Angular'];
  final _formKey = GlobalKey<FormBuilderState>(); // Clau per identificar el formulari i accedir al seu estat.

  String? pais; // Variable per emmagatzemar el país seleccionat.

  /// Funció que mostra les dades seleccionades en un quadre de diàleg.
  void mostrarDadesSeleccionades() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState?.value;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Dades Seleccionades'),
            content: Text(
              'País: ${pais}\n'
              'Data: ${values?['data'] != null ? DateFormat('yyyy-MM-dd').format(values!['data']) : null}\n'
              'Rang de dates: ${values?['rangDates'] != null ? '${DateFormat('yyyy/MM/dd').format(values!['rangDates'].start)} - ${DateFormat('yyyy/MM/dd').format(values['rangDates'].end)}' : null}\n'
              'Hora: ${values?['hora'] != null ? '${DateFormat('HH:mm').format(values!['hora'])}': null}\n'
              'Tecnologies seleccionades: ${values?['tecnologies']}',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tancar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("Salesians Sarrià 24/25", style: TextStyle(fontSize: 20)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            children: [
              const Text("Selecciona un país", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              // Secció: Autocompletar per seleccionar un país
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue value) {
                  return value.text.isEmpty
                      ? const Iterable<String>.empty()
                      : paisos.where((pais) => pais.toLowerCase().contains(value.text.toLowerCase()));
                },
                onSelected: (String selection) {
                  setState(() {
                    pais = selection;
                  });
                },
                fieldViewBuilder: (BuildContext context, TextEditingController controller, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      labelText: 'País',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Secció: Selector de data
              FormBuilderDateTimePicker(
                name: 'data',
                inputType: InputType.date,
                decoration: InputDecoration(
                  icon: const Icon(Icons.calendar_today, color: Colors.grey),
                  labelText: 'Selecciona la data',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                format: DateFormat('yyyy-MM-dd'),
              ),
              const SizedBox(height: 20),
              // Secció: Selector de rang de dates
              FormBuilderDateRangePicker(
                name: 'rangDates',
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
                decoration: InputDecoration(
                  icon: const Icon(Icons.date_range, color: Colors.grey),
                  labelText: 'Selecciona el rang de dates',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                format: DateFormat('yyyy-MM-dd'),
              ),
              const SizedBox(height: 20),
              // Secció: Selector d'hora
              FormBuilderDateTimePicker(
                name: 'hora',
                inputType: InputType.time,
                decoration: InputDecoration(
                  icon: const Icon(Icons.access_time, color: Colors.grey),
                  labelText: 'Selecciona l\'hora',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                format: DateFormat('HH:mm'),
              ),
              const SizedBox(height: 20),
              // Secció: Selecció de tecnologies amb "chips"
              FormBuilderFilterChip(
                name: 'tecnologies',
                decoration: InputDecoration(
                  labelText: 'Selecciona les tecnologies',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                options: tecnologies.map((tec) => FormBuilderChipOption(value: tec, child: Text(tec))).toList(),
              ),
            ],
          ),
        ),
      ),
      //Botó flotant
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: mostrarDadesSeleccionades,
        child: const Icon(Icons.check),
      ),
    );
  }
}