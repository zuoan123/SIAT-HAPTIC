function [ energy,entropy,correlation,homogeneity,contrast] = glcm( I )
%function [ feature_vector , glcm] = HaralickFeatures( I )
%   Calculate the feature vector based on the texture features defined in
%   Haralick et al. 1979.

%   Detailed explanation goes here
%   I is an imput image, 2D
%   The feature vectors are calculated from an average glcm of the four
%   directions with a distance metric of 1.
I=rgb2gray(I);
feature_vector = zeros(19,1);
% Many of the images will have a large gap in gray levels between 0 and the
% next highest gray level.  0 means background, unimportant to the image,
% so it is set to NaN, which will not be considered by graycomatrix().
% Then, I set the next highest gray level to 1, to make the glcm as small
% as possible.

minNg = min(I(I>0));
I(I==0) = NaN;
I(I>0)= I(I>0)-(minNg-1);
maxNg = max(max(I));

[glcm_0] = graycomatrix(I, 'Offset', [0 1], 'NumLevels', maxNg, 'G', [], 'Symmetric', true);
[glcm_45] = graycomatrix(I, 'Offset', [-1 1], 'NumLevels',  maxNg, 'G', [], 'Symmetric', true);
[glcm_90] = graycomatrix(I, 'Offset', [-1 0], 'NumLevels',  maxNg, 'G', [], 'Symmetric', true);
[glcm_135] = graycomatrix(I, 'Offset', [-1 -1], 'NumLevels',  maxNg, 'G', [], 'Symmetric', true);

glcm(:,:,1) = glcm_0(:,:);
glcm(:,:,2) = glcm_45(:,:);
glcm(:,:,3) = glcm_90(:,:);
glcm(:,:,4) = glcm_135(:,:);

% Haralick, et al. says that the glcm used for analysis should be an
% average of the four angles.
glcm = squeeze(mean(glcm,3));
Ng = size(glcm,1);

p_x = zeros(Ng,1);
p_y = zeros(Ng,1);
p_xplusy = zeros((Ng*2),1);
p_xminusy = zeros(Ng,1);

% Normalize the glcm to 1 to make them probabilities
glcm_sum = sum(sum(glcm(:,:)));
glcm = glcm./glcm_sum;
disp('should be 1');
disp(sum(sum(glcm(:,:))));

% Compute marginal probabilities
for ii = 1:Ng
    for jj = 1:Ng
        p_x(ii) = p_x(ii) + glcm(ii,jj);
        p_y(ii) = p_y(ii) + glcm(jj,ii);
        p_xplusy((ii+jj)) = p_xplusy((ii+jj)) + glcm(ii,jj);
        p_xminusy((abs(ii-jj))+1) = p_xminusy((abs(ii-jj))+1)+glcm(ii,jj);
    end
end
feature_vector(1,1)= compute_energy(glcm);
energy=feature_vector(1,1);
feature_vector(2,1) = compute_entropy(glcm);
entropy=feature_vector(2,1);
feature_vector(3,1) = compute_dissimilarity(glcm);
feature_vector(4,1) = compute_contrast(glcm);
contrast=feature_vector(4,1);
feature_vector(5,1) = compute_invDiff(glcm);
feature_vector(6,1) = compute_correlation(glcm);
correlation=feature_vector(6,1);
feature_vector(7,1) = compute_homogeneity(glcm);
homogeneity=feature_vector(7,1);
feature_vector(8,1) = compute_autocorr(glcm);
feature_vector(9,1) = compute_clusterShade(glcm);
feature_vector(10,1) = compute_clusterProm(glcm);
feature_vector(11,1) = compute_maxProb(glcm);
feature_vector(12,1) = compute_sumOfSquares(glcm);
feature_vector(13,1) = compute_sumAverage(p_xplusy);
feature_vector(14,1) =  compute_sumVariance(p_xplusy);
feature_vector(15,1) = compute_sumEntropy(p_xplusy);
feature_vector(16,1) = compute_diffVarience(p_xminusy);
feature_vector(17,1) = compute_diffEntropy(p_xminusy);
[out, out2] = compute_informationMeasures(glcm);
feature_vector(18,1) = out;
feature_vector(19,1) = out2;

function [energy] = compute_energy(glcm)
energy = sum(sum(glcm.^2));

function [entropy] = compute_entropy(glcm)
eps = 0.000001;
entropy = -sum(sum((glcm.*log10(glcm+eps))));

function [dissimilarity] = compute_dissimilarity(glcm)
Ng = size(glcm,1);
i_matrix = repmat([1:Ng]',1,Ng);
j_matrix = repmat(1:Ng,Ng,1);
mul_dissi = abs(i_matrix - j_matrix);
dissimilarity = sum(sum(mul_dissi.*glcm));

function [contrast] = compute_contrast(glcm)
Ng = size(glcm,1);
i_matrix = repmat([1:Ng]',1,Ng);
j_matrix = repmat([1:Ng],Ng,1);
mul_contr = abs(i_matrix - j_matrix).^2;
contrast = sum(sum(mul_contr.*glcm));

function [invDiff] = compute_invDiff(glcm)
%inverse difference normalized
Ng = size(glcm,1);
i_matrix = repmat([1:Ng]',1,Ng);
j_matrix = repmat([1:Ng],Ng,1);
mul_dissi = abs(i_matrix - j_matrix);
invDiff = sum(sum(glcm./(1 + mul_dissi./Ng)));

function [correlation] = compute_correlation(glcm)
Ng = size(glcm,1);
i_matrix = repmat([1:Ng]',1,Ng);
j_matrix = repmat([1:Ng],Ng,1);
cor = sum(sum(i_matrix.*j_matrix.*glcm));
mean_x= sum(sum(i_matrix.*glcm)); 
mean_y= sum(sum(j_matrix.*glcm)); 
s_x = sum(sum(((i_matrix - mean_x).^2.*glcm)))^.5;
s_y = sum(sum(((j_matrix - mean_y).^2.*glcm)))^.5;
correlation = (cor -mean_x*mean_y)/(s_x*s_y);

function [homogeneity] = compute_homogeneity(glcm)
%inverse difference moment normilized
Ng = size(glcm,1);
i_matrix = repmat([1:Ng]',1,Ng);
j_matrix = repmat([1:Ng],Ng,1);
mul_contr = (i_matrix - j_matrix).^2;
homogeneity = sum(sum(glcm./(1+ mul_contr)));

function [autocorrelation] = compute_autocorr(glcm)
Ng = size(glcm,1);
i_matrix = repmat([1:Ng]',1,Ng);
j_matrix = repmat([1:Ng],Ng,1);
autocorrelation = sum(sum(i_matrix.*j_matrix.*glcm));

function [cluster_shade] = compute_clusterShade(glcm)
Ng = size(glcm,1);
i_matrix = repmat([1:Ng]',1,Ng);
j_matrix = repmat([1:Ng],Ng,1);
mean_x= sum(sum(i_matrix.*glcm)); 
mean_y= sum(sum(j_matrix.*glcm));
cluster_shade = sum(sum(((i_matrix + j_matrix - mean_x - mean_y).^3).*glcm));

function [ cluster_prominence] = compute_clusterProm(glcm)
Ng = size(glcm,1);
i_matrix = repmat([1:Ng]',1,Ng);
j_matrix = repmat([1:Ng],Ng,1);
mean_x= sum(sum(i_matrix.*glcm)); 
mean_y= sum(sum(j_matrix.*glcm));
cluster_prominence = sum(sum(((i_matrix + j_matrix - mean_x - mean_y).^4).*glcm));

function [max_prob] = compute_maxProb(glcm)
max_prob = max(max(glcm));

function [sumOfSquares] = compute_sumOfSquares(glcm)
Ng = size(glcm,1);
i_matrix = repmat([1:Ng]',1,Ng);
mean_x= sum(sum(i_matrix.*glcm));
sumOfSquares = sum(sum(glcm.*(i_matrix - mean_x).^2));

function [sumAverage] = compute_sumAverage(p_xplusy)
Ng = size(p_xplusy,1);
ii = [2:Ng+1]';
sumAverage = sum(ii.*p_xplusy);

function [sumVariance] = compute_sumVariance(p_xplusy)
Ng = size(p_xplusy,1);
ii = [2:Ng+1]'; eps = 0.00000001;
sumEntropy = -sum(p_xplusy+ log(p_xplusy+eps));
sumVariance = sum( (ii-sumEntropy).^2 .*p_xplusy);

function [sumEntropy] = compute_sumEntropy(p_xplusy)
Ng = size(p_xplusy,1);
ii = [2:Ng+1]'; eps = 0.00000001;
sumEntropy = -sum(p_xplusy+ log(p_xplusy+eps));

function[diffVarience] = compute_diffVarience(p_xminusy)
Ng = size(p_xminusy,1);
ii = [2:Ng+1]';
diffVarience = sum((ii.^2).*p_xminusy);

function [diffEntropy] = compute_diffEntropy(p_xminusy)
diffEntropy = sum(p_xminusy.*log(p_xminusy+eps));

function [inf1, inf2] = compute_informationMeasures(glcm)
eps = 0.00001;
px= sum(glcm,2);
py = sum(glcm,1);
HX = -sum(px.*log(px+eps));
HY = - sum(py.*log(py+eps));
HXY1 = - sum(sum(glcm.*[log(px*py+eps)]));
HXY2 = - sum(sum(px*py.*log(px*py+eps)));
HXY = -sum(sum(glcm.*log(glcm+eps)));

inf1 = (HXY-HXY1)/max([HX, HY]);
inf2 = (1- exp(-2.0*(HXY2-HXY)))^0.5;