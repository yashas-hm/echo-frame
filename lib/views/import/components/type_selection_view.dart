part of '../import_screen.dart';

class TypeSelectionView extends StatelessWidget {
  const TypeSelectionView({super.key, required this.onSelectType});

  final ValueChanged<ImportType> onSelectType;

  static const Map<ImportType, (IconData, String, String)> importText = {
    ImportType.mediaOrganizer: (
      Icons.photo_library_outlined,
      'Media Organizer',
      'Sort a folder of unsorted photos into your library by date.',
    ),
    ImportType.googleTakeoutOrganizer: (
      Icons.cloud_download_outlined,
      'Google Takeout',
      'Import a Google Photos export and match photos into your library.',
    ),
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: Sizes.viewBoxWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Import Photos',
                  style: Styles.title(
                    color: colors.textPrimary,
                  ),
                ),
                const SpacerExtraSmall(),
                Text(
                  'Choose how you want to import your photos.',
                  style: Styles.subtitle(
                    color: colors.textSecondary,
                  ),
                ),
                const SpacerLarge(),
                Row(
                  spacing: Sizes.spacingRegular,
                  children: ImportType.values.map((type) {
                    final importData = importText[type]!;
                    return Expanded(
                      child: Material(
                        color: colors.surfacePrimary,
                        borderRadius: BorderRadius.circular(
                          Sizes.inputBorderRadius,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => onSelectType(type),
                          hoverColor: colors.primaryColor.hover,
                          mouseCursor: SystemMouseCursors.click,
                          child: Padding(
                            padding: const EdgeInsets.all(Sizes.spacingLarge),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  importData.$1,
                                  size: Sizes.iconSizeHuge,
                                  color: colors.primaryColor,
                                ),
                                const SpacerMedium(),
                                Text(
                                  importData.$2,
                                  style: Styles.subtitle(
                                    color: colors.textPrimary,
                                  ),
                                ),
                                const SpacerExtraSmall(),
                                Text(
                                  importData.$3,
                                  style: Styles.small(
                                    color: colors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        const EFBackButton(),
      ],
    );
  }
}
