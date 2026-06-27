part of 'views.dart';

class DiscoveringView extends StatefulWidget {
  const DiscoveringView(this.state, {super.key});

  final ImportState state;

  @override
  State<DiscoveringView> createState() => _DiscoveringViewState();
}

class _DiscoveringViewState extends State<DiscoveringView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtr;
  late final Animation<Offset> _offsetAnim;

  @override
  void initState() {
    super.initState();
    _animCtr = AnimationController(
      vsync: this,
      duration: Durations.extralong1,
    )..repeat(reverse: true);

    _offsetAnim = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(10, -10),
    ).animate(_animCtr);
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

    final dir = state.scanningDir;

    return Center(
      child: SizedBox(
        width: Sizes.viewBoxWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _animCtr,
              builder: (_, child) => Transform.translate(
                offset: _offsetAnim.value,
                child: child,
              ),
              child: Icon(
                Icons.search_rounded,
                size: Sizes.iconSizeHuge,
                color: colors.primaryColor,
              ),
            ),
            const SpacerMedium(),
            Text(
              'Finding media',
              style: Styles.subtitle(color: colors.textPrimary),
            ),
            const SpacerSmall(),
            const LinearProgressIndicator(),
            const SpacerSmall(),
            if (state.filesFound > 0)
              Text(
                '${state.filesFound} ${'file'.plural(state.filesFound)} found',
                style: Styles.smallRegular(color: colors.textSecondary),
              ),
            if (dir != null) ...[
              const SpacerExtraSmall(),
              Text(
                dir,
                style: Styles.small(color: colors.textSecondary),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
