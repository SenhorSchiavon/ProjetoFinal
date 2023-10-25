import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  final Function(int) changePage; // Adicione uma função para mudar a página

  DrawerScreen({required this.changePage});

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {


  void navigateToPage(int index) {
    widget.changePage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white60,
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage('imagens/arvorebranca.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10, // Espaçamento entre a imagem e o texto
                ),
                Text(
                  'Fitgarden',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                NewRow(
                  text: 'Nossos Produtos',
                  icon: Icons.production_quantity_limits,
                  onTap: () {
                    navigateToPage(1); // Altera para Pagina1
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                NewRow(
                  text: 'Pedidos',
                  icon: Icons.request_page,
                  onTap: () {
                    navigateToPage(2); // Altera para Pagina2
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                NewRow(
                  text: 'Onde Estamos',
                  icon: Icons.location_on_outlined,
                  onTap: () {
                    navigateToPage(3); // Altera para Pagina3
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const NewRow({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap, // Use o onTap passado para acionar a navegação
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.green,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.green),
            )
          ],
        ));
  }
}
