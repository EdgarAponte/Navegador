import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  final VoidCallback onReturnToHome;
  
  const Formulario({super.key, required this.onReturnToHome});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  String nombre = '';
  bool trabaja = false;
  bool estudia = false;
  String genero = '';
  bool notificaciones = false;
  double precio = 50;
  DateTime? fechaSeleccionada;

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (fecha != null) {
      setState(() {
        fechaSeleccionada = fecha;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // Eliminamos el appBar
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Encabezado del formulario
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Formulario de Captura de Datos',
                  style: textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              // Imagen (si existe)
              Image.asset('assets/iujo.jpg', 
                errorBuilder: (context, error, stackTrace) => Container(),
              ),
              const SizedBox(height: 16),

              // Campo de nombre
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: textTheme.labelLarge,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: (valor) {
                  setState(() {
                    nombre = valor;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Checkboxes
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: Text('Trabaja', style: textTheme.bodyMedium),
                      value: trabaja,
                      onChanged: (val) => setState(() => trabaja = val!),
                    ),
                    Divider(height: 1),
                    CheckboxListTile(
                      title: Text('Estudia', style: textTheme.bodyMedium),
                      value: estudia,
                      onChanged: (val) => setState(() => estudia = val!),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Radio buttons
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Masculino', style: textTheme.bodyMedium),
                      leading: Radio<String>(
                        value: 'Masculino',
                        groupValue: genero,
                        onChanged: (val) => setState(() => genero = val!),
                      ),
                    ),
                    Divider(height: 1),
                    ListTile(
                      title: Text('Femenino', style: textTheme.bodyMedium),
                      leading: Radio<String>(
                        value: 'Femenino',
                        groupValue: genero,
                        onChanged: (val) => setState(() => genero = val!),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Switch
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SwitchListTile(
                  title: Text('Activar Notificaciones', style: textTheme.bodyMedium),
                  value: notificaciones,
                  onChanged: (val) => setState(() => notificaciones = val),
                ),
              ),
              const SizedBox(height: 16),

              // Slider
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seleccione Precio Estimado',
                        style: textTheme.labelLarge,
                      ),
                      Slider(
                        value: precio,
                        min: 0,
                        max: 100,
                        divisions: 10,
                        label: precio.round().toString(),
                        activeColor: Colors.deepPurple,
                        onChanged: (val) => setState(() => precio = val),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Selector de fecha
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text('Introduzca la Fecha', style: textTheme.labelLarge),
                  subtitle: Text(
                    fechaSeleccionada == null
                        ? 'No seleccionada'
                        : '${fechaSeleccionada!.day}/${fechaSeleccionada!.month}/${fechaSeleccionada!.year}',
                    style: textTheme.bodyMedium,
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _seleccionarFecha(context),
                ),
              ),
              const SizedBox(height: 16),

              // Botón de enviar
              ElevatedButton(
                onPressed: () {
                  // Acción al enviar el formulario
                  widget.onReturnToHome();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Enviar Formulario',
                  style: textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}