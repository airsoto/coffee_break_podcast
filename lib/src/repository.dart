import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'models.dart';

class CatalogResult {
  CatalogResult(this.episodes, this.fromCache, this.updatedAt);
  final List<Episode> episodes;
  final bool fromCache;
  final DateTime? updatedAt;
}

class CatalogRepository {
  static const remoteUrl = 'https://airsoto.github.io/vet/json/coffee_break_APP/coffee_break.json';
  static const infoUrl = 'https://airsoto.github.io/vet/json/coffee_break_APP/coffeebreakinfo.json';
  Future<File> _file() async => File('${(await getApplicationSupportDirectory()).path}/coffee_break_catalog.json');
  Future<CatalogResult> load({bool forceRefresh = false}) async {
    final file = await _file();
    if (!forceRefresh && await file.exists() && DateTime.now().difference(await file.lastModified()) < const Duration(hours: 12)) return _parse(await file.readAsString(), true, await file.lastModified());
    try {
      final response = await http.get(Uri.parse(remoteUrl)).timeout(const Duration(seconds: 30));
      if (response.statusCode < 200 || response.statusCode >= 300) throw HttpException('HTTP ${response.statusCode}');
      await file.parent.create(recursive: true);
      await file.writeAsBytes(response.bodyBytes, flush: true);
      return _parse(utf8.decode(response.bodyBytes), false, DateTime.now());
    } catch (_) {
      if (await file.exists()) return _parse(await file.readAsString(), true, await file.lastModified());
      rethrow;
    }
  }
  CatalogResult _parse(String source, bool cached, DateTime? updated) {
    final decoded = jsonDecode(source);
    final list = decoded is Map ? decoded['episodes'] : decoded;
    if (list is! List) throw const FormatException('Falta episodes');
    final items = list.whereType<Map>().map((e) => Episode.fromJson(Map<String, dynamic>.from(e))).where((e) => e.id.isNotEmpty).toList()..sort((a, b) => (b.published ?? DateTime(0)).compareTo(a.published ?? DateTime(0)));
    return CatalogResult(items, cached, updated);
  }

  Future<PodcastInfo> loadInfo() async {
    final file = File('${(await getApplicationSupportDirectory()).path}/coffee_break_info.json');
    try {
      final response = await http.get(Uri.parse(infoUrl)).timeout(const Duration(seconds: 20));
      if (response.statusCode < 200 || response.statusCode >= 300) throw HttpException('HTTP ${response.statusCode}');
      await file.parent.create(recursive: true);
      await file.writeAsBytes(response.bodyBytes, flush: true);
      return PodcastInfo.fromJson(jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);
    } catch (_) {
      if (await file.exists()) return PodcastInfo.fromJson(jsonDecode(await file.readAsString()) as Map<String, dynamic>);
      rethrow;
    }
  }
}
