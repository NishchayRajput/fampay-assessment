import 'package:shared_preferences/shared_preferences.dart';

class CardsLocal {
  static const _kDismissed = 'cc_dismissed_ids_v1';
  static const _kRemindSession = 'cc_session_remind_ids_v1';
  static const _kSessionStarted = 'cc_session_started_at_v1';

  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  Future<Set<String>> _getSet(String key) async {
    final p = await _prefs;
    return (p.getStringList(key) ?? const <String>[]).toSet();
  }

  Future<void> _putSet(String key, Set<String> set) async {
    final p = await _prefs;
    await p.setStringList(key, set.toList());
  }

  Future<Set<String>> getDismissedIds() => _getSet(_kDismissed);

  Future<void> addDismissed(String id) async {
    final cur = await getDismissedIds();
    cur.add(id);
    await _putSet(_kDismissed, cur);
  }

  Future<Set<String>> getSessionRemindLaterIds() async {
    final p = await _prefs;
    final startedAt = p.getInt(_kSessionStarted);
    final now = DateTime.now().millisecondsSinceEpoch;
    // If no session or more than ~12h passed, reset session (they re-appear next start)
    if (startedAt == null || now - startedAt > 12 * 60 * 60 * 1000) {
      await p.setInt(_kSessionStarted, now);
      await _putSet(_kRemindSession, <String>{});
      return <String>{};
    }
    return _getSet(_kRemindSession);
  }

  Future<void> addSessionRemindLater(String id) async {
    final p = await _prefs;
    final set = (p.getStringList(_kRemindSession) ?? const <String>[]).toSet();
    set.add(id);
    await _putSet(_kRemindSession, set);
    if (!p.containsKey(_kSessionStarted)) {
      await p.setInt(_kSessionStarted, DateTime.now().millisecondsSinceEpoch);
    }
  }
}
