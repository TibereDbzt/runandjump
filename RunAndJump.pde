// Init variables
PFont font;
int width = 800;
int height = 800;
int lineW = 40, lineH = 40;
int area = 20;
color background = color(42, 70, 71);
int time = millis();
String state;
ArrayList<Player> players = new ArrayList<Player>();
Player looser;
ArrayList<Bonus> bonus = new ArrayList<Bonus>();

void setup() {
  size(800, 800);
  font = createFont("BAUHS93.TTF", 32);
  state = "started";
  players.add(new Player((width/4)*3, height/2, color(245,231,36), -1, 1));
  players.add(new Player(width/4, height/2, color(29, 222, 135), 1, 2));
}

void draw() {
  background(71,40,60);
  
  if (state == "started") {
    
    for (Player player : players) {
      player.move();
      player.display();
      
      for (int i = bonus.size() -1 ; i >= 0 ; i--) {
        player.bonus = player.bonus + bonus.get(i).checkHitBox(player.x, player.y);
        //println(player.bonus);
        if (bonus.get(i).state.equals("taken")) {
          bonus.remove(i);
        }
      }
      
      player.testLimits();
      
      if (player.name.equals("Player 1")) {
        player.collision(players.get(1).gaps, 0);
        player.collision(players.get(0).gaps, -1);
      } else if (player.name.equals("Player 2")) {
        player.collision(players.get(1).gaps, -1);
        player.collision(players.get(0).gaps, 0);
      }
      
      if (player.state == "dead") {
        state = "ended";
        looser = player;
      }
    }
    
    if (millis() > time + 5000) {
      bonus.add(new Bonus("jump"));
      time = millis();
    }
    
    for (int i = 0 ; i < bonus.size() ; i++) {
      bonus.get(i).display();
    }
    
  } else if (state == "ended") {
    displayResult();
  }
  delay(20);
}

void displayResult () {
  textFont(font);
  fill(looser.col);
  textSize(50);
  textAlign(CENTER, CENTER);
  text(looser.name + " is dead\nPress space bar to restart", width/2, height/3);
}

void restart () {
  players.get(0).gaps.clear();
  players.get(1).gaps.clear();
  
  players.clear();
  bonus.clear();
  
  players.add(new Player((width/4)*3, height/2, color(245,231,36), -1, 1));
  players.add(new Player(width/4, height/2, color(29, 222, 135), 1, 2));
  
  state = "started";
}

void keyPressed() {
  
  // Commands player 1
  if (key == 'j' && players.get(0).xspeed != 2 && players.get(0).xspeed != -2) {
    players.get(0).direction(-1, 0);
  } else if (key == 'l' && players.get(0).xspeed != -2 && players.get(0).xspeed != 2) {
    players.get(0).direction(1, 0);
  } else if (key == 'i' && players.get(0).yspeed != 2 && players.get(0).yspeed != -2) {
    players.get(0).direction(0, -1);
  } else if (key == 'k' && players.get(0).yspeed != -2 && players.get(0).yspeed != 2) {
    players.get(0).direction(0, 1);
  }
  if (key == 'u') {
    players.get(0).useBonus();
  }
  
  // Commands player 2
  if (key == 'q' && players.get(1).xspeed != 2 && players.get(1).xspeed != -2) {
    players.get(1).direction(-1, 0);
  } else if (key == 'd' && players.get(1).xspeed != -2 && players.get(1).xspeed != 2) {
    players.get(1).direction(1, 0);
  } else if (key == 'z' && players.get(1).yspeed != 2 && players.get(1).yspeed != -2) {
    players.get(1).direction(0, -1);
  } else if (key == 's' && players.get(1).yspeed != -2 && players.get(1).yspeed != 2) {
    players.get(1).direction(0, 1);
  }
  if (key == 'e') {
    players.get(1).useBonus();
  }
  
  if (state == "ended") {
    if (keyCode == 32) {
      restart();
    }
  }
  
}
