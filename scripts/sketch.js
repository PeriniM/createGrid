let griglia;
let count = 0;
let x_origin, y_origin, grid_width, grid_height;
let cursor;
let array_shapes = [];
let bg_color = 255;
let new_shape = false;

function setup() {
  createCanvas(windowWidth, windowHeight);
  background(bg_color);
  grid_width = width;
  grid_height = 700;
  x_origin = 0;
  y_origin = 0;
  griglia = new Grid(x_origin, y_origin, grid_width, grid_height, 30);
  griglia.create();
  griglia.show(150,0.5);
  cursor = new Point();
}

function draw() {
  
}

function windowResized(){
  resizeCanvas(windowWidth, windowHeight);
  background(bg_color);
  grid_width = width;
  griglia.update(x_origin,y_origin, grid_width, grid_height);
  cursor.snap(mouseX, mouseY, griglia.lineY, griglia.lineX);
  griglia.show(150,0.5);
  if (array_shapes.length!=0){
    for(let i = 0; i<array_shapes.length; i++){
      array_shapes[i].show(griglia.lineX, griglia.lineY);
    }
  }
}

function mouseMoved(){
  refreshCanvas('#1abc9c');
  if (new_shape == true){
    array_shapes[array_shapes.length-1].createVirtual(cursor.getInd());
  }
}

function mouseWheel(event) {
  if (mouseInside()==true){
    background(bg_color);
    griglia.zoom(event.delta);
    griglia.show(150,0.5);
    if (array_shapes.length!=0){
      for(let i = 0; i<array_shapes.length; i++){
        array_shapes[i].show(griglia.lineX, griglia.lineY);
      }
      array_shapes[array_shapes.length-1].virtual=false;
    }
    if (griglia.suddx==griglia.maxSuddx || griglia.suddx==griglia.minSuddx){
      cursor.show('#1abc9c', griglia.sideLength/4);
    }
    if (new_shape == true){
      array_shapes[array_shapes.length-1].createVirtual(cursor.getInd());
    }
    
  }
  return false;  //block page scrolling
}

function mousePressed(){
  if (mouseButton === LEFT && mouseInside()==true) {
    refreshCanvas('#16a085');
    if (new_shape == false){
      array_shapes.push(new CustomShape(0,random(100,255),random(100,255),100));
      array_shapes[array_shapes.length-1].create(cursor.getInd());
      new_shape = true;
    }
    else {
      if (array_shapes[array_shapes.length-1].indicesX[0] == cursor.indX && array_shapes[array_shapes.length-1].indicesY[0] == cursor.indY){
        new_shape = false;
        array_shapes[array_shapes.length-1].closed=true;
        array_shapes[array_shapes.length-1].virtual=false;
      }
      else{
        array_shapes[array_shapes.length-1].create(cursor.getInd());
      }
    }
  }
}

function mouseReleased(){
  if (mouseInside()==true){
    refreshCanvas('#1abc9c');
  }
}

function refreshCanvas(color){
  background(bg_color);
  griglia.show(150,0.5);
  cursor.snap(mouseX, mouseY, griglia.lineY, griglia.lineX);
  if (array_shapes.length!=0){
    for(let i = 0; i<array_shapes.length; i++){
      array_shapes[i].show(griglia.lineX, griglia.lineY);
    }
  }
  cursor.show(color, griglia.sideLength/4);
}

function mouseInside(){
  if (mouseX>=x_origin && mouseX<=x_origin+grid_width &&  mouseY>=y_origin && mouseY<=y_origin+grid_height) {
    return true;
  }
  else{
    return false;
  }
}

