///
/// [Author] Alex (https://github.com/AlexV525)
/// [Date] 2020-01-13 16:52
///

part of 'providers.dart';

class SettingsProvider extends ChangeNotifier with DiagnosticableTreeMixin{
  SettingsProvider() {
    // init();
  }

  // Fow start index.
  int _homeSplashIndex = 0;

  int get homeSplashIndex => _homeSplashIndex;

  set homeSplashIndex(int value) {
    _homeSplashIndex = value;
    notifyListeners();
  }

  List<Map<dynamic, dynamic>> _announcements = <Map<dynamic, dynamic>>[];

  List<Map<dynamic, dynamic>> get announcements => _announcements;

  set announcements(List<Map<dynamic, dynamic>> value) {
    _announcements = List<Map<dynamic, dynamic>>.from(value);
    notifyListeners();
  }

  bool _announcementsEnabled = false;

  bool get announcementsEnabled => _announcementsEnabled;

  set announcementsEnabled(bool value) {
    _announcementsEnabled = value;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('announcementsEnabled', announcementsEnabled.toString()));
  }

  // bool _announcementsUserEnabled = false;
  //
  // bool get announcementsUserEnabled => _announcementsUserEnabled;
  //
  // set announcementsUserEnabled(bool value) {
  //   _announcementsUserEnabled = value;
  //   notifyListeners();
  // }
  //
  // bool _newAppCenterIcon = false;
  //
  // bool get newAppCenterIcon => _newAppCenterIcon;
  //
  // set newAppCenterIcon(bool value) {
  //   _newAppCenterIcon = value;
  //   notifyListeners();
  // }
  //
  // bool _hideShieldPost = true;
  //
  // bool get hideShieldPost => _hideShieldPost;
  //
  // set hideShieldPost(bool value) {
  //   _hideShieldPost = value;
  //   notifyListeners();
  // }
  //
  bool _launchFromSystemBrowser = false;

  bool get launchFromSystemBrowser => _launchFromSystemBrowser;

  set launchFromSystemBrowser(bool value) {
    assert(value != null);
    if (_launchFromSystemBrowser == value) {
      return;
    }
    _launchFromSystemBrowser = value;
    notifyListeners();
  }
  //
  // List<double> fontScaleRange = DeviceUtils.deviceModel.contains('iPad')
  //     ? <double>[0.3, 0.7]
  //     : <double>[0.8, 1.2];
  // double _fontScale = DeviceUtils.deviceModel.contains('iPad') ? 0.5 : 1.0;
  //
  // double get fontScale => _fontScale;
  //
  // set fontScale(double value) {
  //   _fontScale = value;
  //   notifyListeners();
  // }
  //
  // void init() {
  //   getAnnouncement();
  //   _fontScale = HiveFieldUtils.getFontScale() ?? _fontScale;
  //   _homeSplashIndex = HiveFieldUtils.getHomeSplashIndex() ?? _homeSplashIndex;
  //   _newAppCenterIcon =
  //       HiveFieldUtils.getEnabledNewAppsIcon() ?? _newAppCenterIcon;
  //   _hideShieldPost =
  //       HiveFieldUtils.getEnabledHideShieldPost() ?? _hideShieldPost;
  //   _launchFromSystemBrowser =
  //       HiveFieldUtils.getLaunchFromSystemBrowser() ?? _launchFromSystemBrowser;
  // }
  //
  // void reset() {
  //   _fontScale = DeviceUtils.deviceModel.contains('iPad') ? 0.5 : 1.0;
  //   _homeSplashIndex = 0;
  //   _newAppCenterIcon = false;
  //   _hideShieldPost = true;
  //   _launchFromSystemBrowser = false;
  //   _announcementsUserEnabled = _announcementsEnabled;
  //   notifyListeners();
  // }
  //
  // Future<void> getAnnouncement() async {
  //   try {
  //     final Response<Map<String, dynamic>> res = await NetUtils.get(
  //       API.announcement,
  //     );
  //     final Map<String, dynamic>? data = res.data;
  //     _announcements = (data?['announcements'] as List<dynamic>)
  //         .cast<Map<dynamic, dynamic>>();
  //     _announcementsEnabled = data?['enabled'] as bool;
  //     _announcementsUserEnabled = _announcementsEnabled;
  //     notifyListeners();
  //   } catch (e) {
  //     LogUtils.e('Get announcement error: $e');
  //     Future<void>.delayed(30.seconds, getAnnouncement);
  //   }
  // }

  /// Get cloud settings from xAuth server.
  /// ??????????????????????????????
//  Future<void> getCloudSettings() async {
//    try {
//      final Map<String, dynamic> res =
//          (await NetUtils.get<Map<String, dynamic>>(
//        API.cloudSettings,
//        cookies: <Cookie>[Cookie('sid', currentUser.sid)],
//      ))
//              .data;
//      if (res['code'] == '700' && res['data'] == null) {
//        uploadCloudSettings();
//      } else if (res['code'] == '000') {
//        handleSettingsSyncing(CloudSettingsModel.fromJson(res['data']));
//      } else {
//        LogUtils.e('Failed in getting cloud settings: ${res['message']}');
//      }
//    } catch (e) {
//      LogUtils.e('Failed in getting cloud settings: $e');
//    }
//  }
//
//  /// Upload cloud settings to xAuth server.
//  /// ???????????????
//  void uploadCloudSettings({bool fromUserAction = false}) {
//    NetUtils.postWithCookieSet<Map<String, dynamic>>(
//      API.cloudSettings,
//      data: currentCloudSettingsModel.toJson(),
//      cookies: <Cookie>[Cookie('sid', currentUser.sid)],
//    ).then((Response<dynamic> response) {
//      final Map<String, dynamic> data = response.data;
//      if (data['code'] == "000" && fromUserAction) {
//        showToast('??????????????????');
//      }
//    });
//  }
//
//  /// Compare settings difference to determine upload or download.
//  /// ?????????????????????????????????????????????
//  void handleSettingsSyncing(CloudSettingsModel model) {
//    final CloudSettingsModel currentModel = currentCloudSettingsModel;
//    if (currentModel != model) {
//      ConfirmationDialog.show(
//        navigatorState.overlay.context,
//        title: '???????????????',
//        child: Material(
//          type: MaterialType.transparency,
//          child: Padding(
//            padding: EdgeInsets.symmetric(vertical: 20.h),
//            child: Column(
//              mainAxisSize: MainAxisSize.min,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Text('????????????????????????????????????????????????????????????????????????????????????'),
//                VGap(10.h),
//                Row(
//                  children: <Widget>[
//                    syncSettingWidget(currentModel),
//                    syncSettingWidget(model, isFromCloud: true),
//                  ],
//                ),
//              ],
//            ),
//          ),
//        ),
//      );
//    }
//  }

  /// Sealed sync setting widget.
  /// ???????????????????????????
//  Widget syncSettingWidget(
//    CloudSettingsModel model, {
//    bool isFromCloud = false,
//  }) {
//    return Expanded(
//      child: InkWell(
//        splashFactory: InkSplash.splashFactory,
//        splashColor: currentTheme.canvasColor,
//        borderRadius: BorderRadius.circular(20.w),
//        onTap: () {
//          navigatorState.pop();
//          if (isFromCloud) {
//            overwriteSettings(model);
//          } else {
//            uploadCloudSettings(fromUserAction: true);
//          }
//        },
//        child: Padding(
//          padding: EdgeInsets.symmetric(vertical: 8.w),
//          child: Column(
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              Icon(
//                isFromCloud ? Icons.cloud_download : Icons.phonelink_setup,
//                size: 72.w,
//              ),
//              Container(
//                margin: EdgeInsets.symmetric(vertical: 6.h),
//                child: Text(
//                  isFromCloud ? '??????' : '??????',
//                  style: currentTheme.textTheme.bodyText2.copyWith(
//                    fontSize: 18.sp,
//                  ),
//                ),
//              ),
//              Text(
//                DateFormat('MM-dd HH:mm').format(model.lastModified),
//                style: currentTheme.textTheme.caption.copyWith(
//                  fontSize: 14.sp,
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }

  /// Overwrite settings from cloud settings model.
  /// ????????????????????????????????????
//  Future<void> overwriteSettings(CloudSettingsModel model) async {
//    _fontScale = model.fontScale;
//    _hideShieldPost = model.hideShieldPost;
//    _homeSplashIndex = model.homeSplashIndex;
//    _launchFromSystemBrowser = model.launchFromSystemBrowser;
//    _newAppCenterIcon = model.newAppCenterIcon;
//    await navigatorState.overlay.context
//        .read<ThemesProvider>()
//        .syncFromCloudSettings(model);
//    await HiveFieldUtils.setFontScale(_fontScale);
//    await HiveFieldUtils.setEnabledHideShieldPost(_hideShieldPost);
//    await HiveFieldUtils.setHomeSplashIndex(_homeSplashIndex);
//    await HiveFieldUtils.setLaunchFromSystemBrowser(_launchFromSystemBrowser);
//    await HiveFieldUtils.setEnabledNewAppsIcon(_newAppCenterIcon);
//    notifyListeners();
//    showToast('??????????????????');
//  }
//
//  CloudSettingsModel get currentCloudSettingsModel =>
//      CloudSettingsModel.fromProvider(
//        this,
//        navigatorState.overlay.context.read<ThemesProvider>(),
//      );
}
