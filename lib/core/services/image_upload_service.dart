import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ImageUploadService {
  final SupabaseClient supabase = Supabase.instance.client;

  /// ضغط وتحويل الصور قبل الرفع
  Future<Uint8List> _compressImage(Uint8List data) async {
    final result = await FlutterImageCompress.compressWithList(
      data,
      minHeight: 800,
      minWidth: 800,
      quality: 65,
      format: CompressFormat.webp, // تحويل إلى WebP
    );

    return Uint8List.fromList(result);
  }

  /// رفع الصورة وإرجاع رابطها
  Future<String?> uploadImage({
    required Uint8List bytes,
    required String bucket,
    String? folder,
  }) async {
    try {
      // 1) ضغط + تحويل WebP
      final compressed = await _compressImage(bytes);

      // 2) مسار التخزين
      final imageId = const Uuid().v4();
      final path = folder != null ? "$folder/$imageId.webp" : "$imageId.webp";

      // 3) الرفع
      final response = await supabase.storage.from(bucket).uploadBinary(
        path,
        compressed,
        fileOptions: const FileOptions(
          contentType: "image/webp",
        ),
      );

      if (response.isEmpty) return null;

      // 4) URL النهائي
      final imageUrl = supabase.storage.from(bucket).getPublicUrl(path);
      return imageUrl;

    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }
}
