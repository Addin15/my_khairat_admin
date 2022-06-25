import 'package:flutter/cupertino.dart';
import 'package:my_khairat_admin/controllers/announcement_controller.dart';
import 'package:my_khairat_admin/models/announcement.dart';

class AnnouncementDAO extends ChangeNotifier {
  List<Announcement> _announcements = [];

  AnnouncementDAO(String mosqueID) {
    initData(mosqueID);
  }

  get announcements => _announcements;

  initData(String mosqueID) async {
    List<Announcement> data =
        await AnnouncementController.getAnnouncements(mosqueID);
    //TODO cache with Hive

    _announcements = data;
    notifyListeners();
  }

  addAnnouncement(String mosqueID, Announcement announcement) async {
    dynamic data =
        await AnnouncementController.addAnnouncement(mosqueID, announcement);

    if (data != null) {
      _announcements.add(data);

      notifyListeners();
    }
  }

  editAnnouncement(Announcement announcement) async {
    dynamic data = await AnnouncementController.editAnnouncement(announcement);

    if (data != null) {
      int index = _announcements.indexWhere((ann) => ann.id == announcement.id);
      _announcements[index] = announcement;

      notifyListeners();
    }
  }

  deleteAnnouncement(Announcement announcement) async {
    bool res = await AnnouncementController.deleteAnnouncement(announcement);

    if (res) {
      _announcements.remove(announcement);

      notifyListeners();
    }
  }

  // Caught exception purpose
  bool _disposed = false;

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
