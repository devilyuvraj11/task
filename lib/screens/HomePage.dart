import 'package:flutter/material.dart';
import 'package:task/constant/colors.dart';
import 'package:task/constant/hotelListing.dart';
import 'package:task/constant/searchtextfield.dart';

class Homepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: const [
              SearchTextField(),
              Divider(color: AppColors.accent, thickness: 0.3,),
              HotelListing(),
            ],
          ),
        ),
      ),
    );
  }
}