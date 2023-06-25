import 'dart:math';

int generateRandomNumber(){
  Random random = Random();
  int randomNumber = random.nextInt(10000000);
  return randomNumber;
}

