#~/bin/bash
#You don’t “submit” this; run interactive – it submits your jobs
for FOLDER_NAME in Case0 Case1 Case2 Case3 Case4 Case5 Case6
  do
    cd /home/fay750/B_SRB_MESH/F010_bow_scalingPBSM/${FOLDER_NAME}
    rm -r /home/fay750/B_SRB_MESH/F010_bow_scalingPBSM/${FOLDER_NAME}/${FOLDER_NAME}_*
    rm /home/fay750/B_SRB_MESH/F010_bow_scalingPBSM/${FOLDER_NAME}/*.ini
    rm /home/fay750/B_SRB_MESH/F010_bow_scalingPBSM/${FOLDER_NAME}/*.txt
    rm /home/fay750/B_SRB_MESH/F010_bow_scalingPBSM/${FOLDER_NAME}/*.r2c
done

