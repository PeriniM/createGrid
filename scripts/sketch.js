let griglia;
let count = 0;
let x_origin, y_origin, grid_width, grid_height;
let cursor;
let array_shapes = [];
let bg_color = 255;
let new_shape = false;
let shape_type = 'default';
let indxMax = 0;
let indyMax = 0;

// DOM elements definition
let add_btn = document.getElementById('button-add');
let select_btn = document.getElementById('button-select');
let remove_btn = document.getElementById('button-remove');
let clear_btn = document.getElementById('button-clear');
let save_csv_btn = document.getElementById('button-csv');
let save_png_btn = document.getElementById('button-png');
let empty_alert = document.getElementById('empty-alert');
let alert_close_btn = document.getElementById('close-alert');

let default_shape_btn = document.getElementById('default-shape');
let room_shape_btn = document.getElementById('room-shape');
let obstacle_shape_btn = document.getElementById('obstacle-shape');
let agent_shape_btn = document.getElementById('agent-shape');
let uwb_anchor_shape_btn = document.getElementById('uwb-anchor-shape');
let uwb_sensor_shape_btn = document.getElementById('uwb-sensor-shape');
let stereo_camera_shape_btn = document.getElementById('stereo-camera-shape');
let lidar_shape_btn = document.getElementById('lidar-shape');


// Variable for actions on shapes
let isMouseOverBtn = false, removeToggle = false, selectToggle = false;
let timeOutAlert;

// Define a ColorPicker object
let colorPicker;
let colorPicked;

function setup() {
  createCanvas(windowWidth, windowHeight);
  background(bg_color);
  grid_width = width;
  grid_height = height;
  x_origin = 0;
  y_origin = 0;

  // Grid(x0, y0, w, h, horizontal_subdivisions)
  griglia = new Grid(x_origin, y_origin, grid_width, grid_height, 100);
  griglia.create();
  // show(stroke_color, stroke_weight)
  griglia.show(150,0.5);
  cursor = new Point();

  colorPicker = createColorPicker( '#ff0000' );
  colorPicker.position(width/2, height/2);
  colorPicker.style('display', 'none');
}

function draw() {
}