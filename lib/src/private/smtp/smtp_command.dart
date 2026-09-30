import 'dart:async';

import '../../smtp/smtp_response.dart';

/// The `Bcc` header line and every folded continuation line under it.
///
/// `Header.render` folds a value longer than
/// `MailConventions.textLineMaxLength` onto `\r\n\t`-prefixed lines, which
/// three or four addresses already do. Matching only the first physical line
/// left the rest of the list in the DATA that every To/Cc recipient received.
///
/// Stripped from the rendered message before it is sent, since `Bcc`
/// recipients must not be visible to the other recipients.
final bccHeaderPattern = RegExp(
  r'^Bcc:.*\r\n(?:[ \t].*\r\n)*',
  multiLine: true,
);

/// Contains a SMTP command
class SmtpCommand {
  /// Creates a new command
  SmtpCommand(this._command);

  final String _command;

  /// Retrieves the command
  String get command => _command;

  /// The completer of this command
  final Completer<SmtpResponse> completer = Completer<SmtpResponse>();

  /// Tries to retrieve the next command data
  SmtpCommandData? next(SmtpResponse response) {
    final text = nextCommand(response);
    if (text != null) {
      return SmtpCommandData(text, null);
    }
    final data = nextCommandData(response);
    if (data != null) {
      return SmtpCommandData(null, data);
    }

    return null;
  }

  /// Tries to retrieve the next command
  String? nextCommand(SmtpResponse response) => null;

  /// Tries to return the next command data
  List<int>? nextCommandData(SmtpResponse response) => null;

  /// Checks if the current command is done
  bool isCommandDone(SmtpResponse response) => true;

  @override
  String toString() => command;
}

/// Contains command-specific data
class SmtpCommandData {
  /// Creates a new data
  SmtpCommandData(this.text, this.data);

  /// The textual data
  final String? text;

  /// The binary data
  final List<int>? data;
}
