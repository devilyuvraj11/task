import 'package:flutter/material.dart';
import 'package:task/constant/colors.dart';
import 'package:task/constant/hotelCard.dart';
import 'package:task/constant/responsive.dart';

class HotelListing extends StatefulWidget {
  const HotelListing({super.key});

  @override
  State<HotelListing> createState() => _HotelListingState();
}

class _HotelListingState extends State<HotelListing> {
  final List<Map<String, dynamic>> hotels = [
    {
      'id': 1,
      'name': 'Hotel Horizon',
      'location': 'Lonavala',
      'rating': 4.0,
      'reviews': 23,
      'price': 2680,
      'color1': const Color(0xFFE5DAC9),
      'color2': const Color(0xFFC7BAA7),
      'favorite': false,
    },
    {
      'id': 2,
      'name': 'Hotel O Metro View',
      'location': 'Lonavala',
      'rating': 4.0,
      'reviews': 23,
      'price': 2680,
      'color1': const Color(0xFFD8DECE),
      'color2': const Color(0xFFAAB8A1),
      'favorite': false,
    },
    {
      'id': 3,
      'name': 'Hotel O Peaceful',
      'location': 'Lonavala',
      'rating': 4.0,
      'reviews': 23,
      'price': 2680,
      'color1': const Color(0xFFD1DCE1),
      'color2': const Color(0xFFA6B5BD),
      'favorite': false,
    },
  ];

  String selectedFilter = 'All';

  List<Map<String, dynamic>> get filteredHotels {
    final result = List<Map<String, dynamic>>.from(hotels);

    if (selectedFilter == 'Price: Low to High') {
      result.sort(
            (a, b) => (a['price'] as int).compareTo(
          b['price'] as int,
        ),
      );
    }

    if (selectedFilter == 'Price: High to Low') {
      result.sort(
            (a, b) => (b['price'] as int).compareTo(
          a['price'] as int,
        ),
      );
    }

    if (selectedFilter == 'Highest Rated') {
      result.sort(
            (a, b) => (b['rating'] as double).compareTo(
          a['rating'] as double,
        ),
      );
    }

    if (selectedFilter == 'Favorites') {
      result.removeWhere(
            (hotel) => hotel['favorite'] != true,
      );
    }

    return result;
  }

  void toggleFavorite(int id) {
    setState(() {
      final hotel = hotels.firstWhere(
            (hotel) => hotel['id'] == id,
      );

      hotel['favorite'] = !(hotel['favorite'] as bool);
    });
  }

  void openFilters() {
    final options = [
      'All',
      'Favorites',
      'Price: Low to High',
      'Price: High to Low',
      'Highest Rated',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(
              Responsive.clamp(context, 24, min: 20, max: 28,),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Filter Hotels',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primary,),
                ),

                const SizedBox(height: 20),

                ...options.map((option) {
                    final isSelected = selectedFilter == option;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(option,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.primary,
                        ),
                      ),

                      trailing: isSelected ? const Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                      ) : null,

                      onTap: () {
                        setState(() {
                          selectedFilter = option;
                        });
                        Navigator.pop(sheetContext);
                      },
                    );
                  },
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleHotels = filteredHotels;
    final horizontalPadding = Responsive.horizontalPadding(context);
    return Container(
      width: double.infinity,
      color: AppColors.background,

      padding: EdgeInsets.fromLTRB(
        horizontalPadding, Responsive.clamp(context, 24, min: 18, max: 28,), horizontalPadding, 30,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // HEADER
          // =====================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  selectedFilter == 'Favorites' ? '${visibleHotels.length} Saved Hotels' : '20 hotel Available',
                  style: TextStyle(
                    fontSize: Responsive.clamp(context, 18, min: 16, max: 18,),
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),

              SizedBox(
                height: Responsive.clamp(context, 48, min: 44, max: 50,),
                child: OutlinedButton.icon(
                  onPressed: openFilters,
                  icon: const Icon(
                    Icons.tune,
                    color: AppColors.accent,
                    size: 18,
                  ),

                  label: const Text('Filters', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primary,),),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: AppColors.primary,
                    ),

                    backgroundColor: AppColors.surface,
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.clamp(context, 18, min: 14, max: 20,),
                    ),

                    shape: const StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: Responsive.clamp(context, 20, min: 16, max: 22,),
          ),

          // =====================================================
          // HOTEL LIST
          // =====================================================

          if (visibleHotels.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40,),
              child: Center(
                child: Text('No hotels found',
                  style: TextStyle(color: AppColors.grey, fontSize: 15,),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visibleHotels.length,
              separatorBuilder: (_, __) {
                return SizedBox(
                  height: Responsive.clamp(context, 16, min: 12, max: 18,),
                );
              },

              itemBuilder: (context, index) {
                final hotel = visibleHotels[index];
                return HotelCard(
                  hotel: hotel, onFavorite: () {toggleFavorite(hotel['id'] as int,);},
                );
              },
            ),
        ],
      ),
    );
  }
}