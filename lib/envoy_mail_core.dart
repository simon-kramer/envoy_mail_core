/// With envoy_mail_core you can connect to any mail service via IMAP, POP3
/// and SMTP.
///
/// You can choose between a high-level API starting with `MailClient` and the
///  low-level APIs `ImapClient`, `PopClient` and `SmtpClient`.
///
/// Generate a new `MimeMessage` with `MessageBuilder`.
///
/// Discover connection settings with `Discover`.
library;

export 'codecs.dart';
export 'discover.dart';
export 'highlevel.dart';
export 'imap.dart';
export 'mime.dart';
export 'pop.dart';
export 'smtp.dart';
export 'src/exception.dart';
