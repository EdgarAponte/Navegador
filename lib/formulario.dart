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

  void _mostrarConfirmacion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Deseas volver al inicio?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                widget.onReturnToHome();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => _mostrarConfirmacion(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.deepPurple,
              child: Text(
                'Formulario de Captura de Datos',
                style: textTheme.titleLarge!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Image.asset('assets/iujo.jpg', errorBuilder: (context, error, stackTrace) => Container()),

            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                labelStyle: textTheme.labelLarge,
              ),
              onChanged: (valor) {
                setState(() {
                  nombre = valor;
                });
              },
            ),
            const SizedBox(height: 16),

            CheckboxListTile(
              title: Text('Trabaja', style: textTheme.bodyMedium),
              value: trabaja,
              onChanged: (val) => setState(() => trabaja = val!),
            ),
            CheckboxListTile(
              title: Text('Estudia', style: textTheme.bodyMedium),
              value: estudia,
              onChanged: (val) => setState(() => estudia = val!),
            ),

            ListTile(
              title: Text('Masculino', style: textTheme.bodyMedium),
              leading: Radio<String>(
                value: 'Masculino',
                groupValue: genero,
                onChanged: (val) => setState(() => genero = val!),
              ),
            ),
            ListTile(
              title: Text('Femenino', style: textTheme.bodyMedium),
              leading: Radio<String>(
                value: 'Femenino',
                groupValue: genero,
                onChanged: (val) => setState(() => genero = val!),
              ),
            ),

            SwitchListTile(
              title: Text('Activar Notificaciones', style: textTheme.bodyMedium),
              value: notificaciones,
              onChanged: (val) => setState(() => notificaciones = val),
            ),

            const SizedBox(height: 12),
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

            const SizedBox(height: 12),
            ListTile(
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
          ],
        ),
      ),
    );
  }
}