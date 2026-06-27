part of 'views.dart';

class MetaReadView extends StatefulWidget {
  const MetaReadView(this.state, {super.key});

  final ImportState state;

  @override
  State<MetaReadView> createState() => _MetaReadViewState();
}

class _MetaReadViewState extends State<MetaReadView>
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

    _slideAnim = Tween<double>(begin: 0, end: -50).animate(
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
    final colors = context.colors;
    final state = widget.state;
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
                  'Reading metadata',
                  style: Styles.title(color: colors.textPrimary),
                ),
                AnimatedBuilder(
                  animation: _animCtr,
                  builder: (_, __) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: Offset(_slideAnim.value, 0),
                        child: Opacity(
                          opacity: _fadeAnim.value,
                          child: Icon(
                            Icons.sell_outlined,
                            size: Sizes.iconSizeExtraSmall,
                            color: colors.secondaryColor,
                          ),
                        ),
                      ),
                      const SpacerMedium(),
                      Icon(
                        Icons.article_outlined,
                        size: Sizes.iconSizeRegular,
                        color: colors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SpacerMedium(),
            LinearProgressIndicator(
              value: state.filesFound > 0
                  ? state.metaFilesRead / state.filesFound
                  : null,
            ),
            const SpacerRegular(),
            Text(
              '${state.metaFilesRead} / ${state.filesFound} ${'file'.plural(state.filesFound)}',
              style: Styles.regular(color: colors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}