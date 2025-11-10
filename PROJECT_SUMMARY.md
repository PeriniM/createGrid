# createGrid() - Project Summary

## Project Overview

**createGrid()** is a web-based interactive grid creation tool designed for generating custom geometric shapes with vertices fixed on a squared grid system. The application serves as a specialized tool for creating grid elements used in Finite Element Methods (FEM) and Virtual Element Methods (VEM) analysis.

### Key Information
- **Developer**: Marco Perini
- **Year**: 2022
- **License**: MIT License
- **Live Demo**: [https://perinim.github.io/createGrid/](https://perinim.github.io/createGrid/)
- **Repository**: GitHub - PeriniM/createGrid

### Purpose
The primary goal is to quickly generate grid elements for repetitive patterns, particularly useful for:
- Finite Element Methods (FEM) algorithm analysis
- Virtual Element Methods (VEM) algorithm analysis
- Grid-based computational geometry research
- Educational purposes in computational mathematics

## Technical Architecture

### Frontend Architecture
The application follows a modular JavaScript architecture built on top of p5.js for canvas-based interactive graphics:

```
Frontend Layer
├── p5.js Canvas Engine
├── Bootstrap UI Framework
├── Custom JavaScript Modules
└── DOM Event Management
```

### Backend Integration
MATLAB scripts provide post-processing capabilities for exported grid data:

```
MATLAB Integration
├── CSV Import & Normalization
├── Grid Visualization
├── Path Planning & Animation
└── Node Enumeration Utilities
```

## Technology Stack

### Frontend Technologies
- **p5.js**: Interactive canvas drawing and graphics rendering
- **Bootstrap 4.0.0**: Responsive UI framework and styling
- **jQuery 3.2.1**: DOM manipulation and event handling
- **Popper.js 1.12.9**: Tooltip and dropdown positioning
- **HTML5 Canvas**: Graphics rendering surface
- **CSS3**: Custom styling and responsive design

### Backend/Processing Technologies
- **MATLAB**: Grid processing, normalization, and visualization
- **CSV**: Data exchange format between web app and MATLAB

### Development Tools
- **Git**: Version control
- **GitHub Pages**: Hosting and deployment

## File Structure Breakdown

```
createGrid/
├── index.html                 # Main application entry point
├── README.md                  # Project documentation
├── LICENSE                    # MIT license file
├── PROJECT_SUMMARY.md         # This comprehensive summary
│
├── scripts/                   # Core JavaScript modules
│   ├── sketch.js             # Main p5.js application logic
│   ├── Grid.js               # Grid management and rendering
│   ├── CustomShape.js        # Shape creation and manipulation
│   ├── Point.js              # Coordinate handling and snapping
│   ├── dom-events.js         # UI event handlers
│   └── utils.js              # Utility functions and helpers
│
├── styles/                    # Styling and CSS
│   └── style.css             # Custom application styles
│
├── libraries/                 # External JavaScript libraries
│   ├── p5.js                 # p5.js core library
│   └── p5.dom.min.js         # p5.js DOM manipulation extension
│
├── matlab/                    # MATLAB processing scripts
│   ├── import_grid.m         # CSV import and grid normalization
│   ├── pathplanning.m        # Trajectory generation and animation
│   ├── enum_nodes.m          # Node enumeration utility
│   ├── shapes_csv/           # Sample CSV files
│   │   ├── path1.csv
│   │   ├── path2.csv
│   │   ├── random.csv
│   │   ├── shield.csv
│   │   └── star.csv
│   └── testAnimated.gif      # Example animation output
│
└── img_readme/               # Documentation images
    ├── grid_star.PNG
    ├── matlab_overview_star.PNG
    ├── matlab_plot.JPG
    ├── overview_grid.PNG
    ├── overview_grid_star.PNG
    └── star_rect_grid.PNG
```

## Key Features

### Interactive Drawing System
- **Grid-based Drawing**: All shapes are constrained to grid vertices
- **Real-time Vertex Snapping**: Automatic alignment to nearest grid points
- **Multiple Shape Types**: Support for 8 different shape categories
- **Visual Feedback**: Live preview during shape creation

### Shape Management
- **Shape Types Available**:
  - Default (general purpose shapes)
  - Room (architectural elements)
  - Obstacle (barriers and obstructions)
  - Agent (mobile entities)
  - UWB Anchor (Ultra-Wideband positioning anchors)
  - UWB Sensor (Ultra-Wideband sensors)
  - Stereo Camera (vision sensors)
  - LiDAR (laser range sensors)

### Customization Features
- **Color Picker Integration**: Custom color selection for each shape
- **Grid Configuration**: Adjustable grid subdivisions (default: 100)
- **Responsive Design**: Automatic canvas resizing
- **Shape Selection and Removal**: Interactive shape management

### Export Capabilities
- **CSV Export**: Grid data export for MATLAB processing
- **PNG Export**: Visual documentation and sharing
- **MATLAB Integration**: Seamless workflow with computational tools

## Usage Instructions

### Getting Started
1. **Access the Application**: Visit [https://perinim.github.io/createGrid/](https://perinim.github.io/createGrid/) or open `index.html` locally
2. **Canvas Interaction**: The main canvas displays a grid where you can create shapes
3. **Shape Creation**: Use the bottom toolbar to select shape types and drawing modes

### Basic Workflow
1. **Select Shape Type**: Choose from the dropdown menu (Default, Room, Obstacle, etc.)
2. **Click "Add"**: Enter drawing mode
3. **Draw Shape**: Click on grid vertices to create shape points
4. **Complete Shape**: Right-click or press Enter to close the shape
5. **Customize**: Use the color picker to change shape appearance
6. **Export**: Save as CSV for MATLAB processing or PNG for documentation

### Advanced Features
- **Shape Selection**: Use "Select" mode to highlight and modify existing shapes
- **Shape Removal**: Use "Remove" mode to delete unwanted shapes
- **Clear All**: "Clear" button removes all shapes from the canvas
- **Grid Adaptation**: Canvas automatically adjusts to window size

### MATLAB Integration Workflow
1. **Export CSV**: Use the CSV button to download grid data
2. **MATLAB Processing**: Run `import_grid.m` to normalize and visualize
3. **Path Planning**: Use `pathplanning.m` for trajectory generation
4. **Animation**: Generate animated visualizations of paths

## Development Roadmap

### Completed Features ✅
- [x] Interactive grid-based shape creation
- [x] Multiple shape type support
- [x] Color customization
- [x] CSV export functionality
- [x] PNG export capability
- [x] Responsive design
- [x] MATLAB integration scripts

### Planned UI Improvements 🔄
- [ ] **3D Grid Rotation**: Add camera controls for 3D grid manipulation
- [ ] **Floating Parameter Window**: Dynamic parameter modification interface
- [ ] **Enhanced Mobile Support**: Improved touch interaction

### Planned Object Enhancements 🔄
- [ ] **Dynamic Grid Subdivision**: Runtime grid density adjustment
- [ ] **3D Object Creation**: Support for three-dimensional shapes
- [ ] **Vertex Editing**: Select and move existing shape vertices
- [ ] **Shape Gap Filling**: Automatic patch generation between shapes
- [ ] **Shape Templates**: Predefined common geometric patterns
- [ ] **Undo/Redo System**: Action history management

### Technical Improvements 🔄
- [ ] **Performance Optimization**: Enhanced rendering for complex grids
- [ ] **Data Persistence**: Local storage for session management
- [ ] **Export Formats**: Additional export options (SVG, DXF)
- [ ] **Grid Customization**: Non-square grid support
- [ ] **Collaborative Features**: Multi-user editing capabilities

## Technical Implementation Notes

### Grid System
- Default subdivision: 100x100 grid
- Automatic aspect ratio adjustment
- Configurable grid density (10-50 subdivisions)
- Real-time grid updates on window resize

### Shape Rendering
- Vector-based shape representation
- Index-based coordinate system (not absolute coordinates)
- Efficient memory usage through grid referencing
- Support for both closed and open shapes

### Data Export Format
CSV structure includes:
- Shape type identification
- Vertex coordinates (grid indices)
- Color information (RGBA values)
- Shape metadata

### Browser Compatibility
- Modern browsers with HTML5 Canvas support
- Responsive design for desktop and mobile
- Touch-friendly interface for tablet use

## Contributing and Development

### Development Setup
1. Clone the repository
2. Open `index.html` in a web browser
3. No build process required - pure client-side application

### Code Structure
- Modular JavaScript architecture
- Object-oriented design patterns
- Event-driven user interaction
- Separation of concerns between rendering and logic

### Testing
- Manual testing through web interface
- MATLAB script validation with sample data
- Cross-browser compatibility testing

## Core JavaScript Classes Documentation

### Grid.js - Grid Management System

The `Grid` class serves as the foundation for the entire grid-based drawing system, managing grid creation, subdivision, and rendering.

#### Class Structure
```javascript
class Grid {
  constructor(x0, y0, w, h, sudd)
  create()
  update(x0, y0, w, h)
  show(stroke_color, stroke_weight)
}
```

#### Properties
- **`x0, y0`**: Grid origin coordinates (top-left corner)
- **`w, h`**: Grid width and height in pixels
- **`suddx`**: Number of horizontal subdivisions (default: 100)
- **`suddy`**: Number of vertical subdivisions (calculated based on aspect ratio)
- **`sideLength`**: Size of each grid cell in pixels
- **`maxSuddx, minSuddx`**: Subdivision limits (50 max, 10 min)
- **`lineX[], lineY[]`**: Arrays storing grid line coordinates

#### Key Methods
- **`create()`**: Generates grid line coordinates based on subdivisions
  - Creates horizontal lines (`lineY`) and vertical lines (`lineX`)
  - Ensures exact boundary alignment for the last lines
- **`update(x0, y0, w, h)`**: Dynamically updates grid when canvas resizes
  - Recalculates `sideLength` and `suddy` based on new dimensions
  - Regenerates line coordinates
- **`show(stroke_color, stroke_weight)`**: Renders the grid on canvas
  - Draws vertical lines from top to bottom
  - Draws horizontal lines from left to right

#### Usage Pattern
```javascript
// Initialize grid with 100 subdivisions
griglia = new Grid(0, 0, windowWidth, windowHeight, 100);
griglia.create();
griglia.show(150, 0.5); // Gray lines with 0.5px weight
```

### CustomShape.js - Shape Creation and Manipulation

The `CustomShape` class handles the creation, rendering, and interaction of geometric shapes on the grid system.

#### Class Structure
```javascript
class CustomShape {
  constructor(shape_type, red, green, blue, alpha)
  create(indices)
  createVirtual(indices)
  show(lineX, lineY, toggle)
  isInside(indices)
  removeLast()
  changeColor(color)
}
```

#### Properties
- **`indicesX[], indicesY[]`**: Grid indices for shape vertices (not absolute coordinates)
- **`red, green, blue, alpha`**: RGBA color values
- **`closed`**: Boolean indicating if shape is complete
- **`virtual`**: Boolean for temporary preview vertices
- **`shape_type`**: String identifier for shape category

#### Key Methods
- **`create(indices)`**: Adds a permanent vertex to the shape
  - Pushes grid indices to `indicesX` and `indicesY` arrays
  - Sets `virtual = false` for permanent vertices
- **`createVirtual(indices)`**: Adds temporary preview vertex
  - Used for real-time shape preview during creation
  - Automatically removed after rendering
- **`show(lineX, lineY, toggle)`**: Renders the shape with different visual states
  - **Normal mode**: Uses shape's RGBA color
  - **Remove mode**: Red highlight (255,0,0,150)
  - **Select mode**: Semi-transparent shape color
  - Converts grid indices to pixel coordinates using `lineX` and `lineY`
- **`isInside(indices)`**: Point-in-polygon collision detection
  - Uses ray casting algorithm for accurate inside/outside testing
  - Essential for shape selection and removal
- **`removeLast()`**: Removes the last added vertex
- **`changeColor(color)`**: Updates shape color from color picker

#### Shape Types Supported
- `default`: General purpose shapes
- `room`: Architectural elements
- `obstacle`: Barriers and obstructions
- `agent`: Mobile entities
- `uwb_anchor`: Ultra-Wideband positioning anchors
- `uwb_sensor`: Ultra-Wideband sensors
- `stereo_camera`: Vision sensors
- `lidar`: Laser range sensors

#### Coordinate System Design
The class uses a grid-index-based coordinate system rather than absolute pixel coordinates:
- **Advantages**: Resolution-independent, automatic scaling, memory efficient
- **Implementation**: Vertices stored as `[gridIndexX, gridIndexY]` pairs
- **Rendering**: Indices converted to pixels using `lineX[indicesX[i]]` and `lineY[indicesY[i]]`

### Point.js - Coordinate Handling and Snapping

The `Point` class manages cursor positioning and implements the grid snapping mechanism that ensures all interactions align with grid vertices.

#### Class Structure
```javascript
class Point {
  constructor()
  snap(x, y, lineY, lineX)
  getInd()
  show(style, stroke_color, stroke_weight)
}
```

#### Properties
- **`x, y`**: Snapped pixel coordinates
- **`indX, indY`**: Corresponding grid indices

#### Key Methods
- **`snap(x, y, lineY, lineX)`**: Core snapping algorithm
  - Takes raw mouse coordinates and grid line arrays
  - Finds nearest grid intersection within `sideLength/2` tolerance
  - Updates both pixel coordinates and grid indices
  - Only operates when mouse is inside canvas bounds
- **`getInd()`**: Returns current grid indices as `[indX, indY]` array
- **`show(style, stroke_color, stroke_weight)`**: Renders cursor indicator
  - **Point style**: Single pixel dot
  - **Cross style**: Crosshair with configurable size

#### Snapping Algorithm Details
```javascript
// For each axis, find the closest grid line
for (let i = 0; i < lineX.length; i++) {
  let d = lineX[i] - x;
  if (abs(d) <= sideLength / 2) {
    this.x = lineX[i];      // Snap to current line
    this.indX = i;
  } else if (abs(d) > sideLength / 2 && abs(d) < sideLength) {
    this.x = lineX[i + 1];  // Snap to next line
    this.indX = i + 1;
  }
}
```

#### Visual Feedback System
The cursor changes color based on current mode:
- **Add mode**: Teal (`#1abc9c`)
- **Remove mode**: Red (`#ff0000`)
- **Select mode**: Purple (`#9370DB`)

### sketch.js - Main p5.js Application Logic

The `sketch.js` file contains the main p5.js application logic, global variables, and core application state management.

#### Global Variables and State Management
```javascript
// Core objects
let griglia;              // Main Grid instance
let cursor;               // Point instance for cursor tracking
let array_shapes = [];    // Array of all CustomShape instances
let colorPicker;          // p5.js color picker widget

// Application state
let new_shape = false;    // Currently creating a shape
let shape_type = 'default'; // Selected shape type
let removeToggle = false; // Remove mode active
let selectToggle = false; // Select mode active
let isMouseOverBtn = false; // Prevent canvas interaction over UI

// Grid parameters
let x_origin, y_origin, grid_width, grid_height;
let bg_color = 255;       // White background
```

#### Core p5.js Functions

**`setup()`** - Application Initialization
- Creates full-window canvas (`createCanvas(windowWidth, windowHeight)`)
- Initializes grid with 100 subdivisions
- Creates cursor Point instance
- Sets up color picker widget (initially hidden)
- Renders initial grid state

**`draw()`** - Main Animation Loop
- Currently empty - all rendering handled by event-driven functions
- Application uses event-based rendering for better performance

#### Event-Driven Architecture

The application uses a sophisticated event-driven system rather than continuous rendering:

**Mouse Events** (from utils.js):
- **`mouseMoved()`**: Updates cursor position and provides real-time feedback
  - Snaps cursor to grid
  - Shows virtual shape preview during creation
  - Highlights shapes in remove/select modes
- **`mousePressed()`**: Handles shape creation and interaction
  - Left-click adds vertices or interacts with shapes
  - Right-click completes shape creation
- **`mouseReleased()`**: Cleanup after mouse interactions

**Window Events**:
- **`windowResized()`**: Responsive canvas adjustment
  - Resizes canvas to new window dimensions
  - Updates grid parameters
  - Redraws all existing shapes

#### Shape Creation Workflow
1. User selects shape type from dropdown
2. Clicks "Add" button to enter creation mode
3. Each click adds a vertex to the current shape
4. Virtual preview shows shape as it's being created
5. Right-click or double-click completes the shape
6. Shape is added to `array_shapes` array

#### Rendering Pipeline
```javascript
function refreshCanvas() {
  background(bg_color);           // Clear canvas
  griglia.show(150, 0.5);        // Draw grid
  cursor.snap(mouseX, mouseY, griglia.lineY, griglia.lineX); // Update cursor
  
  // Render all shapes
  for(let i = 0; i < array_shapes.length; i++) {
    array_shapes[i].show(griglia.lineX, griglia.lineY, 'add');
  }
  
  // Show cursor with mode-specific color
  cursor.show('point', modeColor, griglia.sideLength/4);
}
```

#### Integration with DOM Events
The sketch.js file works closely with dom-events.js to provide seamless UI interaction:
- Button states control application modes
- Color picker integration for shape customization
- Export functionality for CSV and PNG files
- Alert system for user feedback

#### Memory Management
- Shapes stored efficiently using grid indices
- Dynamic array management for shape collection
- Automatic cleanup during shape removal
- Responsive grid updates without memory leaks

## MATLAB Integration Component

The MATLAB integration provides powerful post-processing capabilities for grid data exported from the web application. The system consists of three specialized scripts that handle CSV import, grid normalization, visualization, and advanced path planning functionality.

### import_grid.m - CSV Processing and Grid Normalization

The `import_grid.m` script serves as the primary interface between the web application and MATLAB's computational environment, handling CSV import, coordinate normalization, and grid generation.

#### Core Functionality

**CSV Import and Parsing**
```matlab
T = readtable('star.csv', 'ReadVariableNames',false, 'Delimiter',',', 'HeaderLines',1, 'TreatAsEmpty',{'NA','na'});
```
- Reads CSV files exported from the web application
- Handles variable column counts for different shape complexities
- Processes grid indices and converts them to coordinate arrays
- Supports multiple shapes per CSV file

**Coordinate System Processing**
The script processes coordinates using a sophisticated parsing system:
```matlab
x = str2num(string(T{i,2:3:end}));  % Extract X coordinates
y = str2num(string(T{i,3:3:end}))*-1;  % Extract Y coordinates (inverted)
```
- Extracts X coordinates from every 3rd column starting at column 2
- Extracts Y coordinates from every 3rd column starting at column 3
- Applies Y-axis inversion to match MATLAB's coordinate system
- Stores coordinates in cell arrays for flexible shape handling

**Normalization Algorithm**
The script implements a comprehensive normalization system:
```matlab
% Find global bounds across all shapes
x_max, y_max, x_min, y_min = findGlobalBounds(shapes);

% Normalize to [0,1] range
shape{i,j} = (shape{i,j} - min_val)/(max_val - min_val);
```
- Calculates global bounding box across all imported shapes
- Normalizes coordinates to [0,1] range for both axes
- Maintains aspect ratio and relative positioning
- Enables scale-independent analysis

**Grid Generation System**
```matlab
suddx = 5; % Number of columns
suddy = 5; % Number of rows
dx = f1/suddx; dy = f2/suddy; % Cell dimensions
```
- Creates configurable grid subdivisions (default 5x5)
- Generates element-wise coordinate arrays
- Supports both square and rectangular grid configurations
- Scales normalized shapes to fit grid cells

**Finite Element Mesh Creation**
The script generates finite element mesh structures:
- **Element Arrays**: `elem_x{}, elem_y{}` store coordinates for each element
- **Node Coordination**: Builds global node coordinate arrays
- **Boundary Detection**: Identifies boundary nodes for FEM analysis
- **Element Connectivity**: Maintains element-to-node relationships

#### Visualization Capabilities
- **Shape Preview**: Plots normalized shapes with element numbering
- **Grid Visualization**: Displays generated finite element mesh
- **Boundary Highlighting**: Shows boundary nodes and elements
- **Element Numbering**: Optional element and node labeling

#### Output Data Structures
```matlab
griglia.elements = indelem;           % Total number of elements
griglia.vertices = [xvert; yvert];    % Node coordinates
griglia.bordo = b(:);                 % Boundary node indices
griglia.dirichlet = b(:);             % Dirichlet boundary conditions
```

### pathplanning.m - Trajectory Generation and Animation

The `pathplanning.m` script provides advanced trajectory generation, spline interpolation, and animated visualization capabilities for mobile robot path planning applications.

#### Trajectory Generation System

**Spline-Based Path Interpolation**
```matlab
% Create smooth trajectory using spline interpolation
x2 = spline(t, x, t2);  % X-coordinate trajectory
y2 = spline(t, y, t2);  % Y-coordinate trajectory
```
- Uses MATLAB's spline function for smooth trajectory generation
- Interpolates between waypoints with C² continuity
- Supports custom time parameterization
- Generates high-resolution trajectory points

**Waypoint Management**
```matlab
pos_xy = [shape{1,1}(1,:); shape{1,2}(1,:)]; % Extract waypoints
t = [0:numel(pos_xy)/2-1];  % Time vector
```
- Extracts waypoints from imported shape data
- Creates time-parameterized trajectory
- Supports variable waypoint spacing
- Handles both open and closed path configurations

**Kinematic Analysis**
The script performs comprehensive kinematic analysis:
```matlab
vx2 = [0 diff(x2)];  % X-velocity profile
vy2 = [0 diff(y2)];  % Y-velocity profile
ax2 = [0 diff(vx2)]; % X-acceleration profile
ay2 = [0 diff(vy2)]; % Y-acceleration profile
```
- Computes velocity profiles using numerical differentiation
- Calculates acceleration profiles for motion analysis
- Provides separate X and Y component analysis
- Enables dynamic feasibility assessment

#### Animation System

**Real-Time Trajectory Animation**
```matlab
for i = 2:length(x2)
    set(unicycle, 'XData', x2(i), 'YData', y2(i));
    drawnow;
    pause((t2t(i)-t2t(i-1))/100);
    exportgraphics(gcf,'testAnimated.gif','Append',true);
end
```
- Animates mobile robot following the generated trajectory
- Real-time visualization with configurable speed
- Automatic GIF generation for documentation
- Smooth motion interpolation between waypoints

**Visualization Features**
- **Multi-Figure Layout**: Separate plots for position, velocity, and acceleration
- **Trajectory Overlay**: Shows complete path with waypoint markers
- **Real-Time Updates**: Dynamic robot position updates
- **Export Capabilities**: Automatic GIF generation for presentations

#### Advanced Features
- **Wheeled Mobile Robot (WMR) Modeling**: Specialized for differential drive robots
- **Time Optimization**: Configurable trajectory timing
- **Multi-Axis Analysis**: Separate X/Y component visualization
- **Export Integration**: Direct GIF output for documentation

### enum_nodes.m - Node Enumeration Utility

The `enum_nodes.m` function provides sophisticated node enumeration and duplicate removal for finite element mesh generation.

#### Function Signature
```matlab
function [xvert, yvert, elem] = enum_nodes(nodi_x, nodi_y, elem_x, elem_y, elem)
```

#### Core Algorithm

**Unique Node Detection**
```matlab
linee_x = uniquetol(nodi_x);  % Unique X coordinates (ascending)
linee_y = fliplr(uniquetol(nodi_y));  % Unique Y coordinates (descending)
```
- Uses tolerance-based uniqueness detection (`uniquetol`)
- Handles floating-point precision issues
- Maintains coordinate ordering for consistent numbering
- Supports both X and Y coordinate processing

**Duplicate Node Elimination**
The algorithm implements sophisticated duplicate detection:
```matlab
if find(ismember(nodi_unici,[find(ind_pos_x==1) find(ind_pos_y==1)],'rows'))
    % Reuse existing node index
    count_nodi_unici(end+1) = count_nodi_unici(index(1));
    count_nodi_globali = count_nodi_globali - 1;
else
    % Create new node
    count_nodi_unici(end+1) = count_nodi_globali;
    xvert(end+1) = linee_x(ind_pos_x);
    yvert(end+1) = linee_y(ind_pos_y);
end
```
- Identifies nodes with identical coordinates within tolerance
- Maintains consistent node numbering across elements
- Reduces memory usage by eliminating redundant nodes
- Updates element connectivity arrays automatically

**Element Connectivity Management**
```matlab
elem{s,:}(1,k) = count_nodi_unici(end);  % Update element connectivity
```
- Updates element-to-node connectivity arrays
- Maintains referential integrity after node merging
- Supports variable element sizes and shapes
- Preserves topological relationships

#### Performance Optimizations
- **Tolerance-Based Comparison**: Handles floating-point precision issues
- **Memory Efficient**: Eliminates duplicate coordinate storage
- **Vectorized Operations**: Uses MATLAB's optimized array operations
- **Incremental Processing**: Processes elements sequentially for memory efficiency

#### Output Data Structures
- **`xvert, yvert`**: Arrays of unique node coordinates
- **`elem`**: Updated element connectivity arrays with correct node indices
- **Consistent Numbering**: Global node numbering system for FEM analysis

### Integration Workflow

The three MATLAB scripts work together in a coordinated workflow:

1. **Data Import**: `import_grid.m` processes CSV files from the web application
2. **Mesh Generation**: Creates finite element mesh with proper node enumeration
3. **Node Processing**: `enum_nodes.m` eliminates duplicates and creates connectivity
4. **Visualization**: Displays normalized grids and finite element meshes
5. **Path Planning**: `pathplanning.m` generates trajectories for mobile robot applications
6. **Animation**: Creates animated visualizations and exports documentation

### Sample Data Files

The system includes sample CSV files in the `shapes_csv/` directory:
- **`star.csv`**: Complex star-shaped geometry for testing
- **`shield.csv`**: Shield-shaped pattern for validation
- **`path1.csv`, `path2.csv`**: Simple path configurations
- **`random.csv`**: Random shape for algorithm testing

### Applications

The MATLAB integration enables various computational applications:
- **Finite Element Analysis**: Grid generation for FEM simulations
- **Virtual Element Methods**: Mesh creation for VEM algorithms
- **Path Planning**: Mobile robot trajectory optimization
- **Computational Geometry**: Shape analysis and processing
- **Educational Tools**: Visualization for teaching computational methods

---

*This project represents a specialized tool for computational geometry and grid-based analysis, bridging the gap between interactive web interfaces and scientific computing environments.*


