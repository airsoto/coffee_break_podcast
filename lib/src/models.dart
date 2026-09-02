import 'dart:convert';
import 'dart:io';

String _s(dynamic v) => v?.toString().trim() ?? '';
int _i(dynamic v) => v is num ? v.toInt() : int.tryParse(_s(v)) ?? 0;
List<dynamic> _list(dynamic v) => v is List ? v : const [];
DateTime? _date(dynamic v) {
  final text = _s(v);
  if (text.isEmpty) return null;
  final iso = DateTime.tryParse(text);
  if (iso != null) return iso;
  try { return HttpDate.parse(text); } catch (_) { return null; }
}

class Topic {
  Topic({required this.title, required this.seconds, required this.timestamp});
  final String title, timestamp;
  final int seconds;
  factory Topic.fromJson(Map<String, dynamic> j) => Topic(title: _s(j['title'] ?? j['name'] ?? j['topic']), seconds: _i(j['timestamp_seconds'] ?? j['seconds'] ?? j['start']), timestamp: _s(j['timestamp'] ?? j['time']));
}

class PaperReference {
  PaperReference({required this.title, required this.doi, required this.url, required this.text});
  final String title, doi, url, text;
  factory PaperReference.fromJson(dynamic v) {
    if (v is String) return PaperReference(title: v, doi: '', url: '', text: v);
    final j = v is Map ? Map<String, dynamic>.from(v) : <String, dynamic>{};
    return PaperReference(title: _s(j['title'] ?? j['name'] ?? j['citation']), doi: _s(j['doi'] ?? j['DOI']), url: _s(j['url'] ?? j['link']), text: _s(j['text'] ?? j['description'] ?? j['raw']));
  }
  String get searchable => '$title $doi $url $text'.toLowerCase();
}

class Episode {
  Episode({required this.id, required this.number, required this.part, required this.title, required this.published, required this.durationSeconds, required this.audioUrl, required this.imageUrl, required this.pageUrl, required this.topics, required this.participants, required this.references, required this.description});
  final String id, part, title, audioUrl, imageUrl, pageUrl, description;
  final int number, durationSeconds;
  final DateTime? published;
  final List<Topic> topics;
  final List<String> participants;
  final List<PaperReference> references;
  factory Episode.fromJson(Map<String, dynamic> j) {
    final audio = j['audio'] is Map ? Map<String, dynamic>.from(j['audio']) : <String, dynamic>{};
    final raw = j['raw'] is Map ? Map<String, dynamic>.from(j['raw']) : <String, dynamic>{};
    return Episode(
      id: _s(j['id'] ?? j['guid'] ?? j['episode_number']), number: _i(j['episode_number'] ?? j['episode']), part: _s(j['part']), title: _s(j['title']),
      published: _date(j['published'] ?? j['date']), durationSeconds: _i(j['duration_seconds'] ?? j['duration']),
      audioUrl: _s(j['mp3_url'] ?? audio['url'] ?? j['audio_url']), imageUrl: _s(j['image'] ?? j['image_url']), pageUrl: _s(j['page_url'] ?? j['url']),
      topics: _list(j['topics']).whereType<Map>().map((e) => Topic.fromJson(Map<String, dynamic>.from(e))).toList(), participants: _list(j['participants']).map(_s).where((e) => e.isNotEmpty).toList(),
      references: _list(j['references'] ?? j['papers']).map(PaperReference.fromJson).toList(), description: _s(raw['official_content_text'] ?? raw['rss_description_text'] ?? j['description']),
    );
  }
  int get year => published?.year ?? 0;
  bool get hasReferences => references.isNotEmpty;
  String get searchable => [title, part, description, participants.join(' '), topics.map((e) => e.title).join(' '), references.map((e) => e.searchable).join(' ')].join(' ').toLowerCase();
}

class LocalNote {
  LocalNote({required this.id, required this.episodeId, required this.seconds, required this.text});
  final String id, episodeId, text;
  final int seconds;
  Map<String, dynamic> toJson() => {'id': id, 'episodeId': episodeId, 'seconds': seconds, 'text': text};
  factory LocalNote.fromJson(Map<String, dynamic> j) => LocalNote(id: _s(j['id']), episodeId: _s(j['episodeId']), seconds: _i(j['seconds']), text: _s(j['text']));
}

class Playlist {
  Playlist({required this.id, required this.name, required this.items});
  final String id, name;
  final List<PlaylistItem> items;
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'items': items.map((e) => e.toJson()).toList()};
  factory Playlist.fromJson(Map<String, dynamic> j) {
    final saved = _list(j['items']);
    return Playlist(id: _s(j['id']), name: _s(j['name']), items: saved.isNotEmpty ? saved.whereType<Map>().map((e) => PlaylistItem.fromJson(Map<String, dynamic>.from(e))).toList() : _list(j['episodeIds']).map((e) => PlaylistItem(episodeId: _s(e))).toList());
  }
}

class PlaylistItem {
  PlaylistItem({required this.episodeId, this.seconds = 0, this.label = ''});
  final String episodeId, label;
  final int seconds;
  Map<String, dynamic> toJson() => {'episodeId': episodeId, 'seconds': seconds, 'label': label};
  factory PlaylistItem.fromJson(Map<String, dynamic> j) => PlaylistItem(episodeId: _s(j['episodeId']), seconds: _i(j['seconds']), label: _s(j['label']));
}

class PodcastInfo {
  PodcastInfo({required this.name, required this.description, required this.genre, required this.language, required this.country, required this.website, required this.collaborators});
  final String name, description, genre, language, country, website;
  final List<Collaborator> collaborators;
  factory PodcastInfo.fromJson(Map<String, dynamic> j) {
    final p = j['podcast'] is Map ? Map<String, dynamic>.from(j['podcast']) : j;
    return PodcastInfo(name: _s(p['nombre'] ?? p['name']), description: _s(p['descripcion'] ?? p['description']), genre: _s(p['genero'] ?? p['genre']), language: _s(p['idioma'] ?? p['language']), country: _s(p['pais'] ?? p['country']), website: _s(p['sitio_web'] ?? p['website']), collaborators: _list(p['colaboradores'] ?? p['collaborators']).whereType<Map>().map((e) => Collaborator.fromJson(Map<String, dynamic>.from(e))).toList());
  }
}

class Collaborator {
  Collaborator({required this.name, required this.role, required this.info});
  final String name, role, info;
  factory Collaborator.fromJson(Map<String, dynamic> j) => Collaborator(name: _s(j['nombre'] ?? j['name']), role: _s(j['rol'] ?? j['role']), info: _s(j['informacion'] ?? j['info']));
}

String encodeList(Iterable<Map<String, dynamic>> values) => jsonEncode(values.toList());
