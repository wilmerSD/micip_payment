import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// class CustomTabSwitch extends StatefulWidget {
//   final List<String> tabs;
//   final Function(int selectedIndex) onChanged;
//   final int initialIndex;

//   const CustomTabSwitch({
//     super.key,
//     required this.tabs,
//     required this.onChanged,
//     this.initialIndex = 0,
//   });

//   @override
//   State<CustomTabSwitch> createState() => _CustomTabSwitchState();
// }

// class _CustomTabSwitchState extends State<CustomTabSwitch> {
//   late int selectedIndex;

//   @override
//   void initState() {
//     super.initState();
//     selectedIndex = widget.initialIndex;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(widget.tabs.length, (index) {
//         final isSelected = selectedIndex == index;
//         return Expanded(
//           child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedIndex = index;
//                 });
//                 widget.onChanged(index);
//               },
//               child: AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 250),
//                 transitionBuilder: (child, animation) => ScaleTransition(
//                   scale: animation,
//                   child: child,
//                 ),
//                 child: Container(
//                   // width: 150.0,
//                   key: ValueKey(isSelected), // Important for switch
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 12, horizontal: 28),
//                   decoration: BoxDecoration(
//                     color: isSelected ? AppColors.granateConst: Colors.white,
//                     borderRadius: BorderRadius.circular(14),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 4,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       widget.tabs[index],
//                       style: TextStyle(
//                         color: isSelected ? Colors.white : Colors.black87,
//                         fontWeight: FontWeight.bold,
//                       ), 
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
class CustomTabSwitch extends StatelessWidget {
  final List<String> tabs;
  final Function(int selectedIndex) onChanged;
  final int selectedIndex;

  const CustomTabSwitch({
    super.key,
    required this.tabs,
    required this.onChanged,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(tabs.length, (index) {
        final isSelected = selectedIndex == index;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: Container(
                  key: ValueKey(isSelected),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 28,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.granateConst
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color:
                            isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

