import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:dependencies/provider.dart';
import 'package:flutter/material.dart';

class MainTabNavBar extends StatelessWidget {
  const MainTabNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final routeStateProvider = context.read<MyRouteStateProvider>();
    final isInStockInventory = routeStateProvider.currentState is RouteLihatStockBarangState;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: _TabContainer(
            isLeft: true,
            text: "Inventory Stock",
            isActivated: isInStockInventory,
            onClick: (){
              if (!isInStockInventory){
                routeStateProvider.setRouteState(RouteLihatStockBarangState());
              }
            },
          ),
        ),
        Expanded(
          child: _TabContainer(
            isLeft: false,
            text: "Transaction",
            isActivated: !isInStockInventory,
            onClick: (){
              if (isInStockInventory){
                routeStateProvider.setRouteState(RouteLihatPengajuanState());
              }
            },
          ),
        ),
      ],
    );
  }
}

class _TabContainer extends StatelessWidget {
  final bool isLeft;
  final String text;
  final bool isActivated;
  final void Function() onClick;
  const _TabContainer({
    required this.isLeft,
    required this.text,
    required this.isActivated,
    required this.onClick,
  });

  static const _activatedColor = Color(0xFF2F00FF);
  static const _deactivatedColor = Color(0xFF000000);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.horizontal(
        left: isLeft ? const Radius.circular(12) : Radius.zero,
        right: !isLeft ? const Radius.circular(12) : Radius.zero
    );
    return InkWell(
      onTap: onClick,
      borderRadius: borderRadius,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            width: isActivated ? 1 : 0.2,
            color: isActivated ?  _activatedColor : _deactivatedColor,
          ),
          borderRadius: borderRadius,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isActivated ? _activatedColor : _deactivatedColor,
            fontWeight: isActivated ?
                FontWeight.normal :
                FontWeight.w200
          ),
        ),
      ),
    );
  }
}