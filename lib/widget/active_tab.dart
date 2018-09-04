import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cinematic_flutter/model/app_tab.dart';
import 'package:cinematic_flutter/model/app_state.dart';

class ActiveTab extends StatelessWidget {
  final ViewModelBuilder<AppTab> builder;

  ActiveTab({@required this.builder});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, AppTab>(
        distinct: true,
        converter: (store) => store.state.activeTab,
        builder: builder,
      );
}
