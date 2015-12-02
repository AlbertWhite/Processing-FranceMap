class Place{
  public int postcode;
  public String name;
  public float x;
  public float y;
  public float population;
  public boolean highLighted;
  
  public Place(String name, int postcode, float x, float y,float population,boolean highLighted){
    this.x = x;
    this.y = y;
    this.postcode = postcode;
    this.population = population;
    this.name=name;
    this.highLighted = highLighted;
  }
  
  void draw(int x,int y) {
    fill(255,0,0);    
    stroke(255,255,255);
    if(highLighted){
      ellipse(x, y, 6, 6);
      text(name,x,y);
    }else if(population < 10000){
      fill(254,230,206); 
      ellipse(x, y, 6, 6);
    }else if(population < 100000){
      fill(253,174,107); 
      ellipse(x, y, 6, 6);
    }else if(population > 10000){
      fill(230,85,13); 
      ellipse(x, y, 6, 6);
    }  
    
  }
  
    boolean contains(int px, int py) {
    // Since we draw a circle, we use here the distance between (px, py) and the circle's center.
    // We add an extra pixel to facilitate mouse picking.
    return dist(mapX(x), mapY(y), px, py) <= 1;
  }
}
