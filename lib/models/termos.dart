import 'package:flutter/material.dart';

const contentStyle = TextStyle(
    // fontSize: 10,
    );
const titleStyle = TextStyle(fontWeight: FontWeight.bold);

List<Widget> termos = const [
  Text(
    'TERMO DE CONSENTIMENTO LIVRE E ESCLARECIDO – TCLE\n',
    style: titleStyle,
    textAlign: TextAlign.center,
  ),
  Text(
    '       Você está sendo convidado(a) a participar dessa pesquisa de forma totalmente voluntária. O convite está sendo feito a você porque você tem um padrão de fala considerado normal. Você pode estar em atendimento com um profissional de Fonoaudiologia e ele(a) o(a) indicou para participar. Sua participação é importante, porém, você precisa decidir se quer participar ou não. Antes de concordar em participar desta pesquisa é muito importante que você compreenda as informações e instruções contidas neste documento.\n',
    textAlign: TextAlign.justify,
    style: contentStyle,
  ),
  Text(
    'DESCRIÇÃO DA PESQUISA\n',
    style: titleStyle,
    textAlign: TextAlign.center,
  ),
  Text(
    '       O propósito desta pesquisa é desenvolver um aplicativo (comunicare care) para auxiliar na reabilitação da fala de participantes com apraxia verbal. O aplicativo tem como objetivo auxiliar o desenvolvimento das atividades propostas em consultório pelo terapeuta fonoaudiólogo.',
    textAlign: TextAlign.justify,
    style: contentStyle,
  ),
  Text(
    '       Sua participação é voluntária e isenta de qualquer custo/remuneração, receberá todos os esclarecimentos necessários antes, durante e após a finalização da pesquisa, e caso aceite participar, será garantido o sigilo sobre sua identidade. Cabe dizer que estas informações serão guardadas de forma segura, e os pesquisadores assumem compromisso ético e legal pela confidencialidade dos dados envolvidos, os quais serão analisados de forma anônima, assegurando privacidade e confidencialidade. Você terá plena e total liberdade para desistir do estudo a qualquer momento, retirar seu consentimento ou interromper sua participação sem nenhum prejuízo, penalidade ou constrangimento para você.',
    textAlign: TextAlign.justify,
    style: contentStyle,
  ),
  Text(
    '       A coleta de dados será realizada por meio de gravações acústica da sua fala quando você pronuncia vogais, palavras e frases simples. Sua fala será considerada o padrão de fala do português brasileiro, e servirá nas comparações das falas dos pacientes com apraxia de fala. Sua fala será incluída em um banco de dados de falantes do português brasileiro, mas não haverá exposição vinculada à sua identidade. Como sabemos que a língua portuguesa sofre variações regionais, antes das gravações será solicitado que você selecione em qual estado você está vivendo/ passou a maior parte da vida. Assim a comparação entre as falas respeitará as variações linguísticas regionais. É para este procedimento que você está sendo convidado a participar.',
    textAlign: TextAlign.justify,
    style: contentStyle,
  ),
  Text(
    '       Todos participantes receberão todo o suporte necessário ao longo da coleta de dados a fim de que qualquer risco que possa vir a ocorrer seja plenamente contornado. Espera-se com esta pesquisa entender possíveis benefícios diretos com o recebimento dos resultados de todas as análises fonéticas que serão feitas. Os benefícios indiretos estão relacionados com a utilização dos resultados da pesquisa para possibilitar o planejamento de ações exclusivas para Fonoaudiólogos que atuam na terapia de fala, e assim contribuir gerando maior visibilidade para a profissão em âmbito nacional. Em qualquer etapa do estudo, você terá acesso aos pesquisadores para eventuais dúvidas.',
    textAlign: TextAlign.justify,
    style: contentStyle,
  ),
  Text(
    '       Se você concordar em participar do estudo, seu nome e identidade serão mantidos em sigilo. A menos que requerido por lei ou por sua solicitação, somente o pesquisador, a equipe do estudo, Comitê de Ética independente e inspetores de agências reguladoras do governo (quando necessário) terão acesso a suas informações para verificar as informações do estudo.\n',
    textAlign: TextAlign.justify,
    style: contentStyle,
  ),
  Text(
    'CONSENTIMENTO DA PARTICIPAÇÃO DO PARTICIPANTE NA PESQUISA\n',
    style: titleStyle,
    textAlign: TextAlign.center,
  ),
  Text(
    '       Eu,	, abaixo assinado, concordo em participar da pesquisa “ComuniCARE APRAXIA: APLICATIVO PARA TERAPIA DOS DISTÚRBIOS NEUROLÓGICOS ADQUIRIDOS DE FALA”, como participante. Tive pleno conhecimento das informações que li ou que foram lidas para mim, descrevendo o estudo. Li os termos explicitados e entendo sobre a minha decisão em participar desse estudo. Ficaram claros para mim quais serão os propósitos do estudo, os procedimentos a serem realizados, seus riscos, as garantias de confidencialidade e de esclarecimentos permanentes. Ficou claro também que minha participação é isenta de despesas. Assim, concordo em participar do trabalho de pesquisa, exposto acima, confirmando a minha participação voluntária por meio da seleção do botão CONCORDO. Caso deseje, poderei imprimir ou salvar uma via deste teor deste TCLE.',
    textAlign: TextAlign.justify,
    style: contentStyle,
  ),
];
