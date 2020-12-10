class Player {
  int x, y, xspeed, yspeed;
  int startX, startY;
  color col;
  int gapIndex = 0;
  String name;
  String state;
  ArrayList<Gap> gaps = new ArrayList<Gap>();
  int bonus;
  
  Player (int valX, int valY, color hexa, int speedXStart, int playerNumber) {
    x = valX;
    y = valY;
    startX = valX;
    startY = valY;
    col = hexa;
    bonus = 0;
    xspeed = speedXStart *2;
    yspeed = 0;
    name = "Player " + playerNumber;
    state = "alive";
    gaps.add(new Gap(startX, startY));
  }
  
  void display () {
    strokeWeight(0);
    fill(col);
    circle(x, y, 20);
  }
  
  void direction (int valX, int valY) {
    gaps.get(gapIndex).storeEndPoint(gapIndex, x, y);
    xspeed = valX * 2;
    yspeed = valY * 2;
    startX = x;
    startY = y;
    gapIndex++;
    gaps.add(new Gap(startX, startY));
  }
  
  void move () {
    x = x + xspeed;
    y = y + yspeed;
    gaps.get(gapIndex).setDirection(gapIndex, x, y);
    gaps.get(gapIndex).display(gaps.get(gapIndex).Xstart, gaps.get(gapIndex).Ystart, x, y, col);
    for (int i = 0 ; i < gaps.size() - 1 ; i++) {
      gaps.get(i).display(gaps.get(i).Xstart, gaps.get(i).Ystart, gaps.get(i).Xend, gaps.get(i).Yend, col);
    }
  }
  
  void collision (ArrayList<Gap> gapComparing, int offset) {
    for (int i = 0 ; i < gapComparing.size() + offset ; i++ ) {
      if (gapComparing.get(i).direction == "vertical") {
        if (x == gapComparing.get(i).Xstart ) {
          if (y >= gapComparing.get(i).Ymin && y <= gapComparing.get(i).Ymax) {
            state = "dead";
          }
        }
      } else if (gapComparing.get(i).direction == "horizontal") {
        if (y == gapComparing.get(i).Ystart ) {
          if (x >= gapComparing.get(i).Xmin && x <= gapComparing.get(i).Xmax) {
            state = "dead";
          }
        }
      } else {
      }
    }
  }

  void testLimits () {
    if (x >= width || x < 0 || y > height || y < 0) {
      state = "dead";
    } else {
      state = "alive";
    }
  }
  
  void useBonus () {
    if (bonus > 0) {
      bonus--;
      println("Bonus utilisé, mais il ne sert à rien pour l'instant...");
    } else {
      println(name + " n'a pas de bonus !");
    }
  }

}
