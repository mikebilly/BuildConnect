import 'package:buildconnect/core/services/supabase/supabase_client_provider.dart';
import 'package:buildconnect/features/conversation/services/conversation_service.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_service_provider.g.dart';

@Riverpod(keepAlive: true) // Giữ service tồn tại
ConversationService conversationService(Ref ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return ConversationService(supabaseClient);
}
