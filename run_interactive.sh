#~/bin/bash
#You don’t “submit” this; run interactive – it submits your jobs r8i2p1r1 

for FOLDER_NAME in Case0 Case1 Case2 Case3 Case4 Case5 Case6
  do
    rm /home/fay750/B_SRB_MESH/F010_bow_scalingBlowingPBSM/${FOLDER_NAME}/*.ini 
    rm /home/fay750/B_SRB_MESH/F010_bow_scalingBlowingPBSM/${FOLDER_NAME}/*.txt 
    rm /home/fay750/B_SRB_MESH/F010_bow_scalingBlowingPBSM/${FOLDER_NAME}/*.r2c   
    rm /home/fay750/B_SRB_MESH/F010_bow_scalingBlowingPBSM/${FOLDER_NAME}/BASINAVG1/*
    #rm -r /home/fay750/B_SRB_MESH/F010_bow_scalingBlowingPBSM/${FOLDER_NAME}/${FOLDER_NAME}_*
    #sbatch /home/fay750/B_SRB_MESH/F010_bow_scalingBlowingPBSM/${FOLDER_NAME}/${FOLDER_NAME}.pbs $FOLDER_NAME
done
