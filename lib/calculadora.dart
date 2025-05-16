import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  final VoidCallback onReturnToHome;
  
  const Calculadora({super.key, required this.onReturnToHome});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _display = '0';
  double _numero1 = 0;
  double _numero2 = 0;
  String _operacion = '';

  void _presionarBoton(String texto) {
    if (texto == 'C') {
      _display = '0';
      _numero1 = 0;
      _numero2 = 0;
      _operacion = '';
    } else if (texto == '=') {
      _numero2 = double.parse(_display);
      if (_operacion == '+') {
        _display = (_numero1 + _numero2).toString();
      } else if (_operacion == '-') {
        _display = (_numero1 - _numero2).toString();
      } else if (_operacion == '*') {
        _display = (_numero1 * _numero2).toString();
      } else if (_operacion == '/') {
        _display = (_numero1 / _numero2).toString();
      }
    } else if (texto == '+' || texto == '-' || texto == '*' || texto == '/') {
      _numero1 = double.parse(_display);
      _operacion = texto;
      _display = '0';
    } else {
      if (_display == '0') {
        _display = texto;
      } else {
        _display += texto;
      }
    }
    setState(() {});
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => _mostrarConfirmacion(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/fondo.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(),
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                child: Text(
                  _display,
                  style: const TextStyle(
                    fontSize: 52,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'RobotoMono',
                  ),
                ),
              ),
              const Spacer(),
              _crearFila(['7', '8', '9', '/']),
              _crearFila(['4', '5', '6', '*']),
              _crearFila(['1', '2', '3', '-']),
              _crearFila(['0', 'C', '=', '+']),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }

  Widget _crearFila(List<String> botones) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: botones.map((texto) => _crearBoton(texto)).toList(),
      ),
    );
  }

  Widget _crearBoton(String texto) {
    Color fondo;
    const Color textoColor = Colors.white;

    if (texto == 'C' || texto == '=') {
      fondo = Colors.black87;
    } else if (texto == '+' || texto == '-' || texto == '*' || texto == '/') {
      fondo = Colors.deepPurple.shade700;
    } else {
      fondo = Colors.deepPurple;
    }

    return ElevatedButton(
      onPressed: () => _presionarBoton(texto),
      style: ElevatedButton.styleFrom(
        backgroundColor: fondo,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
        textStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          fontFamily: 'RobotoMono',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(texto, style: const TextStyle(color: textoColor)),
    );
  }
}