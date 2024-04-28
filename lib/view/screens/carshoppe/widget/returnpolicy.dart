import 'package:flutter/material.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';

class ReturnPolicy extends StatelessWidget {
  const ReturnPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Return Policy'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Center(child: Text('''
Pexa thrives on our policy that customer satisfaction is of paramount importance. While we ensure that our products maintain its premium standards, sometimes there are circumstances when you maybe dissatisfied with the purchase. There is no reason to fret, we have you covered with our customer friendly return policy.
Kindly keep the receipt or proof of purchase if you intend to return or exchange the purchased item. To be eligible for a return, your item must be unused and returned in the same condition that you had received it.  

Most new and unopened merchandise are accepted for returns unless it is mentioned in our Return Policy Exceptions. After verifying whether the packaging is intact in its original condition, the product may be exchanged with another product or coupon codes against the purchase value. 
Our Return Policy gives you 3-7 days to return or exchange an item bought online with a valid receipt. If the purchase has exceeded this time period, we cannot offer you a refund or exchange. ''')),
              Container(
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text('''
Return or Exchange gets void if
-Any item not in its original condition; is damaged or missing parts for reasons other than the producer’s default.
- the return period exceeds the stipulated time period.'''),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text('''
Refunds (if applicable)\n
Once your return is received and inspected, we will send you an email to notify you that we have received your returned item. We will also notify you of the approval or rejection of your refund.'''),
              ),
              const SizedBox(height: 20),
              const Text(
                  '''If you are approved, then your refund will be processed, and a credit will automatically be applied to your user account within 7 working days. Refunds will be issued to the original form of payment (credit card, Paytm etc) unless noted specifically in our Return Policy. Returns made with a gift card or coupon with be refunded as store credit. 
Late or missing refunds (if applicable)
If you haven’t received a refund yet, first check profile details again. Refunds may take up to 2-3 business days. Incase of further delay please, contact our support team. It may take some time before your refund is officially posted.
'''),
              Container(
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text('''
Return shipping costs
Please note that the customer would be liable for all return shipping costs unless it is an error on part the store. We strongly advise you to mail your return using a trackable method.''')),
            ],
          ),
        ),
      ),
    );
  }
}
