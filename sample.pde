//initial every node as a object
float minX, maxX;
float minY, maxY;
int totalCount; // total number of places
float minPopulation, maxPopulation,minPopulationToDisplay = 1000;
float minSurface, maxSurface;
float minAltitude, maxAltitude;
float opacity;
Place place[];//the file name should be the same as the class name
int lastHighLightedPlace = 0;
boolean contain = false;
  
void setup(){
  size(800,800);
  readData();
}

void draw(){
  background(83,111,173);
  color black = color(0);
  int mapX, mapY;
  
  fill(36,72,44);
  rect(30,700,20,20);
  fill(81,97,74);
  rect(60,700,20,20);
  fill(202,197,164);
  rect(90,700,20,20);
  textSize(10);
  fill(255,255,255);
  text("Population density increases", 10, 740);  
  
  textSize(10);
  text("Press arrow keys to change minimum population", 10, 760);
  text("Displaying populations above "+minPopulationToDisplay, 10, 780);

  
  for(int i = 0; i < totalCount - 2; i++){
    mapX = (int)mapX(place[i].x);
    mapY = (int)mapY(place[i].y);
    if(place[i].population > minPopulationToDisplay){
      place[i].draw(mapX, mapY);
    }
  }
  
  if(contain){
    int x1 = (int)mapX(place[lastHighLightedPlace].x);
    int y1 = (int)mapY(place[lastHighLightedPlace].y);
    fill(0,0,0,80);   
    rect(x1,y1,200,70);
    fill(255,255,255);    
    textSize(15);
    text(place[lastHighLightedPlace].name,x1+20,y1+20);
    textSize(12);
    text("Postcode: "+place[lastHighLightedPlace].postcode,x1+20,y1+40);      
    text("Population: "+place[lastHighLightedPlace].population,x1+20,y1+60);  
  }
  if(keyPressed){
    if (keyCode == UP && minPopulationToDisplay > 0) {
      minPopulationToDisplay -= 50;
    } else if (keyCode == DOWN) {
      minPopulationToDisplay += 50;
    } 
    redraw();//redraw make uses of the drawing function with the parameter changes
  }
      

}

void readData(){
  String[] lines = loadStrings("villes.tsv");
  parseInfo(lines[0]); // read the header line
  int postcode;
  float x,y,population,surface,density;
  String name;
  place = new Place[totalCount - 2];//initial object array
  for(int i = 2 ; i < totalCount; ++i){
    String pieces[] = split(lines[i],TAB);
    name = pieces[4].toString();
    postcode = int(pieces[0]);
    x = float(pieces[1]);
    y = float(pieces[2]);
    surface = float(pieces[6]);
    population = float(pieces[5]);
    density = population/surface;
    place[i - 2] = new Place(name, postcode, x, y, population, surface, density,false);
  }
    


}

void parseInfo(String line) {
  String infoString = line.substring(2); // remove the #
  String[] infoPieces = split(infoString, ',');
  totalCount = int(infoPieces[0]);
  minX = float(infoPieces[1]);
  maxX = float(infoPieces[2]);
  minY = float(infoPieces[3]);
  maxY = float(infoPieces[4]);
  minPopulation = float(infoPieces[5]);
  maxPopulation = float(infoPieces[6]);
  minSurface = float(infoPieces[7]);
  maxSurface = float(infoPieces[8]);
  minAltitude = float(infoPieces[9]);
  maxAltitude = float(infoPieces[10]);
}

float mapX(float x){
  return map(x, minX, maxX,0,800);
}
float mapY(float y){
  return map(y, minY, maxY, 800, 0);
}
float mapOpacity(float population){
  return map(population, 1000, 100000, 0, 100);
}

void KeyPressed(){//a bug for infinite loop in linux for keypressed
    if (keyCode == UP) {
      minPopulationToDisplay -= 50;
    } else if (keyCode == DOWN) {
      minPopulationToDisplay += 50;
    } 
    redraw();//redraw make uses of the drawing function with the parameter changes
    System.out.println(keyPressed);
}

void mouseMoved(){
  contain = false;
  for(int i = 0; i < totalCount - 2; i++){
        if(place[i].contains(mouseX,mouseY)&&(place[i].population > minPopulationToDisplay)){
          place[lastHighLightedPlace].highLighted = false;
          place[i].highLighted = true;
          lastHighLightedPlace = i;
          contain = true;
          redraw();
        }
  }
  if(contain == false){
            place[lastHighLightedPlace].highLighted = false;
            redraw();
  }
  }


