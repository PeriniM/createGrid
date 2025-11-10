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

---

*This project represents a specialized tool for computational geometry and grid-based analysis, bridging the gap between interactive web interfaces and scientific computing environments.*
