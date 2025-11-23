#!/bin/bash
nprocs=6
foamDictionary system/decomposeParDict -entry numberOfSubdomains -set $nprocs

foamCleanTutorials
touch foam.foam

#rm -rf 0 > /dev/null 2>&1
#cp -r 0_species_DNS 0  > /dev/null 2>&1

cd /home/fs/OpenFOAM/cryo2 && cp -r polyMesh ./constant/
	#cp -r /mmfs1/gscratch/stf/fspencer/openfoam-home/cyl_L0.09_inl0.01_poly0.001/ ./constant/polyMesh/
	#cp -r ../polyMesh_course/ ./constant/polyMesh/
	#cp -r ../polyMesh/ ./constant

	#blockMesh | tee log.blockMesh
#topoSet
	#createPatch -overwrite

	#checkMesh | tee log.checkMesh
	#checkMesh -allTopology -allGeometry

setFields -dict system/setFieldsDict | tee log.setFields

decomposePar
	#mpirun -oversubscribe -np $nprocs renumberMesh -parallel -overwrite | tee log.renumber

	#renumberMesh -overwrite -noFunctionObjects | tee log.renumbermesh

mpirun -oversubscribe -np $nprocs foamRun -parallel | tee log.solver
	#foamRun  | tee log.solver

	#reconstructPar
	#mpirun -np $nprocs postProcess -func writeCellVolumes -parallel

#reconstructPar -latestTime

#foamPostProcess -func writeCellVolumes -latestTime


