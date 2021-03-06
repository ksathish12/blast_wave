#!/bin/sh

# Quit script if any step has error:
set -e

# Make the mesh:
gmsh -3 -o main.msh mesh/main.geo
# Convert the mesh to OpenFOAM format:
gmshToFoam main.msh -case case
# Adjust polyMesh/boundary:
changeDictionary -case case
# Let's set the initial conditions (high-pressure blast source)
# First, let's load original p file.
cp case/0/p.original case/0/p
setFields -case case
# Finally, run the simulation:
sonicFoam -case case

