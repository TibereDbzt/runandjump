class Gap {
  int Xstart, Ystart, Xend, Yend, Xmax, Xmin, Ymax, Ymin;
  String direction;
  
  Gap (int fromx, int fromy) {
    Xstart = fromx;
    Ystart = fromy;
  }
  
  void setDirection (int val, int Xe, int Ye) {
    if ((val % 2) == 0) {
      direction = "horizontal";
      if (Xstart >= Xe) {
        Xmin = Xe;
        Xmax = Xstart;
      } else {
        Xmin = Xstart;
        Xmax = Xe;
      }
      //println("Xmin = " + Xmin + " et Xmax = " + Xmax + " et Y = " + Ystart );
    } else if ((val % 2) != 0) {
      direction = "vertical";
      if (Ystart > Ye) {
        Ymin = Ye;
        Ymax = Ystart;
      } else {
        Ymin = Ystart;
        Ymax = Ye;
      }
      //println("Ymin = " + Ymin + " et Ymax = " + Ymax + " et X = " + Xstart);
    }
    //println(this.direction);
  }
  
  void storeEndPoint (int index, int x, int y) {
    Xend = x;
    Yend = y;
    this.setDirection(index, Xend, Yend);
  }
  
  void display (int xS, int yS, int xE, int yE, color col) {
    strokeWeight(10);
    stroke(col);
    line(xS, yS, xE, yE);
  }
  
}
