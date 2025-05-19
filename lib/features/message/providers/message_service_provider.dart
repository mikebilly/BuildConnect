import 'package:buildconnect/core/services/supabase/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/message_service.dart';

part 'message_service_provider.g.dart';

@Riverpod(keepAlive: true) // Giữ service tồn tại
MessageService messageService(MessageServiceRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return MessageService(supabaseClient);
}
