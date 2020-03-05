%{ 

v%%% Script to plot subcortical volumes with T-values %%%
    
1. Load an atlas image from '/dagher/dagher11/filip/Atlases/fsl/data/atlases/HarvardOxford/HarvardOxford-sub-maxprob-thr50-1mm.nii'
2. Get separate masks by extracting indices corresponding to specified
subcortical structures. The following is a dictionary:

<label index="0" x="0" y="0" z="0">Unclassified</label>
<label index="1" x="69" y="83" z="36">Middle cerebellar peduncle</label>
<label index="2" x="89" y="97" z="40">Pontine crossing tract (a part of MCP)</label>
<label index="3" x="93" y="152" z="77">Genu of corpus callosum</label>
<label index="4" x="95" y="100" z="97">Body of corpus callosum</label>
<label index="5" x="85" y="89" z="88">Splenium of corpus callosum</label>
<label index="6" x="89" y="116" z="88">Fornix (column and body of fornix)</label>
<label index="7" x="82" y="103" z="43">Corticospinal tract R</label>
<label index="8" x="97" y="103" z="43">Corticospinal tract L</label>
<label index="9" x="84" y="89" z="40">Medial lemniscus R</label>
<label index="10" x="95" y="89" z="40">Medial lemniscus L</label>
<label index="11" x="83" y="83" z="20">Inferior cerebellar peduncle R  </label>
<label index="12" x="96" y="83" z="20">Inferior cerebellar peduncle L</label>
<label index="13" x="84" y="93" z="53">Superior cerebellar peduncle R</label>
<label index="14" x="95" y="93" z="53">Superior cerebellar peduncle L</label>
<label index="15" x="75" y="107" z="60">Cerebral peduncle R</label>
<label index="16" x="104" y="107" z="60">Cerebral peduncle L</label>
<label index="17" x="75" y="129" z="79">Anterior limb of internal capsule R</label>
<label index="18" x="104" y="129" z="79">Anterior limb of internal capsule L</label>
<label index="19" x="66" y="108" z="85">Posterior limb of internal capsule R</label>
<label index="20" x="113" y="108" z="85">Posterior limb of internal capsule L</label>
<label index="21" x="61" y="101" z="78">Retrolenticular part of internal capsule R</label>
<label index="22" x="117" y="101" z="78">Retrolenticular part of internal capsule L</label>
<label index="23" x="69" y="163" z="73">Anterior corona radiata R</label>
<label index="24" x="110" y="163" z="73">Anterior corona radiata L</label>
<label index="25" x="63" y="109" z="96">Superior corona radiata R</label>
<label index="26" x="116" y="109" z="96">Superior corona radiata L</label>
<label index="27" x="64" y="99" z="99">Posterior corona radiata R</label>
<label index="28" x="115" y="99" z="99">Posterior corona radiata L</label>
<label index="29" x="57" y="64" z="73">Posterior thalamic radiation (include optic radiation) R</label>
<label index="30" x="122" y="64" z="73">Posterior thalamic radiation (include optic radiation) L</label>
<label index="31" x="48" y="97" z="60">Sagittal stratum (include inferior longitidinal fasciculus and inferior fronto-occipital fasciculus) R</label>
<label index="32" x="131" y="97" z="60">Sagittal stratum (include inferior longitidinal fasciculus and inferior fronto-occipital fasciculus) L</label>
<label index="33" x="58" y="131" z="64">External capsule R</label>
<label index="34" x="121" y="131" z="64">External capsule L</label>
<label index="35" x="83" y="132" z="105">Cingulum (cingulate gyrus) R</label>
<label index="36" x="97" y="110" z="108">Cingulum (cingulate gyrus) L</label>
<label index="37" x="66" y="101" z="53">Cingulum (hippocampus) R</label>
<label index="38" x="112" y="99" z="54">Cingulum (hippocampus) L</label>
<label index="39" x="62" y="100" z="66">Fornix (cres) / Stria terminalis (can not be resolved with current resolution) R</label>
<label index="40" x="117" y="100" z="66">Fornix (cres) / Stria terminalis (can not be resolved with current resolution) L</label>
<label index="41" x="53" y="103" z="102">Superior longitudinal fasciculus R</label>
<label index="42" x="126" y="103" z="102">Superior longitudinal fasciculus L</label>
<label index="43" x="69" y="121" z="93">Superior fronto-occipital fasciculus (could be a part of anterior internal capsule) R</label>
<label index="44" x="110" y="121" z="93">Superior fronto-occipital fasciculus (could be a part of anterior internal capsule) L</label>
<label index="45" x="55" y="127" z="54">Uncinate fasciculus R</label>
<label index="46" x="123" y="125" z="58">Uncinate fasciculus L</label>
<label index="47" x="60" y="78" z="86">Tapetum R</label>
<label index="48" x="117" y="76" z="87">Tapetum L</label>
  </data>
</atlas>



3. Save resulting file as a nifti
4. Plot and enjoy

%}

clear all
close all
addpath(genpath('/dagher/dagher11/filip/Software/MATAB_nifti/'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%% WMH %%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load atlas file and dataset
Template=load_nii('/dagher/dagher11/filip/Atlases/fsl/data/atlases/HarvardOxford/HarvardOxford-sub-maxprob-thr50-1mm.nii');

opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "V3", "VarName4"];
opts.SelectedVariableNames = ["V3", "VarName4"];
opts.VariableTypes = ["string", "string", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2"], "EmptyFieldRule", "auto");

% Import the data
WMHFA = readtable("/dagher/dagher11/filip/OBAL/output/WMH_FA.csv", opts);

WMHFA = table2array(WMHFA);

clear opts

%% Define structures to plot and plot them
Image=Template;
Atlas=load_nii('/usr/share/fsl/data/atlases/JHU/JHU-ICBM-labels-1mm.nii.gz');
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));


for i=1:length(WMHFA)/2 %Only for FA, the second half is MD
    if WMHFA(i,1)<0.05
        Image.img(find(Atlas.img==i))=WMHFA(i,2);
    end
end

save_nii(Image,'WMH_FA.nii')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BMI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "V3", "VarName4"];
opts.SelectedVariableNames = ["V3", "VarName4"];
opts.VariableTypes = ["string", "string", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2"], "EmptyFieldRule", "auto");

% Import the data
WMHFA = readtable("/dagher/dagher11/filip/OBAL/output/BMI_FA.csv", opts);

WMHFA = table2array(WMHFA);

clear opts

%% Define structures to plot and plot them
Image=Template;
Atlas=load_nii('/usr/share/fsl/data/atlases/JHU/JHU-ICBM-labels-1mm.nii.gz');
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));


for i=1:length(WMHFA)/2 %Only for FA, the second half is MD
    if WMHFA(i,1)<0.05
        Image.img(find(Atlas.img==i))=WMHFA(i,2);
    end
end

save_nii(Image,'BMI_FA.nii')


%%%%%%%%%%%%%%%%%%%%%%%% WHR %%%%%%%%%%%%%%%%%%%%%%%%%%%%

opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "V3", "VarName4"];
opts.SelectedVariableNames = ["V3", "VarName4"];
opts.VariableTypes = ["string", "string", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2"], "EmptyFieldRule", "auto");

% Import the data
WMHFA = readtable("/dagher/dagher11/filip/OBAL/output/WHR_FA.csv", opts);

WMHFA = table2array(WMHFA);

clear opts

%% Define structures to plot and plot them
Image=Template;
Atlas=load_nii('/usr/share/fsl/data/atlases/JHU/JHU-ICBM-labels-1mm.nii.gz');
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));


for i=1:length(WMHFA)/2 %Only for FA, the second half is MD
    if WMHFA(i,1)<0.05
        Image.img(find(Atlas.img==i))=WMHFA(i,2);
    end
end

save_nii(Image,'WHR_FA.nii')

%%%%%%%%%%%%%%%%%%%%%%%% VAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%

opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "V3", "VarName4"];
opts.SelectedVariableNames = ["V3", "VarName4"];
opts.VariableTypes = ["string", "string", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2"], "EmptyFieldRule", "auto");

% Import the data
WMHFA = readtable("/dagher/dagher11/filip/OBAL/output/VAT_FA.csv", opts);

WMHFA = table2array(WMHFA);

clear opts

%% Define structures to plot and plot them
Image=Template;
Atlas=load_nii('/usr/share/fsl/data/atlases/JHU/JHU-ICBM-labels-1mm.nii.gz');
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));


for i=1:length(WMHFA)/2 %Only for FA, the second half is MD
    if WMHFA(i,1)<0.05
        Image.img(find(Atlas.img==i))=WMHFA(i,2);
    end
end

save_nii(Image,'VAT_FA.nii')

%%%%%%%%%%%%%%%%%%%%%%%%%%%% WMH %%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load atlas file and dataset
Template=load_nii('/dagher/dagher11/filip/Atlases/fsl/data/atlases/HarvardOxford/HarvardOxford-sub-maxprob-thr50-1mm.nii');

opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "V3", "VarName4"];
opts.SelectedVariableNames = ["V3", "VarName4"];
opts.VariableTypes = ["string", "string", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2"], "EmptyFieldRule", "auto");

% Import the data
WMHFA = readtable("/dagher/dagher11/filip/OBAL/output/WMH_FA.csv", opts);

WMHFA = table2array(WMHFA);

clear opts

%% Define structures to plot and plot them
Image=Template;
Atlas=load_nii('/usr/share/fsl/data/atlases/JHU/JHU-ICBM-labels-1mm.nii.gz');
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));


for i=49:length(WMHFA) %Only for MD
    if WMHFA(i,1)<0.05
        Image.img(find(Atlas.img==i-48))=WMHFA(i,2);
    end
end

save_nii(Image,'WMH_MD.nii')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BMI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "V3", "VarName4"];
opts.SelectedVariableNames = ["V3", "VarName4"];
opts.VariableTypes = ["string", "string", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2"], "EmptyFieldRule", "auto");

% Import the data
WMHFA = readtable("/dagher/dagher11/filip/OBAL/output/BMI_FA.csv", opts);

WMHFA = table2array(WMHFA);

clear opts

%% Define structures to plot and plot them
Image=Template;
Atlas=load_nii('/usr/share/fsl/data/atlases/JHU/JHU-ICBM-labels-1mm.nii.gz');
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));


for i=49:length(WMHFA) %Only for MD
    if WMHFA(i,1)<0.05
        Image.img(find(Atlas.img==i-48))=WMHFA(i,2);
    end
end

save_nii(Image,'BMI_MD.nii')


%%%%%%%%%%%%%%%%%%%%%%%% WHR %%%%%%%%%%%%%%%%%%%%%%%%%%%%

opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "V3", "VarName4"];
opts.SelectedVariableNames = ["V3", "VarName4"];
opts.VariableTypes = ["string", "string", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2"], "EmptyFieldRule", "auto");

% Import the data
WMHFA = readtable("/dagher/dagher11/filip/OBAL/output/WHR_FA.csv", opts);

WMHFA = table2array(WMHFA);

clear opts

%% Define structures to plot and plot them
Image=Template;
Atlas=load_nii('/usr/share/fsl/data/atlases/JHU/JHU-ICBM-labels-1mm.nii.gz');
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));


for i=49:length(WMHFA) %Only for MD
    if WMHFA(i,1)<0.05
        Image.img(find(Atlas.img==i-48))=WMHFA(i,2);
    end
end

save_nii(Image,'WHR_MD.nii')

%%%%%%%%%%%%%%%%%%%%%%%% VAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%

opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "V3", "VarName4"];
opts.SelectedVariableNames = ["V3", "VarName4"];
opts.VariableTypes = ["string", "string", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2"], "EmptyFieldRule", "auto");

% Import the data
WMHFA = readtable("/dagher/dagher11/filip/OBAL/output/VAT_FA.csv", opts);

WMHFA = table2array(WMHFA);

clear opts

%% Define structures to plot and plot them
Image=Template;
Atlas=load_nii('/usr/share/fsl/data/atlases/JHU/JHU-ICBM-labels-1mm.nii.gz');
Image.img=NaN(size(Atlas.img,1),size(Atlas.img,2),size(Atlas.img,3));


for i=49:length(WMHFA) %Only for MD
    if WMHFA(i,1)<0.05
        Image.img(find(Atlas.img==i-48))=WMHFA(i,2);
    end
end

save_nii(Image,'VAT_MD.nii')













