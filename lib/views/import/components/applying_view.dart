part of 'views.dart';

class ApplyingView extends StatefulWidget {
  const ApplyingView(this.state, {super.key});

  final ImportState state;

  @override
  State<ApplyingView> createState() => _ApplyingViewState();
}

class _ApplyingViewState extends State<ApplyingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtr;
  late final Animation<double> _slideAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtr = AnimationController(
      vsync: this,
      duration: Durations.extralong2,
    )..repeat();

    _slideAnim = Tween<double>(begin: 0, end: 50).animate(
      CurvedAnimation(parent: _animCtr, curve: Curves.easeIn),
    );
    _fadeAnim = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _animCtr, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final errorCount = widget.state.applyErrors.length;
    final processed = widget.state.applied + errorCount;
    final fraction =
        widget.state.total == 0 ? null : processed / widget.state.total;
    final colors = context.colors;

    return Center(
      child: SizedBox(
        width: Sizes.viewBoxWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sorting photos',
                  style: Styles.title(color: colors.textPrimary),
                ),
                AnimatedBuilder(
                  animation: _animCtr,
                  builder: (_, child) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: Offset(_slideAnim.value, 0),
                        child: Opacity(
                          opacity: _fadeAnim.value,
                          child: Icon(
                            Icons.insert_drive_file_outlined,
                            size: Sizes.iconSizeExtraSmall,
                            color: colors.secondaryColor,
                          ),
                        ),
                      ),
                      const SpacerMedium(),
                      Icon(
                        Icons.folder_rounded,
                        size: Sizes.iconSizeRegular,
                        color: colors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SpacerMedium(),
            LinearProgressIndicator(
              value: fraction,
              color: colors.secondaryColor,
            ),
            SpacerRegular(),
            Row(
              children: [
                Text('${widget.state.applied} of ${widget.state.total}'),
                if (errorCount > 0) ...[
                  const SpacerRegular(),
                  Text(
                    '($errorCount error)',
                    style: Styles.small(color: colors.errorPrimary),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
