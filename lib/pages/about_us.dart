import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sobre nós'),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ActingCard('',
                  'Patrick Coutinho Advogados possui seu foco de atuação voltado para o acolhimento das demandas empresariais. A obtenção de resultados expressivos e relevantes em sua tradicional área de atuação - Direito do Trabalho - fomentou o avanço para outras áreas. Integrado por uma competente equipe de profissionais, e responsável pela formação de uma segura e confiável rede de parceiros, o escritório atua em todos os centros de atividade econômica espalhados pelo território nacional.'),
              ActingCard('NOSSA EQUIPE',
                  'O escritório valoriza a pro-atividade de seus membros, e possui como meta a busca pela entrega do resultado prático, pautando o seu diaa-dia no atendimento personalizado, bem como na eficiência e ética na elaboração de seus trabalhos. Além do especial zelo pela qualidade técnica dos seus serviços, o escritório se distingue pela agilidade e atenção dispensadas às demandas de seus clientes, experimentando, com isso, o impulsionamento de sua relevância no mercado')
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget ActingCard(String title, String description) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          description,
          textAlign: TextAlign.justify,
        ),
      ],
    ),
  );
}
