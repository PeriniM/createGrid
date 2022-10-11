https://perinim.github.io/createGrid/
# What is it?
createGrid() is a one-page application that lets you create elements with vertices fixed on a squared grid. You can export shapes in a single CSV file for further manipulation with third-party app.

# Why?
To quickly generate grid elements which can be used for repetitive patterns. Main applications can be found on the analysis of new grids for Finite Element Methods (FEM) or Virtual Element Methods (VEM) algorithms. 

# Overview
User Interface where you can add closed shapes on a grid.
![overviewgrid](img_readme/overview_grid_star.PNG?raw=true "Overview Grid" )

The elements can be exported as a CSV file, which can then be used in third-party software, such as Matlab, to create new types of grid. In the matlab folder you will find a script to normalize and create the grid.
![matlabplot](img_readme/matlab_overview_star.PNG?raw=true "Matlab Grid")

Shapes can be plot on matlab, normalizing the coordinates and displaying the enumeration of the elements.
![stargrid](img_readme/grid_star.PNG?raw=true "Star Grid")

Also the properties of the grid can be adjusted, such as height, width, number of suddivisions etc., and the shapes will adjust accordingly. Right now the algorithm work well with square grids but can be adjusted to work also for rect grids.
![stargridrect](img_readme/star_rect_grid.PNG?raw=true "Star Rect Grid")

# Roadmap
#### UI changes
- [x] Add Download CSV button
- [ ] Add options on Download CSV menu to customize the download (normalized coordinates, colors export, grid info etc)
- [ ] Add camera to rotate the grid in 3D
- [ ] Add XML export
- [ ] Add floating window for modifying some grid parameters
#### Objects changes
- [ ] Change grid subdivisions
- [ ] Add to grid object the angle of creation (you can have multiple planes to create 3d objects)
- [ ] Select each element and give possibility to move existing vertices
- [ ] Add patches to fill up gaps between shapes

