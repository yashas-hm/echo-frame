part of '../import_screen.dart';

class IdleView extends ConsumerWidget {
  const IdleView(
    this.state,
    this.type, {
    super.key,
    required this.onBackPressed,
  });

  final ImportState state;
  final ImportType type;
  final VoidCallback onBackPressed;

  Future<void> _pickSource(WidgetRef ref) async {
    final path = await FilePicker.getDirectoryPath(
      dialogTitle: 'Choose folder with unsorted photos',
    );
    if (path != null) {
      ref.read(importProvider(type).notifier).setSourceDir(path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final destRoot = state.destRoot;
    final color = context.colors;
    final sourceDir = state.sourceDir;
    final importText = TypeSelectionView.importText;
    final canDiscover =
        sourceDir != null && destRoot != null && sourceDir != destRoot;

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
                  importText[type]!.$2,
                  style: Styles.title(color: color.textPrimary),
                ),
                const SpacerExtraSmall(),
                Text(
                  importText[type]!.$3,
                  style: Styles.subtitle(color: color.textSecondary),
                ),
                const SpacerLarge(),
                Text(
                  'Source folder',
                  style: Styles.small(color: color.textSecondary),
                ),
                const SpacerSmall(),
                _pathPicker(
                  ref,
                  context.colors,
                  path: sourceDir,
                  placeholder: 'No folder selected',
                ),
                const SpacerMedium(),
                Text(
                  'Destination (library root)',
                  style: Styles.small(color: color.textSecondary),
                ),
                const SpacerSmall(),
                _pathPicker(
                  ref,
                  context.colors,
                  path: destRoot,
                  readOnly: true,
                ),
                const SpacerExtraLarge(),
                Align(
                  alignment: Alignment.centerRight,
                  child: EFPrimaryButton(
                    disabled: !canDiscover,
                    onPressed: () => ref
                        .read(importProvider(type).notifier)
                        .discover(sourceDir!),
                    text: 'Scan',
                    icon: Icons.search_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
        EFIconButton.back(
          onPressed: onBackPressed,
        ),
      ],
    );
  }

  Widget _pathPicker(
    WidgetRef ref,
    AppThemeColors colors, {
    String? path,
    String? placeholder,
    bool readOnly = false,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(Sizes.inputBorderRadius),
      color: colors.surfacePrimary,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: readOnly ? null : () => _pickSource(ref),
        mouseCursor: readOnly ? null : SystemMouseCursors.click,
        child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.spacingRegular,
            vertical: Sizes.spacingSmallRegular,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.inputBorderRadius),
            border: Border.all(color: colors.borderPrimary),
          ),
          child: Row(
            children: [
              Icon(
                path == null ? Icons.folder_open_rounded : Icons.folder_rounded,
                size: Sizes.iconSizeSmall,
                color:
                    path != null ? colors.primaryColor : colors.textSecondary,
              ),
              const SpacerSmall(),
              Expanded(
                child: Text(
                  path ?? placeholder ?? '',
                  style: Styles.regular(
                    color: path != null
                        ? colors.textPrimary
                        : colors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!readOnly) ...[
                const SpacerSmall(),
                Text(
                  'Choose',
                  style: Styles.buttonBold(color: colors.textPrimary),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
