import 'package:echo_frame/components/buttons/buttons.dart' show EFIconButton;
import 'package:echo_frame/constants/constants.dart'
    show Styles, Sizes, SpacerSmall;
import 'package:echo_frame/models/media/media.dart' show MediaItem;
import 'package:echo_frame/theme/theme.dart' show KnownColors, AppThemeColors;
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:echo_frame/views/gallery/components/actions_tray.dart'
    show galleryActionsProvider;
import 'package:echo_frame/views/gallery/components/gallery_info_panel.dart'
    show tagsProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagRow extends ConsumerStatefulWidget {
  const TagRow({super.key, required this.item});

  final MediaItem item;

  @override
  ConsumerState<TagRow> createState() => _TagRowState();
}

class _TagRowState extends ConsumerState<TagRow> {
  final TextEditingController _controller = TextEditingController();
  bool _editTags = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final allTagsAsync = ref.watch(tagsProvider);
    final actions = ref.read(galleryActionsProvider);
    final currentIds = widget.item.tags.map((t) => t.id).toSet();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: Sizes.spacingExtraSmall,
          children: [
            Text(
              'Tags',
              style: Styles.regularBold(color: colors.textPrimary),
            ),
            const Spacer(),
            EFIconButton(
              icon: _editTags
                  ? Icons.clear_rounded
                  : widget.item.tags.isEmpty
                      ? Icons.add_rounded
                      : Icons.edit_outlined,
              iconSize: Sizes.iconSizeExtraSmall,
              iconPadding: EdgeInsets.all(Sizes.iconSizeExtraSmall),
              onPressed: () {
                _controller.clear();
                setState(() => _editTags = !_editTags);
              },
            ),
          ],
        ),
        if (widget.item.tags.isNotEmpty)
          Wrap(
            spacing: Sizes.spacingExtraSmall,
            runSpacing: Sizes.spacingExtraSmall,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: widget.item.tags
                .map(
                  (tag) => Container(
                    decoration: BoxDecoration(
                      color: colors.background,
                      borderRadius: BorderRadius.circular(Sizes.maxFinite),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.spacingSmallRegular,
                      vertical: Sizes.spacingExtraSmall,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: Sizes.spacingExtraSmall,
                      children: [
                        Text(
                          tag.value,
                          style: Styles.micro(color: colors.textPrimary),
                        ),
                        if (_editTags)
                          Material(
                            color: KnownColors.transparent,
                            shape: CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () => actions.removeTag(widget.item, tag),
                              mouseCursor: SystemMouseCursors.click,
                              child: Icon(
                                Icons.close_rounded,
                                size: Sizes.iconSizeExtraSmall,
                                color: colors.textSecondary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        if (_editTags) ...[
          const SpacerSmall(),
          SizedBox(
            height: Sizes.inputHeight,
            child: TextField(
              autofocus: true,
              controller: _controller,
              style: Styles.small(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Search/Create tag',
                hintStyle: Styles.small(color: colors.textSecondary),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Sizes.spacingSmallRegular,
                  vertical: Sizes.spacingSmall,
                ),
                filled: true,
                fillColor: colors.frostColor,
                border: Styles.noBorder,
                enabledBorder: Styles.noBorder,
                focusedBorder: Styles.noBorder,
              ),
            ),
          ),
          const SpacerSmall(),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (_, value, __) {
              final query = value.text.toLowerCase().trim();
              return ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 240),
                child: allTagsAsync.when(
                  data: (allTags) {
                    final available = allTags
                        .where((t) =>
                            !currentIds.contains(t.id) &&
                            (query.isEmpty ||
                                t.value.toLowerCase().contains(query)))
                        .toList();
                    final hasExact =
                        allTags.any((t) => t.value.toLowerCase() == query);

                    if (available.isEmpty && (query.isEmpty || hasExact)) {
                      return const SizedBox.shrink();
                    }

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: Sizes.spacingExtraSmall,
                        children: [
                          if (query.isNotEmpty && !hasExact)
                            _tagSelector(
                              label: 'Create "${_controller.text.trim()}"',
                              icon: Icons.add_rounded,
                              colors: colors,
                              onTap: () async {
                                await actions.createAndAddTag(
                                  widget.item,
                                  _controller.text.trim(),
                                );
                                _controller.clear();
                              },
                            ),
                          ...available.map(
                            (tag) => _tagSelector(
                              label: tag.value,
                              icon: Icons.label_outline_rounded,
                              colors: colors,
                              onTap: () async {
                                await actions.addTag(widget.item, tag);
                                _controller.clear();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loading: () => CircularProgressIndicator(),
                  error: (_, __) => Text(
                    'Failed to load tags',
                    style: Styles.small(color: colors.textSecondary),
                  ),
                ),
              );
            },
          ),
        ]
      ],
    );
  }

  Widget _tagSelector({
    required String label,
    required IconData icon,
    required AppThemeColors colors,
    required VoidCallback onTap,
  }) =>
      Material(
        color: KnownColors.transparent,
        borderRadius: BorderRadius.circular(Sizes.spacingExtraSmall),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          mouseCursor: SystemMouseCursors.click,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Sizes.spacingExtraExtraSmall,
              horizontal: Sizes.spacingExtraSmall,
            ),
            child: Row(
              spacing: Sizes.spacingExtraExtraSmall,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: colors.textPrimary,
                  size: Sizes.iconSizeExtraSmall,
                ),
                Expanded(
                  child: Text(
                    label,
                    style: Styles.small(
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
