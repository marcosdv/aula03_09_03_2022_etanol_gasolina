import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _etanolController = TextEditingController();
  final _gasolinaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etanol x Gasolina'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _criarCampoTexto(_etanolController, 'Digite o valor do etanol'),
          _criarCampoTexto(_gasolinaController, 'Digite o valor da gasolina'),

          _criarBotao('Calcular', _calcularClique),
        ],
      ),
    );
  }

  Widget _criarCampoTexto(TextEditingController controlador, String texto) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controlador,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: texto,
          labelStyle: TextStyle(fontSize: 20),
          prefixText: 'R\$',
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  Widget _criarBotao(String texto, VoidCallback clique) {
    return ElevatedButton(
      onPressed: clique,
      child: Text(texto),
    );
  }

  void _calcularClique() {
    /*
    if (_etanolController.text.isEmpty) {
      _mostrarMensagem('Digite o valor do etanol');
      return;
    }
    double valorEtanol = double.parse(_etanolController.text);
    double valorGasolina = double.parse(_gasolinaController.text);
    */

    double valorEtanol = double.tryParse(_etanolController.text.replaceAll(',', '.')) ?? 0;
    double valorGasolina = double.tryParse(_gasolinaController.text.replaceAll(',', '.')) ?? 0;

    if (valorEtanol <= 0) {
      _mostrarMensagem('Digite um valor válido para o Etanol!');
      return;
    }
    if (valorGasolina <= 0) {
      _mostrarMensagem('Digite um valor válido para a Gasolina!');
      return;
    }

    //String resultado = _retornaResultado(valorEtanol, valorGasolina);
    //_mostrarMensagem('Abasteça com $resultado');

    _mostrarMensagem('Abasteça com ${_retornaResultado(valorEtanol, valorGasolina)}');
  }

  String _retornaResultado(double valorEtanol, double valorGasolina) {
    return (valorEtanol <= (valorGasolina * 0.7)) ? 'Etanol' : 'Gasolina';
    /*
    if (valorEtanol <= (valorGasolina * 0.7)) {
      return 'Etanol';
    } else {
      return 'Gasolina';
    }
    */
  }

  void _mostrarMensagem(String texto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Etanol x Gasolina', style: TextStyle(fontSize: 22),),
          content: Text(texto, style: const TextStyle(fontSize: 20),),
          actions: [
            _criarBotao('OK', () { Navigator.pop(context); }),
          ],
        );
      }
    );
  }
}