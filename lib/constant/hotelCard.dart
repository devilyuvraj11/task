import 'package:flutter/material.dart';
import 'package:task/constant/colors.dart';
import 'package:task/constant/responsive.dart';

class HotelCard extends StatelessWidget {
  final Map<String, dynamic> hotel;
  final VoidCallback onFavorite;

  const HotelCard({
    super.key,
    required this.hotel,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = Responsive.horizontalPadding(context);

    final cardWidth = screenWidth - (horizontalPadding * 2);

    final imageWidth = Responsive.clamp(
      context,
      cardWidth * 0.32,
      min: 96,
      max: 116,
    );

    final cardHeight = Responsive.clamp(
      context,
      137,
      min: 125,
      max: 145,
    );

    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(Responsive.clamp(context, 15, min: 12, max: 16,),),
      decoration: BoxDecoration(color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          Responsive.cardRadius(context),
        ),

        border: Border.all(
          color: AppColors.border,
        ),

        boxShadow: const [
          BoxShadow(
            color: Color(0x0F1B2A2A),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: imageWidth,
            height: cardHeight,
            child: _hotelImage(
              context,
              imageWidth,
              cardHeight,
            ),
          ),

          SizedBox(
            width: Responsive.clamp(
              context,
              15,
              min: 10,
              max: 16,
            ),
          ),

          // =====================================================
          // HOTEL INFORMATION
          // =====================================================

          Expanded(
            child: SizedBox(
              height: cardHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // -------------------------------
                  // NAME + FAVORITE
                  // -------------------------------

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          hotel['name'] as String,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Responsive.clamp(context, 18, min: 15, max: 18,),
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),

                      const SizedBox(width: 5),

                      InkWell(
                        onTap: onFavorite,
                        borderRadius: BorderRadius.circular(30,),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(
                            hotel['favorite'] == true ? Icons.favorite : Icons.favorite_border,
                            color: hotel['favorite'] == true ? Colors.black : AppColors.grey,
                            size: Responsive.clamp(context, 25, min: 22, max: 26,),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: Responsive.clamp(context, 12, min: 8, max: 14,),
                  ),

                  // -------------------------------
                  // LOCATION + RATING
                  // -------------------------------

                  Wrap(
                    spacing: 4,
                    runSpacing: 3,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: AppColors.accent,
                      ),

                      Text(
                        hotel['location'] as String,
                        style: TextStyle(
                          fontSize: Responsive.clamp(context, 14, min: 12, max: 14,),
                          color: AppColors.locationText,
                        ),
                      ),
                      const Text('•', style: TextStyle(color: AppColors.grey,),),

                      const Icon(Icons.star, size: 15, color: AppColors.accent,),
                      Text('${hotel['rating']} (${hotel['reviews']})',
                        style: TextStyle(fontSize: Responsive.clamp(context, 14, min: 12, max: 14,), color: AppColors.locationText,),
                      ),
                    ],
                  ),

                  const Spacer(),

                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('₹${hotel['price']}',
                          style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary,),
                        ),

                        const SizedBox(width: 4),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 3,),
                          child: Text('/night', style: TextStyle(fontSize: 13, color: AppColors.grey,),),
                        ),
                      ],
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


  Widget _hotelImage(BuildContext context, double width, double height,) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            hotel['color1'] as Color,
            hotel['color2'] as Color,
          ],
        ),
        borderRadius: BorderRadius.circular(Responsive.clamp(context, 20, min: 16, max: 20,),
        ),
      ),

      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.apartment_outlined,
              size: Responsive.clamp(context, 38, min: 32, max: 40,),
              color: const Color(0xFF9CA69F,),
            ),
          ),

          Positioned(top: 10, left: 10,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.clamp(context, 11, min: 8, max: 12,),
                vertical: 7,
              ),

              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(100),
              ),

              child: Text('LIVE DEAL',
                style: TextStyle(
                  fontSize: Responsive.clamp(context, 10, min: 8, max: 10),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}