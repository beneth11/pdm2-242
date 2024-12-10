import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {
  // Informações da conta de e-mail
  final String username = ''; // Substitua pelo seu e-mail
  final String password = ''; // Substitua pela senha de aplicativo. É necessario uma senha de app para proseguir

  // Configuração do servidor SMTP
  final smtpServer = gmail(username, password);

  // Criando o e-mail
  final message = Message()
    ..from = Address(username, '') // Nome opcional
    ..recipients.add('') // Substitua pelo e-mail do destinatário
    ..subject = 'Teste de Envio de Email com Dart'
    ..text = 'Este é um e-mail enviado automaticamente pelo programa Dart.'
    ..html = "<h1>Olá!</h1>\n<p>Este e-mail foi enviado utilizando o Dart!</p>";

  try {
    // Enviando o e-mail
    final sendReport = await send(message, smtpServer);
    print('E-mail enviado com sucesso: ${sendReport.toString()}');
  } on MailerException catch (e) {
    print('Falha no envio do e-mail: $e');
    for (var p in e.problems) {
      print('Problema: ${p.code}: ${p.msg}');
    }
  }
}