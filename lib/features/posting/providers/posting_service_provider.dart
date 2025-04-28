import 'package:buildconnect/features/posting/services/posting_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/core/services/supabase/supabase_client_provider.dart';

part 'posting_service_provider.g.dart';

@Riverpod(keepAlive: true)
PostingService postingService(Ref ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return PostingService(supabase);
}
