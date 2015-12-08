class Place{
  public int postcode;
  public String name;
  public float x;
  public float y;
  public float surface;
  public float density;
  public float population;
  public boolean highLighted;
  public float radius;
  
  public Place(String name, int postcode, float x, float y,float population, float surface,float density, boolean highLighted){
    this.x = x;
    this.y = y;
    this.postcode = postcode;
    this.surface = surface;
    this.density = density;
    this.name=name;
    this.highLighted = highLighted;
    this.population = population;
  }
  
  void draw(int x,int y) {
    fill(212,253,22);    
    noStroke();
    radius = surface/7;
    if(highLighted){
      ellipse(x, y, radius, radius);
/*      fill(0,0,0,80);   
      rect(x,y,200,70);
      fill(255,255,255);    
      textSize(15);
      text(name,x+20,y+20);
      textSize(12);
      text("Postcode: "+postcode,x+20,y+40);      
      text("Population: "+population,x+20,y+60);       
*/      
    }else if(density < 50){
      fill(36,72,44); 
      ellipse(x, y, radius, radius);
    }else if(density < 200 && density > 50){
      fill(81,97,74); 
      ellipse(x, y, radius, radius);
    }else if(density > 200){
      fill(202,197,164); 
      ellipse(x, y, radius, radius);
    }
    
  }
  
    boolean contains(int px, int py) {
    // Since we draw a circle, we use here the distance between (px, py) and the circle's center.
    // We add an extra pixel to facilitate mouse picking.
    return dist(mapX(x), mapY(y), px, py) <= surface/10;
  }
}
