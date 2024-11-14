import 'package:flutter/material.dart'; // Paquet principal de Flutter per a la interfície d'usuari.
import 'package:flutter/services.dart'; // Paquet per accedir als serveis del sistema.
import 'package:flutter_form_builder/flutter_form_builder.dart'; // Paquet per construir formularis fàcilment.
import 'package:form_builder_validators/form_builder_validators.dart'; // Paquet per validar els camps del formulari.

/// Widget principal que representa el formulari amb diferents tipus de camps de formulari.
class FrmC extends StatefulWidget {
  const FrmC({super.key});

  @override
  State createState() => _FormulariCState();
}
class _FormulariCState extends State<FrmC> {
  // Clau per accedir a l'estat del formulari.
  final _clauFormulari = GlobalKey<FormBuilderState>();
  
  // Variables per emmagatzemar els valors seleccionats.
  String? valorChip;
  bool estatSwitch = false;
  String? valorText;
  String? valorDropdown;
  String? valorRadioGroup;

  /// Funció que mostra les dades seleccionades després de validar el formulari.
  void mostrarDadesSeleccionades() {
    final estatActual = _clauFormulari.currentState;
    if (estatActual != null && estatActual.saveAndValidate()) {
      setState(() {
        valorChip = estatActual.value['opcio'];
        valorText = estatActual.value['TextField'];
        estatSwitch = estatActual.value['Switch'];
        valorDropdown = estatActual.value['DropDownField'];
        valorRadioGroup = estatActual.value['RadioGroupModel'];
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Dades Seleccionades'),
            content: Text(
              'Chip seleccionat: $valorChip\n'
              'Valor del Switch: ${estatSwitch ? "Activat" : "Desactivat"}\n'
              'Text introduït: ${valorText}\n'
              'Valor seleccionat del Dropdown: $valorDropdown\n'
              'Valor seleccionat del Radio Group: $valorRadioGroup',
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
        title: const Text('Salesians Sarrià 24/25'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          FormBuilder(
            key: _clauFormulari,
            onChanged: () => _clauFormulari.currentState!.save(),
            skipDisabled: true,
            child: Column(
              children: [
                // Secció: Selecció de tipus "Chip"
                FormBuilderChoiceChip(
                  name: 'opcio',
                  spacing: 3,
                  runSpacing: 6,
                  alignment: WrapAlignment.spaceAround,
                  decoration: InputDecoration(
                    labelText: 'Choose option',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  showCheckmark: false,
                  backgroundColor: Colors.green[400],
                  selectedColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(300),
                  ),
                  options: const [
                    //Aquí estan les opcions del chip
                    FormBuilderChipOption(value: 'Flutter', avatar: Icon(Icons.filter_vintage_outlined)),
                    FormBuilderChipOption(value: 'Android', avatar: Icon(Icons.android)),
                    FormBuilderChipOption(value: 'Chrome OS'),
                  ],
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 10),
                
                // Secció: Switch per activar o desactivar una opció
                FormBuilderSwitch(
                  name: 'Switch',
                  title: const Text('This is a Switch'),
                  initialValue: false,
                  decoration: InputDecoration(
                    labelText: 'Switch',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                
                // Secció: Camp de text per introduir dades
                FormBuilderTextField(
                  name: 'TextField',
                  maxLength: 15,//determinem la l. max
                  maxLengthEnforcement: MaxLengthEnforcement.none,
                  decoration: InputDecoration(
                    labelText: 'Write',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    //Validació necessaria
                    FormBuilderValidators.minLength(1),
                    FormBuilderValidators.maxLength(15),
                  ]),
                ),
                const SizedBox(height: 10),
                
                // Secció: Desplegable (Dropdown) per triar una opció
                FormBuilderDropdown(
                  name: 'DropDownField',
                  decoration: InputDecoration(
                    labelText: 'DropDown Field',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  items: const [
                    //Opcións disponibles
                    DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
                    DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
                    DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
                  ],
                  alignment: AlignmentDirectional.centerStart,
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 30),
                
                // Secció: Radio Group per seleccionar una opció entre diverses
                FormBuilderRadioGroup(
                  name: 'RadioGroupModel',
                  decoration: InputDecoration(
                    labelText: 'Radio Group Model',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  //Aquí apareixen totes les opcións posibles
                  options: const ['Option 1','Option 2','Option 3','Option 4',].map((opcio) => FormBuilderFieldOption(
                        value: opcio,
                        child: Text(opcio),
                      )).toList(growable: false),
                  orientation: OptionsOrientation.vertical,
                  validator: FormBuilderValidators.required(),
                ),
              ],
            ),
          ),
        ],
      ),
      // Botó flotant per mostrar les dades seleccionades.
      floatingActionButton: FloatingActionButton(
        onPressed: mostrarDadesSeleccionades,
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(Icons.upload),
      ),
    );
  }
}