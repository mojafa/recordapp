import 'package:record_app/models/Track.dart';
import 'package:record_app/providers/BaseProvider.dart';

class PodcastProvider extends BaseProvider {
  PodcastProvider() {
    fetchPodcasts();
  }

  Map<String, String> params = {};

  List<Track> _podcasts = <Track>[];
  List<Track> get podcasts => _podcasts;

  Track _podcast;
  Track get podcast => _podcast;

  int _page = 0;
  bool _hasMoreItems = true;

  void setHttpRequestPrams() {
    params.update(
      'page',
      (existingValue) => _page.toString(),
      ifAbsent: () => '1',
    );
  }

  void fetchPodcasts() async {
    _page++;
    if (_page == 1) isLoaded = false;
    if (!_hasMoreItems) return;
    isLoadingMoreInProgress = true;

    notifyListeners();

    /// Setting request paramerters
    setHttpRequestPrams();

    /// Fetch items from server: pass endping and parameters
    List items = await fetch('podcasts', params);

    /// if no more items stop further request
    if (items.length == 0) {
      _hasMoreItems = false;
      notifyListeners();
      return;
    }

    items.forEach((item) {
      var newItem = new Track.fromJson(item);
      _podcasts.add(newItem);
    });

    isLoadingMoreInProgress = false;
    isLoaded = true;

    notifyListeners();
  }
}
