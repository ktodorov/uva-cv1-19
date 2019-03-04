function [] = plot_keypoints_subset(I, J, matches, scores, f_I, f_J, samples)
%PLOT_KEYPOINTS_SUBSET Summary of this function goes here
%   Detailed explanation goes here

%% Convert image in the appropriate format 
I_raw = I;
J_raw = J;

% Grayscale -- incase that they are not
[~, ~, c] = size(I);
if c ~= 1
    I = rgb2gray(I);
end

[~, ~, c] = size(J);
if c ~= 1
    J = rgb2gray(J);
end

% Single
I = single(I) ;
J = single(J) ;

%% We will take a subset of matches and scores
% i) Generate 10 random numbers - indexes
[~, columns] = size(scores);
r = randi([1 columns],1,samples);

% ii) Get the subset using this indexes
% -- in this way, we can get the corresponding scores as well
sub_matches = zeros(2, samples);
sub_scores = zeros(samples);
for i = 1:samples
    sub_matches(:, i) = matches(:, r(i));
    sub_scores(i) = scores(r(i));
end

% iii) Plot on the figure of the two images
figure ; hold off;
imshow(cat(2, I_raw, J_raw) );
hold on ;

% Get the axes
xa = f_I(1,sub_matches(1,:)) ;
xb = f_J(1,sub_matches(2,:)) + size(I,2) ;
ya = f_I(2,sub_matches(1,:)) ;
yb = f_J(2,sub_matches(2,:)) ;

% Get the random color -- every color is a 3x1 array
random_color = zeros(3, samples);
for i=1:samples
    random_color(:, i) = abs(rand(1,3));
end

% Connecting matching pairs with lines where each line has a random color
h = line([xa ; xb], [ya ; yb]) ;
for i=1:samples
    set(h(i),'linewidth', 1.5, 'color', random_color(:,i)) ;
end

vl_plotframe(f_I(:,sub_matches(1,:))) ;
set(vl_plotframe(f_I(:,sub_matches(1,:))), 'color', 'y')
f_J(1,:) = f_J(1,:) + size(I,2) ;
vl_plotframe(f_J(:,sub_matches(2,:))) ;
set(vl_plotframe(f_J(:,sub_matches(2,:))), 'color', 'y')
axis image off ;
end

