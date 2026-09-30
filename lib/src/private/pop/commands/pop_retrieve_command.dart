import '../../../../envoy_mail_core.dart';
import '../parsers/all_parsers.dart';
import '../pop_command.dart';

/// Retrieves a specific or all messages
class PopRetrieveCommand extends PopCommand<MimeMessage> {
  /// Creates a new `RETR` command
  PopRetrieveCommand(int messageId)
    : super('RETR $messageId', parser: PopRetrieveParser(), isMultiLine: true);
}
