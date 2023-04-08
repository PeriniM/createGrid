function windowResized(){
    resizeCanvas(windowWidth, windowHeight);
    background(bg_color);
    grid_width = width;
    grid_height = height;
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
    refreshCanvas();
    if (new_shape == true){
      array_shapes[array_shapes.length-1].createVirtual(cursor.getInd());
    }
    // if the mouse is over a shape when removeToggle is true, show the shape in a different color
    if (removeToggle == true){
      for(let i = 0; i<array_shapes.length; i++){
        if (array_shapes[i].isInside(cursor.getInd()) == true){
          array_shapes[i].show(griglia.lineX, griglia.lineY, 'remove');
          break;
        }
      }
    }
    else if (selectToggle == true){
      for(let i = 0; i<array_shapes.length; i++){
        if (array_shapes[i].isInside(cursor.getInd()) == true){
          array_shapes[i].show(griglia.lineX, griglia.lineY, 'select');
          break;
        }
      }
    }
  }
  
  function mousePressed(){
    if (mouseButton === LEFT && mouseInside()==true) {
      refreshCanvas();
      if (removeToggle == true){
        // if a new shape is being created, remove the whole shape
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
      else if (selectToggle == true){
        if (new_shape == true){
          // remove the shape
            array_shapes.pop();
            new_shape = false;
        }   
        // if a new shape is not being created, check if the cursor is over a shape and change its color
        else{
          for(let i = 0; i<array_shapes.length; i++){
            if (array_shapes[i].isInside(cursor.getInd()) == true){
              colorPicker.input(function() {
                colorPicked = colorPicker.color().levels.slice(0, 3).concat(100);
                array_shapes[i].changeColor(colorPicked);
              });
              colorPicker.elt.click();
              
              //array_shapes[i].changeColor([random(100,255),random(100,255),random(100,255), 100]);
              break;
            }
          }
        }
      }
      else{
        // if a shape is not being created, create a new one
        if (new_shape == false){
          array_shapes.push(new CustomShape(shape_type,0,random(100,255),random(100,255),100));
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
      refreshCanvas();
    }
  }
  
  function refreshCanvas(){
    background(bg_color);
    griglia.show(150,0.5);
    cursor.snap(mouseX, mouseY, griglia.lineY, griglia.lineX);
    if (array_shapes.length!=0){
      for(let i = 0; i<array_shapes.length; i++){
        array_shapes[i].show(griglia.lineX, griglia.lineY, 'add');
      }
    }
    if (removeToggle){
      cursor.show('point','#ff0000', griglia.sideLength/4);
    }
    else if (selectToggle){
      cursor.show('point','#9370DB', griglia.sideLength/4);
    }
    else{
      cursor.show('point','#1abc9c', griglia.sideLength/4);
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
  
  function saveCSV(array_shapes){
    if (array_shapes.length==0){
      empty_alert.style.display = "block";
      timeOutAlert = setTimeout(function(){
          empty_alert.style.display = "none";
          selectToggle = false;
        }, 3000);
    }
    else{
      let x = "", y = ""; 
      let type = "";
      let writer = createWriter('createGrid().csv');
      writer.write(["id, x_vert, y_vert, num_vert, shape_type\n"]);
      
      for (let i = 0; i<array_shapes.length; i++){
        x = array_shapes[i].indicesX.toString().replace(/,/g, ' ');
        y = array_shapes[i].indicesY.toString().replace(/,/g, ' ');
        num_vert = array_shapes[i].indicesX.length.toString();
        type = array_shapes[i].shape_type;
        writer.write([i.toString()+","+x+","+y+","+num_vert+","+type+"\n"]);
      }
      writer.close();
    }
    return false;
  }
  
  function savePNG(){
    if (array_shapes.length==0){
      empty_alert.style.display = "block";
      timeOutAlert = setTimeout(function(){
          empty_alert.style.display = "none";
          selectToggle = false;
        }, 3000);
    }
    else{
      saveCanvas('createGrid', 'png');
    }
    return false;
  }