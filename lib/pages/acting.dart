import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActingPage extends StatefulWidget {
  const ActingPage({Key key}) : super(key: key);

  @override
  _ActingPageState createState() => _ActingPageState();
}

class _ActingPageState extends State<ActingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Áreas de atuação'),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ActingCard(
                  'Trabalhista',
                  'O escritório é referência no direito trabalhista empresarial, atuando nos setores consultivo, contencioso (judicial e administrativo), bem como em negociações coletivas.'
                      ' O que diferencia a Patrick Coutinho Advogados é a atenção aos fatos geradores de passivos, promovendo ações e recomendações que visem proteger o cliente.Dentro desse contexto, o Escritório oferece um serviço especial relacionado ao compliance trabalhista, promovendo a conformidade das práticas de seus clientes com a legislação trabalhista.'),
              ActingCard('Cível',
                  'O escritório tem como objetivo atuar, preventiva ou litigiosamente, na defesa dos interesses dos clientes em questões atinentes a contratos, relações comerciais e com os consumidores, judicial ou administrativamente. Nossa equipe oferece serviços de confecção e revisão de contratos, sempre com base nas atualizações legislativas sobre as matérias em análise, aconselhando o cliente sobre os principais obrigações e riscos envolvidos na celebração de cada negócio.'),
              ActingCard('TRIBUTÁRIO E SOCIETÁRIO',
                  'Nas áreas Tributária e Societária, através de parceria com grande escritório sediado em São Paulo, atendemos as necessidades das empresas em todos os segmentos da atividade econômica e nas mais distintas modalidades contratuais de negócios, oferecendo soluções nas áreas consultiva e contenciosa. Ademais, nosso departamento tributário conduzirá processos e negociações, prestando assessoria relacionada a medidas visando à regularidade fiscal dos clientes (certidões negativas), incluindo adoção de providências administrativas e judiciais.'),
              ActingCard('CONTRATOS E LICITAÇÕES',
                  'O escritório acompanha o cliente desde a análise do Edital de Licitação Pública, passando por todas as fases do procedimento licitatório. Na hipótese de celebração de contrato com a Administração Pública, os serviços se concentram na conservação dos interesses do cliente, desde a análise da minuta contratual e eventuais aditivos, bem como na apresentação de requerimentos visando a manutenção do equilíbrio contratual.')
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
