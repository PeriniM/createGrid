https://perinim.github.io/createGrid/
# What is it?
createGrid() is a one-page application that lets you create elements with vertices fixed on a squared grid. You can export the whole grid in one svg file or just separated elements. You could also export the vertices of each element as an array.

# Why?
To quickly generate grid elements which can be used for repetitive patterns. Main applications can be found on the analysis of new grids for Finite Element Methods (FEM) or Virtual Element Methods (VEM) algorithms. 

# Overview
User Interface where you can add closed shapes on a grid.
![overviewgrid](img_readme/overview_grid.PNG?raw=true "Overview Grid")

The elements can be exported as a CSV file, which can then be used in third-party software, such as Matlab, to create new types of grid.
![matlabplot](img_readme/matlab_plot.JPG?raw=true "Matlab Plot")

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
