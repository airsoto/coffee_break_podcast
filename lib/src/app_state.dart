import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';
import 'repository.dart';

class AppState extends ChangeNotifier {
  final repository = CatalogRepository();
  late SharedPreferences _prefs;
  List<Episode> episodes = [];
  Set<String> favorites = {};
  List<Playlist> playlists = [];
  List<LocalNote> notes = [];
  Map<String, int> progress = {};
  List<String> history = [];
  bool loading = true, fromCache = false;
  String? error;
  DateTime? updatedAt;
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    favorites = (_prefs.getStringList('favorites') ?? []).toSet();
    history = _prefs.getStringList('history') ?? [];
    try { progress = Map<String, dynamic>.from(jsonDecode(_prefs.getString('progress') ?? '{}')).map((k, v) => MapEntry(k, (v as num).toInt())); } catch (_) {}
    playlists = _decode('playlists').map(Playlist.fromJson).toList();
    notes = _decode('notes').map(LocalNote.fromJson).toList();
    await refresh();
  }
  List<Map<String, dynamic>> _decode(String key) { try { return (jsonDecode(_prefs.getString(key) ?? '[]') as List).whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList(); } catch (_) { return []; } }
  Future<void> refresh({bool manual = false}) async {
    loading = true; error = null; notifyListeners();
    try { final r = await repository.load(forceRefresh: manual); episodes = r.episodes; fromCache = r.fromCache; updatedAt = r.updatedAt; }
    catch (_) { error = 'No se pudo cargar el catálogo. Conéctate a internet y vuelve a intentarlo.'; }
    loading = false; notifyListeners();
  }
  void toggleFavorite(String id) { favorites.contains(id) ? favorites.remove(id) : favorites.add(id); _prefs.setStringList('favorites', favorites.toList()); notifyListeners(); }
  void setProgress(String id, int seconds) { progress[id] = seconds; _prefs.setString('progress', jsonEncode(progress)); }
  void recordPlayed(String id) { history.remove(id); history.insert(0, id); if (history.length > 100) history.removeRange(100, history.length); _prefs.setStringList('history', history); notifyListeners(); }
  void addNote(String episodeId, int seconds, String text) { notes.add(LocalNote(id: DateTime.now().microsecondsSinceEpoch.toString(), episodeId: episodeId, seconds: seconds, text: text)); _saveNotes(); }
  void removeNote(String id) { notes.removeWhere((e) => e.id == id); _saveNotes(); }
  void _saveNotes() { _prefs.setString('notes', encodeList(notes.map((e) => e.toJson()))); notifyListeners(); }
  void createPlaylist(String name) { playlists.add(Playlist(id: DateTime.now().microsecondsSinceEpoch.toString(), name: name, items: [])); _savePlaylists(); }
  void createPlaylistFromSearch(String name, List<PlaylistItem> items) { playlists.add(Playlist(id: DateTime.now().microsecondsSinceEpoch.toString(), name: name, items: items)); _savePlaylists(); }
  void deletePlaylist(String id) { playlists.removeWhere((e) => e.id == id); _savePlaylists(); }
  void togglePlaylist(String playlistId, String episodeId) { final p = playlists.firstWhere((e) => e.id == playlistId); final index = p.items.indexWhere((e) => e.episodeId == episodeId && e.seconds == 0); index >= 0 ? p.items.removeAt(index) : p.items.add(PlaylistItem(episodeId: episodeId)); _savePlaylists(); }
  void _savePlaylists() { _prefs.setString('playlists', encodeList(playlists.map((e) => e.toJson()))); notifyListeners(); }
  Episode? byId(String id) { for (final e in episodes) { if (e.id == id) return e; } return null; }
}
