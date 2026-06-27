part of 'views.dart';

class ErrorList extends StatefulWidget {
  const ErrorList({super.key, required this.errors});

  final List<DiscoveryError> errors;

  @override
  State<ErrorList> createState() => ErrorListState();
}

class ErrorListState extends State<ErrorList> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final total = widget.errors.length;
    final colors = context.colors;

    return Container(
      padding: EdgeInsets.all(Sizes.cardPadding),
      decoration: BoxDecoration(
        color: colors.errorSurface,
        borderRadius: BorderRadius.circular(Sizes.inputBorderRadius),
        border: Border.all(
          color: colors.errorPrimary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: Sizes.iconSizeSmall,
                    color: colors.errorPrimary,
                  ),
                  const SpacerRegular(),
                  Expanded(
                    child: Text(
                      '$total ${'file'.plural(total)} skipped during scan',
                      style: _expanded
                          ? Styles.smallRegular(color: colors.errorPrimary)
                          : Styles.smallRegularBold(color: colors.errorPrimary),
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    size: Sizes.iconSizeExtraSmall,
                    color: colors.errorPrimary,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            const SpacerSmall(),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 160),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: total,
                itemBuilder: (_, i) {
                  final err = widget.errors[i];
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: Sizes.spacingExtraSmall),
                    child: Row(
                      spacing: Sizes.spacingRegular,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SelectableText(
                            err.filename,
                            style: Styles.small(
                              color: colors.textPrimary,
                            ),
                          ),
                        ),
                        Text(
                          err.reason,
                          style: Styles.small(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
