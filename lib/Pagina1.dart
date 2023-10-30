import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class Pagina1 extends StatefulWidget {
  const Pagina1({Key? key});

  @override
  State<Pagina1> createState() => _Pagina1State();
}

class _Pagina1State extends State<Pagina1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          CustomExpandablePanel(
            title: 'Marmita Low Carb',
            collapsedContent: 'Kit customizável de Marmitas Fitnesss da Fit Garden. Clique e saiba mais',
            expandedContent: 'Marmitas com 200g, de R\$98 por R\$79,90\n\n'
                'Marmitas com 200g, de R\$98 por R\$79,90\n\n'
                'Cada marmita é 20% carboidrato, 80% proteína',
            imageUrl: "imagens/lowcarb.jpg",
          ),
          CustomExpandablePanel(
            title: 'Marmita Fitness',
            collapsedContent: 'Kit customizável de Marmitas Fitnesss da Fit Garden. Clique e saiba mais',
            expandedContent: 'Marmitas com 200g, de R\$98 por R\$79,90\n\n'
                'Marmitas com 200g, de R\$98 por R\$79,90\n\n'
                'Cada marmita é 50% carboidrato, 50% proteína',
            imageUrl: "imagens/fitness.jpg",

          ),
          CustomExpandablePanel(
            title: 'Salgados Low Carb',
            collapsedContent: 'Os melhores Salgados Low Carb da região. Clique e saiba mais.',
            expandedContent: 'Kit com 4 Salgados, de R\$32 por R\$25\n\n'
                'Kit com 6 Salgados, de R\$45 por R\$32\n\n'
                'Bolinha de Queijo 90g: massa de batata doce, frango e especiarias, recheada com queijo mussarela\n\n'
                'Coxinha 90g: massa de cabotiá, frango e especiarias, recheada com frango\n\n'
                'Salgados feitos com zero farinha, congelados e prontos para consumo, é só aquecer (indica-se colocar no forno)\n',
            imageUrl: "imagens/salgado.jpg",
          ),
          CustomExpandablePanel(
            title: 'Suco Detox',
            collapsedContent: 'Os sucos detox mais gostosos de  toda região. Clique e saiba mais.',
            expandedContent: 'Kit com 3 Sucos Detox, de R\$15 por R\$12\n\n'
                'Kit com 5 Sucos Detox, de R\$25 por R\$19\n\n'
                'Cada garrafa contém 300ml e pode ser congelada por até 30 dias\n\n'
                'Suco Detox Verde: limão, couve, hortelã, gengibre, cenoura e maçã\n\n'
                'Suco Antioxidante Vermelho: beterraba, cenoura, maçã e gengibre\n\n',
            imageUrl: "imagens/Detox.png",
          ),
        ],
      ),
    );
  }
}

class CustomExpandablePanel extends StatelessWidget {
  final String title;
  final String collapsedContent;
  final String expandedContent;
  final String imageUrl;

  CustomExpandablePanel({
    required this.title,
    required this.collapsedContent,
    required this.expandedContent,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          color: Colors.black,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              Image.asset(imageUrl),
              ScrollOnExpand(
                child: ExpandablePanel(
                  theme: ExpandableThemeData(
                    iconColor: Colors.white,
                    expandIcon: Icons.arrow_downward_sharp,
                    collapseIcon: Icons.arrow_upward_sharp,
                    tapBodyToCollapse: true,
                    tapBodyToExpand: true,
                  ),
                  header: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  collapsed: Text(
                    collapsedContent,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Text(
                    expandedContent,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  builder: (_, collapsed, expanded) => Padding(
                    padding: EdgeInsets.all(10).copyWith(top: 0),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
