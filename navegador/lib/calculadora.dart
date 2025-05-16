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
  String _errorMessage = '';
  bool _hasError = false;

  void _presionarBoton(String texto) {
    setState(() {
      _hasError = false;
      _errorMessage = '';
      
      if (texto == 'C') {
        _resetCalculator();
      } else if (texto == '=') {
        _calculateResult();
      } else if (texto == '+' || texto == '-' || texto == '*' || texto == '/') {
        _setOperation(texto);
      } else {
        _appendNumber(texto);
      }
    });
  }

  void _resetCalculator() {
    _display = '0';
    _numero1 = 0;
    _numero2 = 0;
    _operacion = '';
    _errorMessage = '';
    _hasError = false;
  }

  void _calculateResult() {
    try {
      _numero2 = double.parse(_display);
      
      if (_operacion == '/' && _numero2 == 0) {
        throw Exception('No se puede dividir por cero');
      }
      
      switch (_operacion) {
        case '+':
          _display = (_numero1 + _numero2).toString();
          break;
        case '-':
          _display = (_numero1 - _numero2).toString();
          break;
        case '*':
          _display = (_numero1 * _numero2).toString();
          break;
        case '/':
          _display = (_numero1 / _numero2).toString();
          break;
      }
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      _display = 'Error';
    }
  }

  void _setOperation(String texto) {
    _numero1 = double.parse(_display);
    _operacion = texto;
    _display = '0';
  }

  void _appendNumber(String texto) {
    if (_display == '0') {
      _display = texto;
    } else {
      _display += texto;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      // Eliminamos completamente el appBar
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade300,
              Colors.deepPurple.shade800,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Display y mensaje de error - ahora más cerca del borde superior
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 20), // Ajuste de márgenes
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
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
                    if (_hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _errorMessage,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Teclado - ahora ocupa más espacio vertical
              Expanded(
                flex: 2, // Ocupa más espacio que el display
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _crearFila(['7', '8', '9', '/']),
                      _crearFila(['4', '5', '6', '*']),
                      _crearFila(['1', '2', '3', '-']),
                      _crearFila(['0', 'C', '=', '+']),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearFila(List<String> botones) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: botones.map((texto) => _crearBoton(texto)).toList(),
    );
  }

  Widget _crearBoton(String texto) {
    Color fondo;
    const Color textoColor = Colors.white;
    double elevation = 4;

    if (texto == 'C') {
      fondo = Colors.red.shade600;
    } else if (texto == '=') {
      fondo = Colors.green.shade600;
    } else if (texto == '+' || texto == '-' || texto == '*' || texto == '/') {
      fondo = Colors.deepPurple.shade700;
      elevation = 6;
    } else {
      fondo = Colors.deepPurple.shade500;
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: ElevatedButton(
            onPressed: () => _presionarBoton(texto),
            style: ElevatedButton.styleFrom(
              backgroundColor: fondo,
              padding: const EdgeInsets.symmetric(vertical: 20),
              textStyle: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                fontFamily: 'RobotoMono',
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: elevation,
              shadowColor: Colors.black.withOpacity(0.3),
            ),
            child: Text(texto, style: const TextStyle(color: textoColor)),
          ),
        ),
      ),
    );
  }
}