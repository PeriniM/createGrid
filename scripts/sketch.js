let griglia;
let count = 0;
let x_origin, y_origin, grid_width, grid_height;
let cursor;
let array_shapes = [];
let bg_color = 255;
let new_shape = false;
let indxMax = 0;
let indyMax = 0;

let add_btn = document.getElementById('button-add');
let remove_btn = document.getElementById('button-remove');
let clear_btn = document.getElementById('button-clear');
let save_csv_btn = document.getElementById('button-csv');
let isMouseOverBtn = false;
let removeToggle = false;

function setup() {
  createCanvas(windowWidth, windowHeight);
  background(bg_color);
  grid_width = width;
  grid_height = height;
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
      array_shapes[i].show(griglia.lineX, griglia.lineY, false);
    }
  }
}

function mouseMoved(){
  refreshCanvas('#1abc9c');
  if (new_shape == true){
    array_shapes[array_shapes.length-1].createVirtual(cursor.getInd());
  }
  // if the mouse is over a shape when removeToggle is true, show the shape in a different color
  if (removeToggle == true){
    for(let i = 0; i<array_shapes.length; i++){
      if (array_shapes[i].isInside(cursor.getInd()) == true){
        array_shapes[i].show(griglia.lineX, griglia.lineY, true);
        break;
      }
    }
  }
}

function mousePressed(){
  if (mouseButton === LEFT && mouseInside()==true) {
    refreshCanvas('#16a085');
    if (removeToggle == true){
      // if a new shape is being created, remove the last point
      if (new_shape == true){
        // remove the shape
          array_shapes.pop();
          new_shape = false;
      }   
      // if a new shape is not being created, check if the cursor is over a shape and remove it
      else{
        for(let i = 0; i<array_shapes.length; i++){
          if (array_shapes[i].isInside(cursor.getInd()) == true){
            array_shapes.splice(i,1);
            break;
          }
        }
      }
    }
    else{
      if (new_shape == false){
        array_shapes.push(new CustomShape(0,random(100,255),random(100,255),100));
        array_shapes[array_shapes.length-1].create(cursor.getInd());
        new_shape = true;
        indxMax = indxMax < cursor.getInd()[0] ? cursor.getInd()[0] : indxMax; 
        indyMax = indyMax < cursor.getInd()[1] ? cursor.getInd()[1] : indyMax;
      }
      else {
        if (array_shapes[array_shapes.length-1].indicesX[0] == cursor.indX && array_shapes[array_shapes.length-1].indicesY[0] == cursor.indY){
          new_shape = false;
          array_shapes[array_shapes.length-1].closed=true;
          array_shapes[array_shapes.length-1].virtual=false;
        }
        else{
          array_shapes[array_shapes.length-1].create(cursor.getInd());
          indxMax = indxMax < cursor.getInd()[0] ? cursor.getInd()[0] : indxMax; 
          indyMax = indyMax < cursor.getInd()[1] ? cursor.getInd()[1] : indyMax;
        }
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
      array_shapes[i].show(griglia.lineX, griglia.lineY, false);
    }
  }
  if (!removeToggle){
    cursor.show('point',color, griglia.sideLength/4);
  }
  else{
    cursor.show('cross','#ff0000', griglia.sideLength/12);
  }
}

function mouseInside(){
  // check if the mouse is inside the grid
  if (mouseX>=x_origin && mouseX<=x_origin+grid_width &&  mouseY>=y_origin && mouseY<=y_origin+grid_height && isMouseOverBtn==false) {

    return true;
  }
  else{
    return false;
  }
}

function saveCSV(){
  if (array_shapes.length==0){
    alert("There are no elements on the grid!")
  }
  else{
    let x = "", y = ""; 
    let writer = createWriter('createGrid().csv');
    writer.write(["id, x_vert, y_vert, num_vert\n"]);
    
    for (let i = 0; i<array_shapes.length; i++){
      x = array_shapes[i].indicesX.toString().replace(/,/g, ' ');
      y = array_shapes[i].indicesY.toString().replace(/,/g, ' ');
      num_vert = array_shapes[i].indicesX.length.toString();

      writer.write([i.toString()+","+x+","+y+","+num_vert+"\n"]);
    }
    writer.close();
  }
  return false;
}

// wait for the page to load
window.onload = function() {
  // add event listener to the buttons
  add_btn.addEventListener('mouseover', function(){
    isMouseOverBtn = true;
  });
  add_btn.addEventListener('mouseout', function(){
    isMouseOverBtn = false;
  });
  add_btn.addEventListener('click', function(){
    removeToggle = false;
  });
  remove_btn.addEventListener('mouseover', function(){
    isMouseOverBtn = true;
  });
  remove_btn.addEventListener('mouseout', function(){
    isMouseOverBtn = false;
  });
  remove_btn.addEventListener('click', function(){
    removeToggle = true;
  });
  clear_btn.addEventListener('mouseover', function(){
    isMouseOverBtn = true;
  });
  clear_btn.addEventListener('mouseout', function(){
    isMouseOverBtn = false;
  });
  clear_btn.addEventListener('click', function(){
    array_shapes = [];
    new_shape = false;
    indxMax = 0;
    indyMax = 0;
    refreshCanvas('#1abc9c');
  });
  save_csv_btn.addEventListener('mouseover', function(){
    isMouseOverBtn = true;
  });
  save_csv_btn.addEventListener('mouseout', function(){
    isMouseOverBtn = false;
  });
  save_csv_btn.addEventListener('click', function(){
    saveCSV();
  });
};
