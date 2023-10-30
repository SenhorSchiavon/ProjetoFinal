import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_final/Banco.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastrarComanda extends StatefulWidget {
  const CadastrarComanda({Key? key}) : super(key: key);

  @override
  _CadastrarComandaState createState() => _CadastrarComandaState();
}

const List<String> list = ["LowCarb", "Fitness", "Salgado", "Suco Detox"];

class _CadastrarComandaState extends State<CadastrarComanda> {
  final campoNome = TextEditingController();
  final campoTelefone = TextEditingController();
  final campoEndereco = TextEditingController();

  Map<String, bool> _checkBoxValues = {
    'LowCarb': false,
    'Fitness': false,
    'Salgado': false,
    'Suco Detox': false,
  };

  Map<String, int> _quantidades = {
    'LowCarb': 0,
    'Fitness': 0,
    'Salgado': 0,
    'Suco Detox': 0,
  };

  void _fazerPedido() {
    String nome = campoNome.text;
    String telefone = campoTelefone.text;
    String endereco = campoEndereco.text;

    if (_camposNaoPreenchidos()) {
      _exibirSnackBar('Por favor, preencha todos os campos!', Colors.red);
      return;
    }

    if (!_validarTelefone(telefone)) {
      _exibirSnackBar('Número de telefone inválido!', Colors.red);
      return;
    }

    bool tipoSelecionado = _checkBoxValues.containsValue(true);
    bool quantidadePreenchida = _quantidades.values.any((value) => value > 0);

    if (tipoSelecionado && quantidadePreenchida) {
      _processarPedido(nome, telefone, endereco);
    } else {
      _exibirSnackBar('Selecione um tipo e preencha a quantidade!', Colors.red);
    }
  }

  bool _camposNaoPreenchidos() {
    return campoNome.text.isEmpty || campoTelefone.text.isEmpty || campoEndereco.text.isEmpty;
  }

  bool _validarTelefone(String telefone) {
    final telefoneValido = RegExp(r'^\(\d{2}\)\d{5}-\d{4}$');
    return telefoneValido.hasMatch(telefone);
  }

  void _processarPedido(String nome, String telefone, String endereco) {
    List<Map<String, dynamic>> tiposSelecionados = _obterTiposSelecionados();

    _salvarNoFirebase(nome, telefone, endereco, tiposSelecionados);

    _limparCampos();
    _exibirSnackBar('Pedido efetuado com SUCESSO!!', Colors.green);
  }

  List<Map<String, dynamic>> _obterTiposSelecionados() {
    List<String> tiposSelecionadosList = _checkBoxValues.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    return tiposSelecionadosList.map((tipo) {
      return {
        'tipoSelecionado': tipo,
        'quantidade': _quantidades[tipo] ?? 0,
      };
    }).toList();
  }

  void _limparCampos() {
    campoNome.clear();
    campoTelefone.clear();
    campoEndereco.clear();
    _checkBoxValues.keys.forEach((key) {
      _checkBoxValues[key] = false;
      _quantidades[key] = 0;
    });
  }

  String formatPhoneNumber(String number) {
    String cleaned = number.replaceAll(RegExp(r'[^\d]'), ''); // Remove tudo que não é dígito
    int length = cleaned.length;

    if (length > 2) {
      cleaned = '(${cleaned.substring(0, 2)})' + cleaned.substring(2);
    }

    if (length > 9) {
      cleaned = '${cleaned.substring(0, 9)}-${cleaned.substring(9)}';
    }

    return cleaned;
  }

  void _salvarNoFirebase(String nome, String telefone, String endereco, List<Map<String, dynamic>> tiposSelecionados) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    try {
      await firebaseFirestore.collection('pedidos').add({
        'nome': nome,
        'telefone': telefone,
        'endereco': endereco,
        'tiposSelecionados': tiposSelecionados,
        'data_pedido': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      _exibirSnackBar('Erro ao fazer o pedido. Tente novamente.', Colors.red);
    }
  }

  void _exibirSnackBar(String mensagem, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: cor,
      ),
    );
  }

// Restante do código permanece o mesmo...

// Método para exibir um diálogo para selecionar a quantidade
  void _showQuantityDialog(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int _currentQuantity = _quantidades[title] ?? 0;

        return AlertDialog(
          title: Text('Quantidade para $title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Selecione a quantidade:'),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  setState(() {
                    _currentQuantity = int.tryParse(value) ?? 0;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Salvar'),
              onPressed: () {
                if (_currentQuantity > 0) {
                  setState(() {
                    _quantidades[title] = _currentQuantity;
                    Navigator.of(context).pop();
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Por favor, preencha uma quantidade válida!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Encomendas",
              style: TextStyle(
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                labelText: "Nome",
                hintText: "Informe o Nome",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  gapPadding: 10,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  gapPadding: 50,
                ),
              ),
              style: TextStyle(
                fontSize: 15,
              ),
              controller: campoNome,
            ),
            SizedBox(height: 20),
            TextField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11), // Limitar o tamanho do número
              ],
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Telefone",
                hintText: "Informe o Telefone, apenas números",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  gapPadding: 10,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  gapPadding: 50,
                ),
              ),
              style: TextStyle(
                fontSize: 15,
              ),
              controller: campoTelefone,
              onChanged: (value) {
                final formatted = formatPhoneNumber(value);
                if (value != formatted) {
                  campoTelefone.value = campoTelefone.value.copyWith(
                    text: formatted,
                    selection: TextSelection.collapsed(offset: formatted.length),
                  );
                }
              },
            ),

            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Endereço",
                hintText: "Informe o Endereço",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  gapPadding: 10,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  gapPadding: 50,
                ),
              ),
              style: TextStyle(
                fontSize: 15,
              ),
              controller: campoEndereco,
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Column(
              children: _checkBoxValues.keys.map((String title) {
                return CheckboxListTile(
                  title: Text(title),
                  value: _checkBoxValues[title] ?? false,
                  onChanged: (bool? value) {
                    setState(() {
                      _checkBoxValues[title] = value ?? false;
                      if (value == true) {
                        _showQuantityDialog(title);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white12),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      minimumSize: MaterialStateProperty.all(Size(0, 60)),
                    ),
                    onPressed: () {
                      _fazerPedido();

                    },
                    child: Text("Fazer Pedido"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
