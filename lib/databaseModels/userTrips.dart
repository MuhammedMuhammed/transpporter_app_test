
class usertrips{

  final int id;
  final int tripId;
  final int userId;
  final int passengerNum;
  final double amount;
  final bool isfinished;
  final bool hasDiscount;
  final bool isPaid;
  usertrips(
    {
      this.id,
      this.tripId,
      this.userId,
      this.passengerNum = 1,
      this.amount,
      this.isfinished = false,
      this.hasDiscount = false,
      this.isPaid = false
    }
  ){
    
    
  }



}