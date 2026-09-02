import 'package:flutter_test/flutter_test.dart';
import 'package:pod_stream/src/models.dart';

void main() {
  test('interpreta el esquema remoto 2.0', () {
    final episode = Episode.fromJson({'id':'abc','episode_number':568,'part':'B','title':'Ep568_B','duration_seconds':120,'audio':{'url':'https://example.com/audio.mp3'},'topics':[{'title':'Magnetar','timestamp':'00:30','timestamp_seconds':30}],'participants':['Héctor'],'references':[{'title':'Paper','doi':'10.1/test'}]});
    expect(episode.audioUrl, endsWith('audio.mp3'));
    expect(episode.topics.single.seconds, 30);
    expect(episode.searchable, contains('10.1/test'));
  });
}
