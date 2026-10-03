import 'package:flutter/material.dart';
import 'package:task/constant/colors.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController destinationController = TextEditingController();

  final FocusNode destinationFocusNode = FocusNode();

  @override
  void dispose() {
    destinationController.dispose();
    destinationFocusNode.dispose();
    super.dispose();
  }

  bool isBag = false;
  int selectedCategory = 0;
  String selectedDate = 'Oct 2 – Oct 3';
  String selectedGuests = '2 Guests';
  String selectedSort = 'Recommended';
  bool isSearching = false;
  Future<void> selectDate() async {
    final DateTimeRange? range = await showDateRangePicker(
      context: context,

      firstDate: DateTime.now(),

      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),

      currentDate: DateTime.now(),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              secondary: AppColors.accent,
            ),
          ), child: child!,
        );
      },
    );

    if (range != null) {
      setState(() {
        selectedDate = '${_formatDate(range.start)} – ${_formatDate(range.end)}';
      });
    }
  }
  void selectGuests() {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),

      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                'Select Guests',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(6,
                    (index) {
                final guests = index + 1;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.person_outline,
                      color: AppColors.primary,
                    ),
                    title: Text('$guests ${guests == 1 ? 'Guest' : 'Guests'}',),

                    trailing: selectedGuests == '$guests ${guests == 1 ? 'Guest' : 'Guests'}' ? const Icon(Icons.check,
                      color: AppColors.primary,
                    ) : null,

                    onTap: () {
                      setState(() {
                        selectedGuests = '$guests ${guests == 1 ? 'Guest' : 'Guests'}';
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void selectSort() {
    final options = [
      'Recommended',
      'Price: Low to High',
      'Price: High to Low',
      'Rating',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sort Hotels',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 15),
              ...options.map(
                    (option) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,

                    title: Text(option,
                      style: const TextStyle(fontSize: 15,
                        color: AppColors.primary,
                      ),
                    ),
                    trailing: selectedSort == option ? const Icon(
                      Icons.check,
                      color: AppColors.primary,
                    ) : null,

                    onTap: () {
                      setState(() {selectedSort = option;});
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
  Future<void> _searchStays() async {
    if (isSearching) return;

    setState(() {
      isSearching = true;
    });

    try {
      await Future.delayed(
        const Duration(seconds: 2),
      );
      if (!mounted) return;
      } finally {
      if (mounted) {
        setState(() {
          isSearching = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          // =====================================================
          // DESTINATION TEXT FIELD
          // =====================================================

          Container(
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.border,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 20),

                const Icon(
                  Icons.location_on_outlined,
                  size: 24,
                  color: AppColors.primary,
                ),

                const SizedBox(width: 12),

                // TextFormField
                Expanded(
                  child: TextFormField(
                    controller: destinationController,
                    focusNode: destinationFocusNode,
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: 'Where are you heading?',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.primary,),
                    onFieldSubmitted: (value) {
                      print('Destination: $value');
                    },
                  ),
                ),

                // =================================================
                // BAG / SEARCH BUTTON
                // =================================================

                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: (){
                    setState(() {
                      isBag = !isBag;
                    });
                  },
                  child: Container(
                    width: 46,
                    height: 46,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: isBag ? AppColors.primary: AppColors.border,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.shopping_bag_outlined, color: isBag ? Colors.white : Colors.black, size: 22,),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isBag ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 42,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: const Text('Bag — 2 saved stays • Last Minutes Deal',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.primary,),),
            ),
          ) : const SizedBox.shrink(),
        ),

           SizedBox(height: 20),


          Row(
            children: [
              categoryChip('All', 0),
              const SizedBox(width: 10),
              categoryChip('Hotel', 1),
              const SizedBox(width: 10),
              categoryChip('Resort', 2),
              const SizedBox(width: 10),
              categoryChip('Villa', 3),
            ],
          ),

          const SizedBox(height: 25),

          // =====================================================
          // FILTER CARDS
          // =====================================================

          Row(
            children: [
              Expanded(
                child: filterCard(
                  icon: Icons.calendar_today_outlined,
                  title: 'Dates',
                  value: selectedDate,
                  onTap: selectDate
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: filterCard(
                  icon: Icons.people_outline,
                  title: 'Guests',
                  value: selectedGuests,
                  onTap: selectGuests
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: filterCard(
                  icon: Icons.swap_vert,
                  title: 'Sort',
                  value: selectedSort,
                  onTap: selectSort
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: _searchStays,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 14,
                    offset: Offset(0, 7),
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  if (isSearching)
                    const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  else
                    const Icon(Icons.search, size: 25, color: Colors.white,),
                  const SizedBox(width: 10),

                  Text(isSearching ? 'Searching...' : 'Search Stays',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget categoryChip(String title, int index) {
    final bool selected = selectedCategory == index;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          setState(() {
            selectedCategory = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 46,
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: selected ? AppColors.primary : AppColors.border,),

            boxShadow: selected ? const [
              BoxShadow(
                color: Color(0x18000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ] : null,
          ),
          alignment: Alignment.center,
          child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: selected ? Colors.white : AppColors.primary,),
          ),
        ),
      ),
    );
  }
}


Widget filterCard({required IconData icon, required String title, required String value, required VoidCallback onTap,}) {
  return InkWell(
    borderRadius: BorderRadius.circular(18),
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 128,
      padding: const EdgeInsets.fromLTRB(16, 16, 10, 12,),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border,),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 21, color: AppColors.grey,),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grey,),),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(value, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primary,),),
              ),

              const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.accent,),
            ],
          ),
        ],
      ),
    ),
  );
}
String _formatDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return '${months[date.month - 1]} ${date.day}';
}