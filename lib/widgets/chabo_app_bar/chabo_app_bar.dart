import 'package:chabo_app/bloc/status/status_bloc.dart';
import 'package:chabo_app/const.dart';
import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/widgets/progress_indicator/custom_progress_bar_indicator.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'small_status_widget.dart';

class ChaboAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final bool displayStatus;

  ChaboAppBar({super.key, this.actions, this.displayStatus = true})
    : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  ChaboAppBarState createState() => ChaboAppBarState();
}

class ChaboAppBarState extends State<ChaboAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 70,
      actions: widget.actions,
      actionsPadding: EdgeInsets.only(right: 30),
      leading: (ModalRoute.of(context)?.canPop ?? false)
          ? IconButton(
              icon: const Icon(Icons.arrow_circle_left_outlined),
              onPressed: () => Navigator.of(context).pop(),
            )
          : Padding(
              padding: EdgeInsets.only(left: 16.0, right: 0),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
                child: Image.asset(Const.appLogoPath),
              ),
            ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Const.appName,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          widget.displayStatus
              ? Padding(
                  padding: const EdgeInsets.only(
                    right: CustomProperties.padding,
                  ),
                  child: SmallStatusWidget(),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
