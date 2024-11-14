import 'package:flutter/material.dart'; // Paquet principal de Flutter per a la interfície d'usuari.
import 'package:intl/intl.dart'; // Paquet per treballar amb dates i hores.

class FrmD extends StatefulWidget {
  @override
  _FrmDState createState() => _FrmDState();
}

class _FrmDState extends State<FrmD> {
  // Llistes de països i tecnologies per a la selecció.
  final List<String> paisos = ['Afganistan', 'Albània', 'Algèria', 'Andorra', 'Angola', 'Argentina', 'Armènia', 'Austràlia', 'Àustria', 'Azerbaidjan'];
  final List<String> tecnologies = ['HTML', 'CSS', 'React', 'Dart', 'TypeScript', 'Angular'];
  final List<String> tecnologiesSeleccionades = [];

  // Variables per emmagatzemar les seleccions de l'usuari.
  DateTime? dataSeleccionada;
  DateTimeRange? rangDatesSeleccionat;
  TimeOfDay? horaSeleccionada;
  String? paisSeleccionat;

  /// Funció que mostra les dades seleccionades en un quadre de diàleg.
  void mostrarDadesSeleccionades() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Dades Seleccionades'),
          content: Text(
            'País: ${paisSeleccionat ?? 'Cap'}\n'
            'Data: ${dataSeleccionada != null ? DateFormat('yyyy-MM-dd').format(dataSeleccionada!) : 'Cap'}\n'
            'Rang de dates: ${rangDatesSeleccionat != null ? '${DateFormat('yyyy-MM-dd').format(rangDatesSeleccionat!.start)} - ${DateFormat('yyyy-MM-dd').format(rangDatesSeleccionat!.end)}' : 'Cap'}\n'
            'Hora: ${horaSeleccionada != null ? horaSeleccionada!.format(context) : 'Cap'}\n'
            'Tecnologies seleccionades: ${tecnologiesSeleccionades.join(', ')}',
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
        child: ListView(
          children: [
            const Text("Selecciona un país", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            _buildCountryAutocomplete(),
            const SizedBox(height: 20),
            _buildDatePicker(context),
            const SizedBox(height: 20),
            _buildDateRangePicker(context),
            const SizedBox(height: 20),
            _buildTimePicker(context),
            const SizedBox(height: 20),
            _buildTechnologyChips(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: mostrarDadesSeleccionades,
        child: const Icon(Icons.check),
      ),
    );
  }

  // Secció: Autocompletar per seleccionar un país
  Widget _buildCountryAutocomplete() {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue value) {
        return value.text.isEmpty
            ? const Iterable<String>.empty()
            : paisos.where((pais) => pais.toLowerCase().contains(value.text.toLowerCase()));
      },
      onSelected: (String selection) {
        paisSeleccionat = selection;
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
    );
  }

  // Secció: Selector de data
  Widget _buildDatePicker(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: TextEditingController(
        text: dataSeleccionada != null ? DateFormat('yyyy-MM-dd').format(dataSeleccionada!) : '',
      ),
      decoration: InputDecoration(
        icon: const Icon(Icons.calendar_today, color: Colors.grey),
        labelText: 'Selecciona la data',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: dataSeleccionada != null
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    dataSeleccionada = null;
                  });
                },
              )
            : null,
      ),
      onTap: () async {
        DateTime? dataEscollida = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (dataEscollida != null) {
          setState(() {
            dataSeleccionada = dataEscollida;
          });
        }
      },
    );
  }

  // Secció: Selector de rang de dates
  Widget _buildDateRangePicker(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: TextEditingController(
        text: rangDatesSeleccionat != null
            ? '${DateFormat('yyyy-MM-dd').format(rangDatesSeleccionat!.start)} - ${DateFormat('yyyy-MM-dd').format(rangDatesSeleccionat!.end)}'
            : '',
      ),
      decoration: InputDecoration(
        icon: const Icon(Icons.date_range, color: Colors.grey),
        labelText: 'Selecciona el rang de dates',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: rangDatesSeleccionat != null
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    rangDatesSeleccionat = null;
                  });
                },
              )
            : null,
      ),
      onTap: () async {
        DateTimeRange? rangEscollit = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (rangEscollit != null) {
          setState(() {
            rangDatesSeleccionat = rangEscollit;
          });
        }
      },
    );
  }

  // Secció: Selector d'hora
  Widget _buildTimePicker(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: TextEditingController(
        text: horaSeleccionada != null ? horaSeleccionada!.format(context) : '',
      ),
      decoration: InputDecoration(
        icon: const Icon(Icons.access_time, color: Colors.grey),
        labelText: 'Selecciona l\'hora',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: horaSeleccionada != null
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    horaSeleccionada = null;
                  });
                },
              )
            : null,
      ),
      onTap: () async {
        TimeOfDay? horaEscollida = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (horaEscollida != null) {
          setState(() {
            horaSeleccionada = horaEscollida;
          });
        }
      },
    );
  }

  // Secció: Selecció de tecnologies amb "chips"
  Widget _buildTechnologyChips() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: tecnologies.map((tec) {
          return FilterChip(
            label: Text(tec),
            labelStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.blueGrey,
            selectedColor: Colors.lightBlueAccent,
            selected: tecnologiesSeleccionades.contains(tec),
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  tecnologiesSeleccionades.add(tec);
                } else {
                  tecnologiesSeleccionades.remove(tec);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}