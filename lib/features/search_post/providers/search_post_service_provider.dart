// lib/features/search_post/providers/search_post_service_provider.dart
import 'package:buildconnect/core/services/supabase/supabase_client_provider.dart';
// ĐẢM BẢO IMPORT ĐÚNG SearchPostService
import 'package:buildconnect/features/search_post/services/search_post_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:supabase_flutter/supabase_flutter.dart'; // Chỉ cần cho type

part 'search_post_service_provider.g.dart';

@Riverpod(keepAlive: true)
SearchPostService searchPostService(SearchPostServiceRef ref) {
  // <-- Kiểu trả về là SearchPostService
  final supabase = ref.watch(supabaseClientProvider);
  return SearchPostService(
    supabase,
  ); // <-- Trả về instance của SearchPostService
}
