%{ 

v%%% Script to plot subcortical volumes with T-values %%%
    
1. Load an atlas image from '/dagher/dagher11/filip/Atlases/fsl/data/atlases/HarvardOxford/HarvardOxford-sub-maxprob-thr50-1mm.nii'
2. Get separate masks by extracting indices corresponding to specified
subcortical structures. The following is a dictionary:

index="0" x="58" y="37" z="50">     Left Cerebral White Matter
index="1" x="70" y="63" z="35">     Left Cerebral Cortex 
index="2" x="57" y="40" z="41">     Left Lateral Ventricle
index="3" x="51" y="51" z="39">     Left Thalamus
index="4" x="51" y="71" z="38">     Left Caudate
index="5" x="56" y="67" z="34">     Left Putamen
index="6" x="54" y="62" z="35">     Left Pallidum
index="7" x="44" y="49" z="18">     Brain-Stem
index="8" x="59" y="54" z="27">     Left Hippocampus
index="9" x="57" y="61" z="27">     Left Amygdala
index="10" x="50" y="70" z="33">    Left Accumbens
index="11" x="29" y="38" z="51">    Right Cerebral White Matter
index="12" x="25" y="42" z="61">    Right Cerebral Cortex 
index="13" x="35" y="45" z="44">    Right Lateral Ventricle
index="14" x="38" y="51" z="39">    Right Thalamus
index="15" x="39" y="72" z="37">    Right Caudate
index="16" x="34" y="68" z="34">    Right Putamen
index="17" x="35" y="61" z="35">    Right Pallidum
index="18" x="31" y="57" z="25">    Right Hippocampus
index="19" x="32" y="63" z="25">    Right Amygdala
index="20" x="40" y="69" z="32">    Right Accumbens


3. Save resulting file as a nifti
4. Plot and enjoy

%}

clear all
close all
addpath(genpath('/dagher/dagher11/filip/Software/MATAB_nifti/'))
%% Load atlas files and create a dictionary


Atlas=load_nii('/dagher/dagher11/filip/Atlases/fsl/data/atlases/HarvardOxford/HarvardOxford-sub-maxprob-thr50-1mm.nii');

Dictionary={'Left Cerebral White Matter','Left Cerebral Cortex','Left Lateral Ventricle','Left Thalamus','Left Caudate','Left Putamen','Left Pallidum','Brain-Stem',...
    'Left Hippocampus','Left Amygdala','Left Accumbens','Right Cerebral White Matter','Right Cerebral Cortex','Right Lateral Ventricle','Right Thalamus',...
    'Right Caudate','Right Putamen','Right Pallidum','Right Hippocampus','Right Amygdala','Right Accumbens'};
Dictionary=Dictionary';

%% Get structures to plot and t-values - in the future make it automatic

  Structures_to_plot={ 'Left Amygdala' 'Right Amygdala' ,'Left Accumbens'};
  tvalues=[0.052, 0.048, 0.022]; 


%% Define structures to plot and plot them
Image=Atlas;
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));

for i=1:length(Structures_to_plot)
        Image.img(find(Atlas.img==find(contains(Dictionary,Structures_to_plot{i}))))=tvalues(i);
end

save_nii(Image,'Subcortical_mediation_BMI.nii')

%% Subcortical volumes and WHR

Structures_to_plot={'Left Amygdala' 'Right Amygdala' ,'Left Accumbens'};
  tvalues=[0.076, 0.069, 0.034]; 
  
%% Define structures to plot and plot them
Image=Atlas;
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));

for i=1:length(Structures_to_plot)
        Image.img(find(Atlas.img==find(contains(Dictionary,Structures_to_plot{i}))))=tvalues(i);
end

save_nii(Image,'Subcortical_mediation_WHR.nii')

%% Subcortical volumes and BFP

Structures_to_plot={ 'Left Amygdala' 'Right Amygdala' ,'Left Accumbens'};
tvalues=[0.068, 0.062, 0.033]; 

%% Define structures to plot and plot them
Image=Atlas;
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));

for i=1:length(Structures_to_plot)
        Image.img(find(Atlas.img==find(contains(Dictionary,Structures_to_plot{i}))))=tvalues(i);
end

save_nii(Image,'Subcortical_mediation_BFP.nii')




























, 