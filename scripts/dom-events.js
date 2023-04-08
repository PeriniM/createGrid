// DOM ELEMENTS EVENTS
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
      selectToggle = false;
    });
    select_btn.addEventListener('mouseover', function(){
      isMouseOverBtn = true;
    });
    select_btn.addEventListener('mouseout', function(){
      isMouseOverBtn = false;
    });
    select_btn.addEventListener('click', function(){
      removeToggle = false;
      selectToggle = true;
      // if there are no shapes, show an alert
      if (array_shapes.length==0){
        // show the alert container div for 3 seconds
  
        empty_alert.style.display = "block";
        timeOutAlert = setTimeout(function(){
          empty_alert.style.display = "none";
          selectToggle = false;
        }, 3000);
      }
    });
    remove_btn.addEventListener('mouseover', function(){
      isMouseOverBtn = true;
    });
    remove_btn.addEventListener('mouseout', function(){
      isMouseOverBtn = false;
    });
    remove_btn.addEventListener('click', function(){
      removeToggle = true;
      selectToggle = false;
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
      selectToggle = false;
      removeToggle = false;
      refreshCanvas('#1abc9c');
    });
    save_csv_btn.addEventListener('mouseover', function(){
      isMouseOverBtn = true;
    });
    save_csv_btn.addEventListener('mouseout', function(){
      isMouseOverBtn = false;
    });
    save_csv_btn.addEventListener('click', function(){
      saveCSV(array_shapes);
    });
    save_png_btn.addEventListener('mouseover', function(){
      isMouseOverBtn = true;
    });
    save_png_btn.addEventListener('mouseout', function(){
      isMouseOverBtn = false;
    });
    save_png_btn.addEventListener('click', function(){
      savePNG();
    });
    empty_alert.addEventListener('mouseover', function(){
      isMouseOverBtn = true;
    });
    empty_alert.addEventListener('mouseout', function(){
      isMouseOverBtn = false;
    });
    alert_close_btn.addEventListener('click', function(){
      isMouseOverBtn = false;
      selectToggle = false;
      empty_alert.style.display = "none";
      clearTimeout(timeOutAlert);
    });
  
    // TYPE OF SHAPES SELECTOR
    default_shape_btn.addEventListener('click', function(){
      shape_type = 'default';
      console.log(shape_type);
    });
    room_shape_btn.addEventListener('click', function(){
      shape_type = 'room';
      console.log(shape_type);
    });
    obstacle_shape_btn.addEventListener('click', function(){
      shape_type = 'obstacle';
      console.log(shape_type);
    });
    agent_shape_btn.addEventListener('click', function(){
      shape_type = 'agent';
      console.log(shape_type);
    });
    uwb_anchor_shape_btn.addEventListener('click', function(){
      shape_type = 'uwb_anchor';
      console.log(shape_type);
    });
    uwb_sensor_shape_btn.addEventListener('click', function(){
      shape_type = 'uwb_sensor';
      console.log(shape_type);
    });
    stereo_camera_shape_btn.addEventListener('click', function(){
      shape_type = 'stereo_camera';
      console.log(shape_type);
    });
    lidar_shape_btn.addEventListener('click', function(){
      shape_type = 'lidar';
      console.log(shape_type);
    });
  };
  