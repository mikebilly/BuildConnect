import 'package:buildconnect/core/services/supabase/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Supabase Client Provider
import '../services/notification_service.dart';

part 'notification_service_provider.g.dart';

@Riverpod(keepAlive: true)
NotificationService notificationService(NotificationServiceRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return NotificationService(supabaseClient);
}
