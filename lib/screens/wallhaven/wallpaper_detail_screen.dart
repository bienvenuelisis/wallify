import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mobile/view_models/wallpaper_view_model.dart';
import 'package:mobile/views/base_view.dart';
import 'package:mobile/widgets/m_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor2/tinycolor2.dart';

import '../../models/wallhaven/wallpaper.dart';

class WallpaperDetailScreen extends StatefulWidget {
  const WallpaperDetailScreen({Key? key}) : super(key: key);

  @override
  State<WallpaperDetailScreen> createState() => _WallpaperDetailScreenState();
}

class _WallpaperDetailScreenState extends State<WallpaperDetailScreen>
    with DetailsMixin<WallPaper>, AutomaticKeepAliveClientMixin {
  // calculate drag ratio with notificationscrolllistener
  /*dragRatio = (notification.extent - notification.minExtent) /
  (notification.maxExtent - notification.minExtent);*/
  @override
  void initState() {
    // TODO fix scrollablecontroller bug

    scrollableController = DraggableScrollableController();
    dragRatio = 0.21;

    scrollableController.addListener(() {
      dragRatio = scrollableController.size / sheetMaxSize;
    });
    super.initState();
  }

  @override
  String get imgUrl =>
      Provider.of<WallpaperViewModel<WallPaper>>(context, listen: false)
          .selectedWallpaper
          .path!;

  @override
  String get photographer => "N/A";

  @override
  String get cacheKey =>
      Provider.of<WallpaperViewModel<WallPaper>>(context, listen: false)
          .selectedWallpaper
          .id
          .toString();

  @override
  String get imgSize =>
      "${(Provider.of<WallpaperViewModel<WallPaper>>(context).selectedWallpaper.fileSize! / 10000000).toStringAsFixed(2)}MB";

  @override
  bool get wantKeepAlive => true;

  @override
  List<Color> get colors => [
        ...List.from(Provider.of<WallpaperViewModel<WallPaper>>(context)
                .selectedWallpaper
                .colors!
                .toList())
            .map((e) => TinyColor.fromString(e).color)
            .toList()
      ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseView<WallpaperViewModel<WallPaper>>(
      key: UniqueKey(),
      vmBuilder: (context) =>
          Provider.of<WallpaperViewModel<WallPaper>>(context),
      builder: buildScreen,
    );
  }

  @override
  void applyWallPaper() {
    var viewModel =
        Provider.of<WallpaperViewModel<WallPaper>>(context, listen: false);

    viewModel.confirmAction(
      message:
          AppLocalizations.of(Get.context!)!.wallpaper_application_confirmation,
      action: () {
        viewModel.applyWallPaper(viewModel.selectedWallpaper.path!);
      },
      actionText: AppLocalizations.of(Get.context!)!.yes_apply,
    );
  }

  @override
  void download() {
    var viewModel =
        Provider.of<WallpaperViewModel<WallPaper>>(context, listen: false);

    viewModel.confirmAction(
      message:
          AppLocalizations.of(Get.context!)!.wallpaper_download_confirmation,
      action: () {
        viewModel.downloadWallPaper(viewModel.selectedWallpaper.path!);
      },
      actionText: AppLocalizations.of(Get.context!)!.yes_download,
    );
  }

  @override
  void save() {
    // TODO: implement save
    var viewModel =
        Provider.of<WallpaperViewModel<WallPaper>>(context, listen: false);

    bool isFavorite = viewModel.isWallPaperSaved(cacheKey);

    //check if user is on the favorite screen
    viewModel.confirmAction(
      message: isFavorite
          ? AppLocalizations.of(Get.context!)!.wallpaper_remove_confirmation
          : AppLocalizations.of(Get.context!)!.wallpaper_save_confirmation,
      action: () {
        viewModel.saveWallpaper(
            viewModel.selectedWallpaper, viewModel.selectedWallpaper.id!);
      },
      actionText: isFavorite
          ? AppLocalizations.of(Get.context!)!.remove
          : AppLocalizations.of(Get.context!)!.save,
    );
  }

  @override
  void share() {
    var viewModel =
        Provider.of<WallpaperViewModel<WallPaper>>(context, listen: false);

    viewModel.shareWallPaper(viewModel.selectedWallpaper.path!);

    /*viewModel.confirmAction(
      message:
      AppLocalizations.of(Get.context!)!.wallpaper_download_confirmation,
      action: () {
        viewModel.downloadWallPaper(viewModel.selectedWallpaper.path!);
      },
      actionText: AppLocalizations.of(Get.context!)!.yes_download,
    );*/
  }
}
