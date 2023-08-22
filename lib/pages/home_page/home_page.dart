import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: controller.creditCardNumberController,
                decoration:
                    const InputDecoration(labelText: 'Credit Card Number'),
              ),
              TextField(
                controller: controller.cvvController,
                decoration: const InputDecoration(labelText: 'CVV'),
              ),
              TextField(
                controller: controller.expiryDateController,
                decoration: const InputDecoration(labelText: 'Expiry Date'),
              ),
              TextField(
                controller: controller.pinController,
                decoration: const InputDecoration(labelText: 'PIN'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.storeEncryptedCreditCardInfo(
                    creditCardNumber:
                        controller.creditCardNumberController.text,
                    cvv: controller.cvvController.text,
                    expiryDate: controller.expiryDateController.text,
                    pin: controller.pinController.text,
                  );
                },
                child: const Text('Store Credit Card Info'),
              ),
              const SizedBox(height: 50),
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: controller.fetchAndDecryptCreditCardInfoStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final creditCardList = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final creditCardInfo in creditCardList)
                          Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Credit Card Number: ${creditCardInfo['creditCardNumber']}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('CVV: ${creditCardInfo['cvv']}'),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Expiry Date: ${creditCardInfo['expiryDate']}'),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.share))
                                  ],
                                ),
                                Text('PIN: ${creditCardInfo['pin']}'),
                                const Divider(), // Add a divider between card details
                              ],
                            ),
                          ),
                      ],
                    );
                  } else {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('No credit card info stored.'),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
