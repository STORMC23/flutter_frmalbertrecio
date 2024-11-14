import 'package:flutter/material.dart'; // Paquet principal de Flutter per a la interfície d'usuari.
import 'package:flutter_form_builder/flutter_form_builder.dart'; // Paquet per construir formularis fàcilment.

class FrmA extends StatefulWidget {
  @override
  _FrmA createState() => _FrmA();
}
class _FrmA extends State<FrmA> {

  final String title = "Salesians Sarrià 24/25";
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> velocitatsPassades = [];
  String? velocitatSeleccionada;
  TextEditingController controladorObservacions = TextEditingController();
  String? velocitatMaximaSeleccionada;

  //Aquí mostrem les dades d'aquest frm
  void showAlertDialog(BuildContext context, Map<String, dynamic> formData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Dades Seleccionades'),
          content: Text(
            'Velocitat: ${formData['speed'] ?? 'Cap'}\n'
            'Observacions: ${controladorObservacions.text}\n'
            'Velocitat màxima: ${velocitatMaximaSeleccionada ?? 'Cap'}\n'
            'Velocitats passades: ${velocitatsPassades.join(', ')}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tanca el diàleg quan es fa clic a "Tancar"
              },
              child: const Text('Tancar'),
            ),
          ],
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      Map<String, dynamic> formData = _formKey.currentState?.value ?? {};
      showAlertDialog(context, formData);
    } else {
      print("Formulari no vàlid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormTitle(),
            //FormBuilder és una eina que permet crear formularis interactius de manera ràpida i senzilla sense necessitat de programació. 
            //Proporciona una interfície gràfica intuïtiva per arrossegar i deixar anar elements del formulari, personalitzar el disseny i recollir dades de manera eficient
            FormBuilder(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormLabelGroup(
                      title: 'Please provide the speed of vehicle',
                      subtitle: 'please select one option given below',
                    ),
                    //FormBuilderRadioGroup és un widget de Flutter que permet crear un grup de botons de ràdio dins d'un formulari. 
                    //Cada botó de ràdio representa una opció que l'usuari pot seleccionar, facilitant la recollida de dades en formularis
                    FormBuilderRadioGroup(
                      decoration: const InputDecoration(border: InputBorder.none),
                      name: "speed",
                      orientation: OptionsOrientation.vertical,
                      options: [
                        //FormBuilderFieldOption és un widget de Flutter que es fa servir per definir opcions dins de components de 
                        //formulari com grups de botons de ràdio o menús desplegables.
                        FormBuilderFieldOption(value: 'above 40km/h'),
                        FormBuilderFieldOption(value: 'below 40km/h'),
                        FormBuilderFieldOption(value: '0km/h')
                      ],
                      onChanged: (String? value) {
                        debugPrint(value);
                      },
                    ),
                    const SizedBox(height: 16),
                    // SECCIÓ: Camp de text per afegir observacions
                    //FormLabelGroup és un component utilitzat per agrupar etiquetes de formulari i els seus elements associats, 
                    //com ara camps de text o caselles de verificació. Això ajuda a organitzar i estructurar millor els formularis, 
                    //millorant la seva llegibilitat i usabilitat
                    FormLabelGroup(
                      title: 'Enter remarks:',
                    ),
                    TextField(
                      controller: controladorObservacions,
                      decoration: const InputDecoration(
                        hintText: 'Enter your remarks',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // SECCIÓ: Selecció d'una opció en aquest cas velocitats
                    FormLabelGroup(
                      title: 'Please provide the hight speed of vehicle',
                      subtitle: 'please select one option given below',
                    ),
                    //DropdownButton és un widget de Flutter que permet a l'usuari seleccionar una opció d'una llista desplegable. 
                    //Cada opció es defineix com un DropdownMenuItem, i el botó mostra l'opció seleccionada actualment
                    DropdownButton(
                      value: velocitatMaximaSeleccionada,
                      hint: const Text('Select option'),
                      items: const [
                        //Un DropdownMenuItem és un widget de Flutter que representa un element en un menú desplegable. 
                        //Cada element del menú desplegable es defineix com un DropdownMenuItem, que pot contenir text, 
                        //icones o altres widget
                        DropdownMenuItem(value: '20km/h', child: Text('20km/h')),
                        DropdownMenuItem(value: '30km/h', child: Text('30km/h')),
                        DropdownMenuItem(value: '40km/h', child: Text('40km/h')),
                        DropdownMenuItem(value: '50km/h', child: Text('50km/h')),
                      ],
                      onChanged: (valor) {
                        //setState s'utilitza per actualitzar l'estat d'un component que l'estat 
                        //ha canviat i torna a renderitzar el component per mostrar els canvis
                        setState(() {
                          velocitatMaximaSeleccionada = valor;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    //FormLabelGroup és un component utilitzat per agrupar etiquetes de formulari i els seus elements associats, 
                    //com ara camps de text o caselles de verificació. Això ajuda a organitzar i estructurar millor els formularis, 
                    //millorant la seva llegibilitat i usabilitat
                    FormLabelGroup(
                      title: 'Please provide the speed of vehicle past 1hour',
                      subtitle: 'please select one option given below',
                    ),
                    //CheckboxListTile és un widget de Flutter que combina una casella de verificació amb un element de llista. 
                    //Permet crear una casella de verificació juntament amb un títol, subtítol i icona, 
                    //sense necessitat de crear widgets separats per a cada part
                    CheckboxListTile(
                      title: const Text('20km/h'),
                      value: velocitatsPassades.contains('20km/h'),
                      onChanged: (seleccionat) {
                        //setState s'utilitza per actualitzar l'estat d'un component que l'estat 
                        //ha canviat i torna a renderitzar el component per mostrar els canvis
                        setState(() {
                          seleccionat == true
                              ? velocitatsPassades.add('20km/h')
                              : velocitatsPassades.remove('20km/h');
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading, // Botó a l'esquerra
                    ),
                    //CheckboxListTile és un widget de Flutter que combina una casella de verificació amb un element de llista. 
                    //Permet crear una casella de verificació juntament amb un títol, subtítol i icona, 
                    //sense necessitat de crear widgets separats per a cada part
                    CheckboxListTile(
                      title: const Text('30km/h'),
                      value: velocitatsPassades.contains('30km/h'),
                      onChanged: (seleccionat) {
                        //setState s'utilitza per actualitzar l'estat d'un component que l'estat 
                        //ha canviat i torna a renderitzar el component per mostrar els canvis
                        setState(() {
                          seleccionat == true
                              ? velocitatsPassades.add('30km/h')
                              : velocitatsPassades.remove('30km/h');
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading, // Botó a l'esquerra
                    ),
                    //CheckboxListTile és un widget de Flutter que combina una casella de verificació amb un element de llista. 
                    //Permet crear una casella de verificació juntament amb un títol, subtítol i icona, 
                    //sense necessitat de crear widgets separats per a cada part
                    CheckboxListTile(
                      title: const Text('40km/h'),
                      value: velocitatsPassades.contains('40km/h'),
                      onChanged: (seleccionat) {
                        setState(() {
                          seleccionat == true
                              ? velocitatsPassades.add('40km/h')
                              : velocitatsPassades.remove('40km/h');
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading, // Botó a l'esquerra
                    ),
                    //CheckboxListTile és un widget de Flutter que combina una casella de verificació amb un element de llista. 
                    //Permet crear una casella de verificació juntament amb un títol, subtítol i icona, 
                    //sense necessitat de crear widgets separats per a cada part
                    CheckboxListTile(
                      title: const Text('50km/h'),
                      value: velocitatsPassades.contains('50km/h'),
                      onChanged: (seleccionat) {
                        setState(() {
                          seleccionat == true
                              ? velocitatsPassades.add('50km/h')
                              : velocitatsPassades.remove('50km/h');
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading, // Botó a l'esquerra
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      //FloatingActionButton (FAB) és un botó circular que s'utilitza en aplicacions mòbils per realitzar una acció principal. 
      //Generalment, es col·loca a la cantonada inferior dreta de la pantalla i és molt visible per a l'usuari.
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upload),
        onPressed: _submitForm,
      ),
    );
  }
}

class FormTitle extends StatelessWidget{
  const FormTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Driving Form',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight:FontWeight.bold)
          ),
          Text('Form example', style: Theme.of(context).textTheme.labelLarge,)
        ],
      ),
    );
  }
}

Future<void> alertDialog(BuildContext context, String contentText) {
  return showDialog<void>(
    context: context, 
    builder: (BuildContext context) => AlertDialog(
      title: Row(
        children: [
          Icon(Icons.check_circle),
          SizedBox(width: 8),
          Text("Submission Completed"),
        ],
      ),
      content: Text(contentText), 
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Close'),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

class FormLabelGroup extends StatelessWidget{
  FormLabelGroup({super.key, required this.title, this.subtitle});

  String title;
  String ? subtitle;

  Widget conditionalSubtitle(BuildContext context){
    if(subtitle != null){
      return Text(subtitle!,
        style: Theme.of(context).textTheme.labelLarge?.apply(
          fontSizeFactor: 1.25,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)
        ),
      );
    }
    else{
      return Container();
    }
  }
   @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        conditionalSubtitle(context),
      ],
    );
  }
}