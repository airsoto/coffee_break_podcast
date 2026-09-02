import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_state.dart';
import 'audio_controller.dart';
import 'models.dart';

String clock(int seconds) { final h = seconds ~/ 3600, m = (seconds % 3600) ~/ 60, s = seconds % 60; return h > 0 ? '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}' : '$m:${s.toString().padLeft(2, '0')}'; }

class RootScreen extends StatefulWidget { const RootScreen({super.key}); @override State<RootScreen> createState() => _RootScreenState(); }
class _RootScreenState extends State<RootScreen> {
  int index = 0;
  @override Widget build(BuildContext context) {
    final pages = [const EpisodesScreen(), const SearchScreen(), const LibraryScreen(), const SettingsScreen()];
    return Scaffold(
      body: SafeArea(child: Column(children: [Expanded(child: IndexedStack(index: index, children: pages)), const MiniPlayer()])),
      bottomNavigationBar: NavigationBar(selectedIndex: index, onDestinationSelected: (v) => setState(() => index = v), destinations: const [
        NavigationDestination(icon: Icon(Icons.podcasts), label: 'Episodios'), NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'), NavigationDestination(icon: Icon(Icons.bookmarks_outlined), label: 'Biblioteca'), NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Ajustes'),
      ]),
    );
  }
}

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({super.key});
  @override Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    if (state.loading && state.episodes.isEmpty) return const Center(child: CircularProgressIndicator());
    if (state.error != null && state.episodes.isEmpty) return EmptyState(text: state.error!, action: () => state.refresh(manual: true));
    return RefreshIndicator(onRefresh: () => state.refresh(manual: true), child: CustomScrollView(slivers: [
      SliverAppBar.large(actions: [IconButton(tooltip: 'Información del podcast', icon: const Icon(Icons.info_outline), onPressed: () => _showPodcastInfo(context, state))], title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Coffee Break'), Text('${state.episodes.length} episodios${state.fromCache ? ' · sin conexión' : ''}', style: Theme.of(context).textTheme.bodySmall)])),
      SliverPadding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 20), sliver: SliverGrid.builder(
        itemCount: state.episodes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: .54),
        itemBuilder: (_, i) => EpisodeGridCard(episode: state.episodes[i]),
      )),
    ]));
  }
}

class SearchScreen extends StatefulWidget { const SearchScreen({super.key}); @override State<SearchScreen> createState() => _SearchScreenState(); }
class _SearchScreenState extends State<SearchScreen> {
  String query = '', participant = 'Todos', topic = 'Todos'; int year = 0;
  @override Widget build(BuildContext context) {
    final all = context.watch<AppState>().episodes;
    final years = all.map((e) => e.year).where((e) => e > 0).toSet().toList()..sort((a,b) => b.compareTo(a));
    final participants = all.expand((e) => e.participants).toSet().toList()..sort();
    final topics = all.expand((e) => e.topics.map((t) => t.title)).toSet().toList()..sort();
    final q = query.trim().toLowerCase();
    final results = all.where((e) => (q.isEmpty || e.searchable.contains(q)) && (year == 0 || e.year == year) && (participant == 'Todos' || e.participants.contains(participant)) && (topic == 'Todos' || e.topics.any((t) => t.title == topic))).toList();
    return Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(16, 16, 16, 8), child: SearchBar(hintText: 'Título, tema, participante o texto…', leading: const Icon(Icons.search), onChanged: (v) => setState(() => query = v))),
      SizedBox(height: 52, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 12), children: [
        FilterMenu(label: year == 0 ? 'Año' : '$year', values: ['Todos', ...years.map((e) => '$e')], onSelected: (v) => setState(() => year = int.tryParse(v) ?? 0)),
        FilterMenu(label: participant == 'Todos' ? 'Participante' : participant, values: ['Todos', ...participants], onSelected: (v) => setState(() => participant = v)),
        FilterMenu(label: topic == 'Todos' ? 'Tema' : topic, values: ['Todos', ...topics], onSelected: (v) => setState(() => topic = v)),
      ])),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(children: [Expanded(child: Text('${results.length} resultados')), if (results.isNotEmpty) TextButton.icon(onPressed: () => _createSearchPlaylist(context, context.read<AppState>(), results, q), icon: const Icon(Icons.playlist_add), label: const Text('Crear lista'))])),
      Expanded(child: ListView.builder(padding: const EdgeInsets.all(12), itemCount: results.length, itemBuilder: (_, i) => EpisodeTile(episode: results[i]))),
    ]);
  }
}

class FilterMenu extends StatelessWidget { const FilterMenu({super.key, required this.label, required this.values, required this.onSelected}); final String label; final List<String> values; final ValueChanged<String> onSelected;
  @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(right: 8), child: MenuAnchor(builder: (_, c, __) => ActionChip(label: Text(label, overflow: TextOverflow.ellipsis), onPressed: c.open), menuChildren: values.map((v) => MenuItemButton(onPressed: () => onSelected(v), child: SizedBox(width: 210, child: Text(v, overflow: TextOverflow.ellipsis)))).toList()));
}

class EpisodeTile extends StatelessWidget {
  const EpisodeTile({super.key, required this.episode}); final Episode episode;
  @override Widget build(BuildContext context) { final state = context.watch<AppState>(); final p = state.progress[episode.id] ?? 0;
    return Card(child: InkWell(borderRadius: BorderRadius.circular(12), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EpisodeDetail(episode: episode))), child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
      ClipRRect(borderRadius: BorderRadius.circular(10), child: episode.imageUrl.isEmpty ? const ColoredBox(color: Color(0xFF2C2925), child: SizedBox(width: 68,height: 68,child: Icon(Icons.graphic_eq))) : Image.network(episode.imageUrl, width: 68,height: 68,fit: BoxFit.cover, errorBuilder: (_,__,___) => const SizedBox(width:68,height:68,child:Icon(Icons.podcasts)))),
      const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(episode.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 6), Text([if (episode.published != null) DateFormat('dd/MM/yyyy').format(episode.published!), if (episode.part.isNotEmpty) 'Parte ${episode.part}', clock(episode.durationSeconds)].join(' · '), style: Theme.of(context).textTheme.bodySmall), if (p > 0) Padding(padding: const EdgeInsets.only(top: 8), child: LinearProgressIndicator(value: episode.durationSeconds > 0 ? (p / episode.durationSeconds).clamp(0,1).toDouble() : 0))])),
      IconButton(onPressed: () => context.read<AudioController>().play(episode), icon: const Icon(Icons.play_circle_fill)), IconButton(onPressed: () => state.toggleFavorite(episode.id), icon: Icon(state.favorites.contains(episode.id) ? Icons.favorite : Icons.favorite_border)),
    ]))));
  }
}

class EpisodeGridCard extends StatelessWidget {
  const EpisodeGridCard({super.key, required this.episode});
  final Episode episode;
  @override Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EpisodeDetail(episode: episode))),
        child: Padding(padding: const EdgeInsets.all(7), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AspectRatio(aspectRatio: 1, child: ClipRRect(borderRadius: BorderRadius.circular(8), child: episode.imageUrl.isEmpty ? const ColoredBox(color: Color(0xFF2C2925), child: Icon(Icons.podcasts)) : Image.network(episode.imageUrl, fit: BoxFit.cover, errorBuilder: (_,__,___) => const ColoredBox(color: Color(0xFF2C2925), child: Icon(Icons.podcasts))))),
          const SizedBox(height: 6),
          Text(episode.title, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, height: 1.1)),
          const Spacer(),
          Text([if (episode.published != null) DateFormat('dd/MM/yy').format(episode.published!), clock(episode.durationSeconds)].join('\n'), maxLines: 2, style: Theme.of(context).textTheme.labelSmall),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(visualDensity: VisualDensity.compact, padding: EdgeInsets.zero, tooltip: 'Reproducir', onPressed: () => context.read<AudioController>().play(episode), icon: const Icon(Icons.play_circle_fill)),
            IconButton(visualDensity: VisualDensity.compact, padding: EdgeInsets.zero, tooltip: 'Añadir a lista', onPressed: () => _playlistSheet(context, state, episode), icon: const Icon(Icons.playlist_add)),
          ]),
        ])),
      ),
    );
  }
}

class EpisodeDetail extends StatelessWidget {
  const EpisodeDetail({super.key, required this.episode}); final Episode episode;
  @override Widget build(BuildContext context) { final state = context.watch<AppState>(); final notes = state.notes.where((n) => n.episodeId == episode.id).toList();
    return Scaffold(appBar: AppBar(title: Text('Ep. ${episode.number}${episode.part}'), actions: [IconButton(onPressed: () => state.toggleFavorite(episode.id), icon: Icon(state.favorites.contains(episode.id) ? Icons.favorite : Icons.favorite_border)), IconButton(onPressed: () => _playlistSheet(context, state, episode), icon: const Icon(Icons.playlist_add))]), body: ListView(padding: const EdgeInsets.all(16), children: [
      Text(episode.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(episode.participants.join(' · ')), const SizedBox(height: 16), FilledButton.icon(onPressed: () => context.read<AudioController>().play(episode), icon: const Icon(Icons.play_arrow), label: const Text('Reproducir / continuar')),
      const SectionTitle('Temas'), if (episode.topics.isEmpty) const Text('No hay temas en este episodio.') else ...episode.topics.map((t) => ListTile(contentPadding: EdgeInsets.zero, leading: CircleAvatar(child: Text(clock(t.seconds), style: const TextStyle(fontSize: 10))), title: Text(t.title), trailing: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(tooltip: 'Añadir parte a lista', icon: const Icon(Icons.playlist_add), onPressed: () => _playlistSheet(context, state, episode, seconds: t.seconds, label: t.title)), const Icon(Icons.play_arrow)]), onTap: () => context.read<AudioController>().play(episode, atSeconds: t.seconds))),
      const SectionTitle('Papers y referencias'), if (episode.references.isEmpty) const Text('No constan referencias en el JSON actual.') else ...episode.references.map((r) => ListTile(contentPadding: EdgeInsets.zero, title: Text(r.title.isEmpty ? r.doi : r.title), subtitle: Text([if(r.doi.isNotEmpty) 'DOI: ${r.doi}', r.text].where((e)=>e.isNotEmpty).join('\n')), trailing: r.url.isEmpty ? null : const Icon(Icons.open_in_new), onTap: r.url.isEmpty ? null : () => launchUrl(Uri.parse(r.url)))),
      const SectionTitle('Notas locales'), ...notes.map((n) => ListTile(contentPadding: EdgeInsets.zero, leading: Text(clock(n.seconds)), title: Text(n.text), trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => state.removeNote(n.id)))), OutlinedButton.icon(onPressed: () => _noteDialog(context, state, episode), icon: const Icon(Icons.note_add_outlined), label: const Text('Añadir nota en el momento actual')),
      const SectionTitle('Descripción'), SelectableText(episode.description), if (episode.pageUrl.isNotEmpty) TextButton.icon(onPressed: () => launchUrl(Uri.parse(episode.pageUrl)), icon: const Icon(Icons.open_in_new), label: const Text('Abrir página del episodio')),
    ]));
  }
}

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});
  @override Widget build(BuildContext context) { final s = context.watch<AppState>(); final fav = s.episodes.where((e) => s.favorites.contains(e.id)).toList(); final recent = s.history.map(s.byId).whereType<Episode>().toList();
    return DefaultTabController(length: 3, child: Column(children: [const Material(child: TabBar(tabs: [Tab(text:'Favoritos'),Tab(text:'Listas'),Tab(text:'Historial')])), Expanded(child: TabBarView(children: [EpisodeList(items: fav, empty: 'Aún no hay favoritos.'),
      ListView(padding: const EdgeInsets.all(16), children: [FilledButton.icon(onPressed: () => _createPlaylist(context, s), icon: const Icon(Icons.add), label: const Text('Nueva lista')), ...s.playlists.map((p) => ExpansionTile(title: Text(p.name), subtitle: Text('${p.items.length} elementos'), trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => s.deletePlaylist(p.id)), children: p.items.map((item) { final e = s.byId(item.episodeId); if (e == null) return const SizedBox.shrink(); return ListTile(title: Text(item.label.isEmpty ? e.title : item.label), subtitle: Text(item.seconds > 0 ? '${e.title} · ${clock(item.seconds)}' : e.title), leading: const Icon(Icons.play_circle_outline), trailing: IconButton(tooltip: 'Quitar de la lista', icon: const Icon(Icons.remove_circle_outline), onPressed: () => s.removePlaylistItem(p.id, item)), onTap: () => context.read<AudioController>().play(e, atSeconds: item.seconds)); }).toList()))]), EpisodeList(items: recent, empty: 'El historial aparecerá al reproducir episodios.')]))]));
  }
}

class EpisodeList extends StatelessWidget { const EpisodeList({super.key, required this.items, required this.empty}); final List<Episode> items; final String empty; @override Widget build(BuildContext c) => items.isEmpty ? Center(child: Text(empty)) : ListView.builder(padding: const EdgeInsets.all(12), itemCount: items.length, itemBuilder: (_,i)=>EpisodeTile(episode:items[i])); }
class SettingsScreen extends StatelessWidget { const SettingsScreen({super.key}); @override Widget build(BuildContext context) { final s=context.watch<AppState>(); return ListView(padding:const EdgeInsets.all(20),children:[Text('Ajustes',style:Theme.of(context).textTheme.headlineMedium),const SizedBox(height:24),ListTile(leading:const Icon(Icons.cloud_sync),title:const Text('Actualizar catálogo'),subtitle:Text(s.updatedAt == null ? 'Nunca' : '${s.fromCache ? 'Caché' : 'Red'} · ${DateFormat('dd/MM/yyyy HH:mm').format(s.updatedAt!)}'),trailing:s.loading?const CircularProgressIndicator():const Icon(Icons.refresh),onTap:s.loading?null:()=>s.refresh(manual:true)),const ListTile(leading:Icon(Icons.offline_bolt),title:Text('Modo offline'),subtitle:Text('El catálogo, favoritos, listas, notas, historial y progreso se conservan localmente. El audio requiere conexión.')),const ListTile(leading:Icon(Icons.info_outline),title:Text('Fuente de datos'),subtitle:Text('JSON remoto de Coffee Break · sin datos incrustados'))]); } }

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});
  @override Widget build(BuildContext context) {
    final a = context.watch<AudioController>();
    if (a.episode == null) return const SizedBox.shrink();
    final max = (a.duration.inMilliseconds > 0 ? a.duration.inMilliseconds : a.episode!.durationSeconds * 1000).toDouble();
    return Material(color: const Color(0xFF24201C), child: SafeArea(top: false, child: Column(mainAxisSize: MainAxisSize.min, children: [
      Slider(value: a.position.inMilliseconds.clamp(0, max.toInt()).toDouble(), max: max <= 0 ? 1 : max, onChanged: (v) => a.seek(Duration(milliseconds: v.toInt()))),
      Padding(padding: const EdgeInsets.fromLTRB(14, 0, 8, 5), child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(a.episode!.title, maxLines: 1, overflow: TextOverflow.ellipsis), Text('${clock(a.position.inSeconds)} / ${clock((max / 1000).round())}', style: Theme.of(context).textTheme.labelSmall)])),
        IconButton(tooltip: 'Volver al inicio', icon: const Icon(Icons.restart_alt), onPressed: a.restart),
        IconButton(tooltip: 'Atrás 5 segundos', icon: const Icon(Icons.replay_5), onPressed: () => a.skipBy(-5)),
        IconButton(tooltip: a.playing ? 'Pausar' : 'Reproducir', icon: Icon(a.playing ? Icons.pause_circle_filled : Icons.play_circle_fill), iconSize: 34, onPressed: a.toggle),
        IconButton(tooltip: 'Adelante 20 segundos', icon: const Icon(Icons.fast_forward), onPressed: () => a.skipBy(20)),
        IconButton(tooltip: 'Siguiente episodio o parte', icon: const Icon(Icons.skip_next), onPressed: a.next),
      ])),
    ])));
  }
}
class SectionTitle extends StatelessWidget { const SectionTitle(this.text,{super.key}); final String text; @override Widget build(BuildContext c)=>Padding(padding:const EdgeInsets.only(top:28,bottom:8),child:Text(text,style:Theme.of(c).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.bold))); }
class EmptyState extends StatelessWidget { const EmptyState({super.key,required this.text,required this.action}); final String text; final VoidCallback action; @override Widget build(BuildContext c)=>Center(child:Padding(padding:const EdgeInsets.all(30),child:Column(mainAxisSize:MainAxisSize.min,children:[Text(text,textAlign:TextAlign.center),const SizedBox(height:16),FilledButton(onPressed:action,child:const Text('Reintentar'))]))); }

Future<void> _noteDialog(BuildContext context, AppState s, Episode e) async { final c=TextEditingController(); final a=context.read<AudioController>(); final seconds=a.episode?.id==e.id?a.position.inSeconds:(s.progress[e.id]??0); await showDialog(context:context,builder:(x)=>AlertDialog(title:Text('Nota en ${clock(seconds)}'),content:TextField(controller:c,autofocus:true,maxLines:3,decoration:const InputDecoration(hintText:'Tu nota o tema local')),actions:[TextButton(onPressed:()=>Navigator.pop(x),child:const Text('Cancelar')),FilledButton(onPressed:(){if(c.text.trim().isNotEmpty)s.addNote(e.id,seconds,c.text.trim());Navigator.pop(x);},child:const Text('Guardar'))])); }
Future<void> _createPlaylist(BuildContext context, AppState s) async { final c=TextEditingController(); await showDialog(context:context,builder:(x)=>AlertDialog(title:const Text('Nueva lista'),content:TextField(controller:c,autofocus:true,decoration:const InputDecoration(labelText:'Nombre')),actions:[TextButton(onPressed:()=>Navigator.pop(x),child:const Text('Cancelar')),FilledButton(onPressed:(){if(c.text.trim().isNotEmpty)s.createPlaylist(c.text.trim());Navigator.pop(x);},child:const Text('Crear'))])); }
void _playlistSheet(BuildContext context, AppState s, Episode e, {int seconds = 0, String label = ''}) {
  showModalBottomSheet(context: context, builder: (x) => SafeArea(child: Column(mainAxisSize: MainAxisSize.min, children: [
    ListTile(title: Text(seconds > 0 ? 'Añadir o quitar esta parte' : 'Añadir o quitar el episodio'), subtitle: Text(seconds > 0 ? '${label.isEmpty ? e.title : label} · ${clock(seconds)}' : e.title)),
    if (s.playlists.isEmpty) const Padding(padding: EdgeInsets.all(20), child: Text('Crea primero una lista en Biblioteca.')),
    ...s.playlists.map((p) => CheckboxListTile(title: Text(p.name), value: p.items.any((i) => i.episodeId == e.id && i.seconds == seconds), onChanged: (_) => s.togglePlaylist(p.id, e.id, seconds: seconds, label: label))),
  ])));
}

Future<void> _createSearchPlaylist(BuildContext context, AppState state, List<Episode> results, String query) async {
  final title = TextEditingController(text: query.isEmpty ? 'Resultados de búsqueda' : 'Buscar: $query');
  await showDialog(context: context, builder: (dialog) => AlertDialog(title: const Text('Lista desde resultados'), content: TextField(controller: title, autofocus: true, decoration: const InputDecoration(labelText: 'Nombre de la lista')), actions: [TextButton(onPressed: () => Navigator.pop(dialog), child: const Text('Cancelar')), FilledButton(onPressed: () { final items = <PlaylistItem>[]; for (final e in results) { final matching = query.isEmpty ? e.topics : e.topics.where((t) => t.title.toLowerCase().contains(query)).toList(); if (matching.isEmpty) { items.add(PlaylistItem(episodeId: e.id, label: e.title)); } else { for (final t in matching) { items.add(PlaylistItem(episodeId: e.id, seconds: t.seconds, label: t.title)); } } } state.createPlaylistFromSearch(title.text.trim().isEmpty ? 'Resultados de búsqueda' : title.text.trim(), items); Navigator.pop(dialog); }, child: const Text('Crear'))]));
}

void _showPodcastInfo(BuildContext context, AppState state) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: .72,
      minChildSize: .4,
      maxChildSize: .94,
      expand: false,
      builder: (_, controller) => FutureBuilder<PodcastInfo>(
        future: state.repository.loadInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('No se pudo cargar la información. Se mostrará cuando el JSON esté publicado o exista caché.')));
          final info = snapshot.data!;
          return ListView(
            controller: controller,
            padding: const EdgeInsets.all(20),
            children: [
              Text(info.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text([info.genre, info.language, info.country].where((v) => v.isNotEmpty).join(' · ')),
              const SizedBox(height: 16),
              Text(info.description),
              const SectionTitle('Desarrollado por Angel Soto'),
              const Text('Soy un veterinario clínico de pequeños animales, apasionado por la ciencia en general y la física en particular, que ha querido agradecer a todo el equipo de Señal y Ruido todos estos años de enseñanza con esta aplicación. Con toda mi admiración hacia todos los integrantes del programa.'),
              const SizedBox(height: 8),
              const Text('Angel Soto (septiembre de 2026)', style: TextStyle(fontStyle: FontStyle.italic)),
              const SectionTitle('Colaboradores'),
              ...info.collaborators.map((c) => ExpansionTile(title: Text(c.name), subtitle: Text(c.role), children: [Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), child: Text(c.info))])),
              if (info.website.isNotEmpty) TextButton.icon(onPressed: () => launchUrl(Uri.parse(info.website)), icon: const Icon(Icons.open_in_new), label: const Text('Sitio web')),
            ],
          );
        },
      ),
    ),
  );
}
