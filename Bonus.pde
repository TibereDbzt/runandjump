class Bonus {
  int x, y, w, h;
  String type;
  String state;
  
  Bonus (String typeBonus) {
    x = (int) random(width);
    y = (int) random(height);
    w = 15;
    h = 15;
    state = "available";
    type = typeBonus;
    display();
  }
  
  void display () {
    fill(color(255, 255, 255));
    rect(x, y, w, h, 3);
  }
  
  int checkHitBox (int xPlayer, int yPlayer) {
    if (xPlayer >= x && xPlayer <= (x+w) && yPlayer >= y && yPlayer <= (y+h)) {
      state = "taken";
      return 1;
    } else {
      return 0;
    }
  }
}
