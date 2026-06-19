part of '../import_screen.dart';

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
    final dir = widget.state.scanningDir;
    final label = dir ?? widget.state.destRoot ?? '';
    final colors = context.colors;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          RichText(
            text: TextSpan(
              text: 'Scanning ',
              style: Styles.subtitle(color: colors.textPrimary),
              children: [
                TextSpan(
                  text: label,
                  style: Styles.subTitleBold(color: colors.textPrimary),
                ),
              ],
            ),
          ),
          const SpacerSmall(),
          if (widget.state.filesFound > 0)
            Text(
              '${widget.state.filesFound} ${'file'.plural(widget.state.filesFound)} found',
              style: Styles.smallRegular(color: colors.textSecondary),
            ),
        ],
      ),
    );
  }
}
