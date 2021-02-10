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




  Structures_to_plot={'Left Thalamus' 'Left Caudate' 'Right Caudate' 'Left Putamen' 'Right Putamen' 'Left Pallidum' 'Right Pallidum' 'Left Hippocampus' 'Right Hippocampus' 'Left Amygdala' 'Right Amygdala' 'Left Accumbens' 'Right Accumbens'};
  tvalues=[-5.97125866792027,-4.11582907905479,-3.42493672830627,-8.01496535810251,-13.7953634061516,-4.89327985932994,-6.19823708319729,-6.82566971364392,-4.38040426080035,-14.306754328615,-14.683211583332,-10.9330880979464,-12.1057244108749]; 


%% Define structures to plot and plot them
Image=Atlas;
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));

for i=1:length(Structures_to_plot)
        Image.img(find(Atlas.img==find(contains(Dictionary,Structures_to_plot{i}))))=tvalues(i);
end

save_nii(Image,'Subcortical_BMI.nii')

%% Subcortical volumes and WHR




Structures_to_plot={'Left Thalamus' 'Left Putamen' 'Right Putamen' 'Left Hippocampus' 'Right Hippocampus' 'Left Amygdala' 'Right Amygdala' 'Left Accumbens' 'Right Accumbens'};
tvalues=[-4.34158978871949,-4.88984290375677,-9.03376520277201,-4.17134545735239,-2.82851274067252,-9.95445446682708,-10.2112973398368,-7.79461109139541,-8.97794904857457]; 

%% Define structures to plot and plot them
Image=Atlas;
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));

for i=1:length(Structures_to_plot)
        Image.img(find(Atlas.img==find(contains(Dictionary,Structures_to_plot{i}))))=tvalues(i);
end

save_nii(Image,'Subcortical_WHR.nii')

%% Subcortical volumes and BFP




Structures_to_plot={'Left Thalamus' 'Left Caudate' 'Right Caudate' 'Left Putamen' 'Right Putamen' 'Left Pallidum' 'Right Pallidum' 'Left Hippocampus' 'Right Hippocampus' 'Left Amygdala' 'Right Amygdala' 'Left Accumbens' 'Right Accumbens'};
tvalues=[-5.7700457888,-4.42904010373439,-3.18276627381421,-5.87455402323413,-10.6660640313263,-4.39882391521171,-5.31774643280559,-6.08540540192873,-3.95271031936899,-9.91680083675534,-10.097120758436,-7.73512183116917,-8.60228985827898]; 

%% Define structures to plot and plot them
Image=Atlas;
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));

for i=1:length(Structures_to_plot)
        Image.img(find(Atlas.img==find(contains(Dictionary,Structures_to_plot{i}))))=tvalues(i);
end

save_nii(Image,'Subcortical_BFP.nii')




























