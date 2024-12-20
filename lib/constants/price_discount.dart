class PriceDiscount {
  // function to calculate the % discount

  // returns int between 0 - 100, consider this int as percentage

  static int findPricePerPlate({required int guestCount}) {
    int maxPrice = 299;
    int minPrice = 189;
    int minGuest = 100;
    int maxGuest = 1500;
    if (guestCount < 100) {
      return maxPrice;
    }

    // double pricePerPlate = maxPrice - (maxPrice - minPrice)    *  (guestCount - minGuess);
    //                                   ________________________
    //                                   (maxGuests - minGuests)

    // using linear interpolation formula
    double pricePerPlate = maxPrice - ((maxPrice - minPrice) / (maxGuest - minGuest)) * (guestCount - minGuest);

    
    return pricePerPlate.toInt();
  }
}
