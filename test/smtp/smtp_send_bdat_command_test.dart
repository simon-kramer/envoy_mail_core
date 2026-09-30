import 'package:enough_mail/enough_mail.dart';
import 'package:enough_mail/src/private/smtp/commands/smtp_send_bdat_command.dart';
import 'package:test/test.dart';

void main() {
  group('SmtpSendBdatMailCommand', () {
    test('strips a Bcc header that was folded onto continuation lines', () {
      final message =
          (MessageBuilder()
                ..from = const [MailAddress('Me', 'me@example.com')]
                ..to = const [MailAddress('You', 'you@example.com')]
                ..bcc = [
                  for (var i = 0; i < 6; i++)
                    MailAddress(
                      'Hidden Recipient Number $i',
                      'hidden.recipient.$i@example.com',
                    ),
                ]
                ..subject = 'Hello'
                ..addTextPlain('Body'))
              .buildMimeMessage();
      expect(
        message.renderMessage(),
        contains('\r\n\t'),
        reason: 'the fixture must actually fold the Bcc header',
      );

      final command = SmtpSendBdatMailCommand(
        message,
        null,
        message.recipientAddresses,
        use8BitEncoding: false,
        supportUnicode: false,
      );
      final data = command.getData();

      expect(data, isNot(contains('Bcc')));
      expect(data, isNot(contains('hidden.recipient')));
      expect(data, contains('To: "You" <you@example.com>\r\n'));
      expect(data, contains('Body'));
    });
  });
}
