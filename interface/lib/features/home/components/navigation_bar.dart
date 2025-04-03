import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NavigationBarWidget extends ConsumerStatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  ConsumerState<NavigationBarWidget> createState() => _BarWidgetState();
}

class _BarWidgetState extends ConsumerState<NavigationBarWidget> {
  bool visible = true;
  Uri? _selectedPath;
  late final RouterDelegate routerDelegate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSelectedPath();
      routerDelegate = GoRouter.of(context).routerDelegate;
      routerDelegate.addListener(_updateSelectedPath);
    });
  }

  @override
  void dispose() {
    routerDelegate.removeListener(_updateSelectedPath);
    super.dispose();
  }

  void _updateSelectedPath() {
    final routeInfo = GoRouter.of(context).routeInformationProvider.value;
    if (routeInfo.uri.pathSegments.isEmpty) {
      return;
    }
    setState(() {
      _selectedPath = routeInfo.uri;
    });
  }

  Widget barComponent() {
    var seg = _selectedPath?.pathSegments;

    bool? isHome;
    bool? isNetwork;
    bool? isJobs;
    bool? isCompanies;

    isHome = seg?[0] == 'home';
    isNetwork = seg?[0] == 'network';
    isJobs = seg?[0] == 'jobs';
    isCompanies = seg?[0] == 'companies';

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).custom.colorTheme.background,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).custom.colorTheme.foreground,
                width: 1,
              ),
            ),
          ),
          // height: 55,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavigatorIcon(
                  path: '/home',
                  iconAsset: 'assets/icons/home.svg',
                  selected: isHome,
                ),
                NavigatorIcon(
                  path: '/network',
                  iconAsset: 'assets/icons/network.svg',
                  selected: isNetwork,
                ),
                NavigatorIcon(
                  path: '/jobs',
                  iconAsset: 'assets/icons/job.svg',
                  selected: isJobs,
                ),
                NavigatorIcon(
                  path: '/companies',
                  iconAsset: 'assets/icons/company.svg',
                  selected: isCompanies,
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).custom.colorTheme.background,
          ),
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return barComponent();
  }
}

class NavigatorIcon extends StatelessWidget {
  final String iconAsset;
  final String path;
  final bool selected;
  final String? label;

  const NavigatorIcon({
    super.key,
    required this.iconAsset,
    required this.path,
    required this.selected,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        selected
            ? Theme.of(context).custom.colorTheme.dirtywhite
            : Theme.of(
              context,
            ).custom.colorTheme.dirtywhite.withValues(alpha: 0.3);

    return OutlinedButton(
      onPressed: () {
        HapticFeedback.mediumImpact();
        GoRouter.of(context).push(path);
      },
      style: OutlinedButton.styleFrom(
        minimumSize: Size.zero,
        foregroundColor: Theme.of(context).custom.colorTheme.foreground,
        padding: const EdgeInsets.all(16),
        side: const BorderSide(color: Colors.transparent, width: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      child: SizedBox(
        child: Column(
          children: [
            SvgPicture.asset(
              iconAsset,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              height: 25,
            ),
            if (label != null)
              DefaultTextStyle(
                style: Theme.of(context).custom.textTheme.subtitle2.copyWith(
                  fontSize: 9,
                  color: color,
                ),
                child: Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).custom.textTheme.subtitle2.copyWith(
                    fontSize: 9,
                    color: color,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
