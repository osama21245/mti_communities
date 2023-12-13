import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'messages_loading.dart';

class AudioLoading {
  final bool loading;

  AudioLoading(this.loading);
}

final AudioloadingProvider = StateProvider<Loading?>((ref) => null);
