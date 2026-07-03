part of 'status_screen.dart';

class StatusImageWidget extends StatelessWidget {
  final StatusState statusState;

  const StatusImageWidget({super.key, required this.statusState});

  @override
  Widget build(BuildContext context) {
    final imageHeight = 450.0;
    return Column(
      children: [
        Card(
          color: Colors.transparent,
          elevation: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(CustomProperties.borderRadius),
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: imageHeight,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                    child: Image.asset(
                      context.watch<ThemeBloc>().state.imagePath,
                      key: ValueKey<String>(
                        context.watch<ThemeBloc>().state.imagePath,
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: imageHeight,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.5),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showAdaptiveDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: CustomProperties.blurSigmaX,
                            sigmaY: CustomProperties.blurSigmaY,
                          ),
                          child: CreditsDialog(
                            credits: context
                                .watch<ThemeBloc>()
                                .state
                                .imageCredits,
                            creditsLink: context
                                .watch<ThemeBloc>()
                                .state
                                .imageCreditsLink,
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    '© ${AppLocalizations.of(context)!.credits}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  right: 20,
                  child: Text(
                    statusState.mainMessageStatus,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
