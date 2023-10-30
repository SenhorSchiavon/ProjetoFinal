
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Banco {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> inserirPedido(
      String nome, String telefone, String endereco, int quantidade, String tipo) async {
    await Firebase.initializeApp();

    try {
      await _db.collection("pedidos").add({
        "nome": nome,
        "telefone": telefone,
        "endereco": endereco,
        "quantidade": quantidade,
        "tipo": tipo,
      });
    } catch (e) {
      // Trate possíveis erros aqui
      print("Erro ao inserir o pedido: $e");
    }
  }

  static Future<void> apagarPedido(
      String nome, String telefone, String endereco, int quantidade, String tipo) async {
    await Firebase.initializeApp();

    try {
      var pedidos = await _db
          .collection('pedidos')
          .where('nome', isEqualTo: nome)
          .where('telefone', isEqualTo: telefone)
          .where('endereco', isEqualTo: endereco)
          .where('quantidade', isEqualTo: quantidade)
          .where('tipo', isEqualTo: tipo)
          .get();

      for (var pedido in pedidos.docs) {
        await _db.collection('pedidos').doc(pedido.id).delete();
      }
    } catch (error) {
      print("Erro ao apagar pedido: $error");
    }
  }
}
