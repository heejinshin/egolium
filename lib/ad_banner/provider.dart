import 'package:sticky_notes/ad_helper.dart';

import 'data/note_manager.dart';

AdHelper _adHelper = new AdHelper();

NoteManager _noteManager = new NoteManager();

AdHelper adHelper() {
  return _adHelper;
}

NoteManager noteManager() {
  return _noteManager;
}