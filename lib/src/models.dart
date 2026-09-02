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
  Playlist({required this.id, required this.name, required this.episodeIds});
  final String id, name;
  final Set<String> episodeIds;
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'episodeIds': episodeIds.toList()};
  factory Playlist.fromJson(Map<String, dynamic> j) => Playlist(id: _s(j['id']), name: _s(j['name']), episodeIds: _list(j['episodeIds']).map(_s).toSet());
}

String encodeList(Iterable<Map<String, dynamic>> values) => jsonEncode(values.toList());
