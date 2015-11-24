%%% Exercise 1
convolution_kernel = ones(3);
% For proper convolution, divide elementwise by 9
convolution_kernel = convolution_kernel ./ 9;
img.original = imread('lena.gif');
img.convoluted = convoluteImage(convolution_kernel, img.original, 'multiply');

figure('Name', 'Exercise 1');
colormap(gray(256)); 
subplot(1, 2, 1);
title('Original image');
image(img.original);
daspect([1 1 1]); % Keeps aspect ratio 1:1

subplot(1, 2, 2);
title('Convoluted image');
image(img.convoluted);
daspect([1 1 1]);
%%% End of Exercise 1

%%% Exercise 2
% Get 2D Gaussian filter for sigma = 1
gaussian_2D.sigma = 1;
gaussian_2D.mask_size = 3 * gaussian_2D.sigma;
gaussian_2D.mask = gaussian2D(gaussian_2D.mask_size, gaussian_2D.sigma);

% Count 2D gaussian convolution time when sigma is 1
tic;
img.gaussian_2D_sigma1 = convoluteImage(gaussian_2D.mask, img.original, 'multiply');
timings.gaussian_2D_sigma1 = toc;

% Get 2D Gaussian filter for sigma = 3
gaussian_2D.sigma = 3;
gaussian_2D.mask_size = 3 * gaussian_2D.sigma;
gaussian_2D.mask = gaussian2D(gaussian_2D.mask_size, gaussian_2D.sigma);

% Count 2D gaussian convolution time when sigma is 3
tic;
img.gaussian_2D_sigma3 = convoluteImage(gaussian_2D.mask, img.original, 'multiply');
timings.gaussian_2D_sigma3 = toc;

% Get 1D Gaussian filter for sigma = 1
gaussian_1D.sigma = 1;
gaussian_1D.mask_size = 3 * gaussian_1D.sigma;
gaussian_1D.mask = gaussian1D(gaussian_1D.mask_size, gaussian_1D.sigma);

% Count 2 times 1D gaussian convolution time when sigma is 1
tic;
img.gaussian_1D_sigma1 = convoluteImage(gaussian_1D.mask,  img.original, 'multiply');
img.gaussian_1D_sigma1 = convoluteImage(gaussian_1D.mask', img.gaussian_1D_sigma1, 'multiply');
timings.gaussian_1D_sigma1 = toc;

% Get 1D Gaussian filter for sigma = 3
gaussian_1D.sigma = 3;
gaussian_1D.mask_size = 3 * gaussian_1D.sigma;
gaussian_1D.mask = gaussian1D(gaussian_1D.mask_size, gaussian_1D.sigma);

% Count 2 times 1D gaussian convolution time when sigma is 3
tic;
img.gaussian_1D_sigma3 = convoluteImage(gaussian_1D.mask,  img.original, 'multiply');
img.gaussian_1D_sigma3 = convoluteImage(gaussian_1D.mask', img.gaussian_1D_sigma3, 'multiply');
timings.gaussian_1D_sigma3 = toc;

figure('Name', 'Exercise 2.a');
colormap(gray(256)); 
subplot(2, 2, 1);
title('Sigma = 1 Gaussian 2D');
image(img.gaussian_2D_sigma1);
daspect([1 1 1]);

subplot(2, 2, 2);
title('Sigma = 3 Gaussian 2D');
image(img.gaussian_1D_sigma3);
daspect([1 1 1]);

subplot(2, 2, 3);
title('Sigma = 1 Gaussian 1D');
image(img.gaussian_1D_sigma1);
daspect([1 1 1]);

subplot(2, 2, 4);
title('Sigma = 3 Gaussian 1D');
image(img.gaussian_1D_sigma3);
daspect([1 1 1]);

% Scale differences
differences.sigma1 = img.gaussian_2D_sigma1 - img.gaussian_1D_sigma1; %  Subtract
differences.sigma1 = differences.sigma1.^2; % Square it
differences.sigma1_scale = max(max(max(differences.sigma1))); % Get the scale factor
differences.sigma1 = 255 / differences.sigma1_scale * differences.sigma1; % Scale it to get eye-visible results

differences.sigma3 = img.gaussian_2D_sigma3 - img.gaussian_1D_sigma3;
differences.sigma3 = differences.sigma3.^2;
differences.sigma3_scale = max(max(max(differences.sigma3)));
differences.sigma3 = 255 / differences.sigma3_scale * differences.sigma3;

figure('Name', 'Exercise 2.b');
colormap(gray(256)); 
subplot(1, 2, 1);
image(differences.sigma1);
title('Sigma = 1 difference');
daspect([1 1 1]);
subplot(1, 2, 2);
image(differences.sigma3);
title('Sigma = 3 difference');
daspect([1 1 1]);

% Time differences
disp('Exercise 2.c');
disp(sprintf('2D Gaussian sigmas took:\n %f for sigma = 1\n %f for sigma = 3\n', timings.gaussian_2D_sigma1, timings.gaussian_2D_sigma3));
disp(sprintf('2 times 1D Gaussian sigmas took:\n %f for sigma = 1\n %f for sigma = 3\n', timings.gaussian_1D_sigma1, timings.gaussian_1D_sigma3));
%%% End of Exercise 2

%%% Exercise 3
% Define basic grandient filters
Dx = [-1, 0, 1;
      -1, 0, 1;
      -1, 0, 1];
Dy = Dx';

% Compute x gradient image
grad.X = convoluteImage(Dx, img.original, 'multiply');
% Compute y gradient image
grad.Y = convoluteImage(Dy, img.original, 'multiply');

figure('Name', 'Exercise 3.a');
colormap(gray(256)); 
subplot(1, 2, 1);
title('x-direction gradient image');
image(grad.X);
daspect([1 1 1]);
subplot(1, 2, 2);
title('y-direction gradient image');
image(grad.Y);
daspect([1 1 1]);

% gradient magnitude
grad.magnitude = grad.X.^2 + grad.Y.^2;
grad.magnitude = sqrt(grad.magnitude);

% gradient orientation
grad.orientation = 180 / pi * atan2(grad.Y, grad.X);

figure('Name', 'Exercise 3.b');
subplot(1, 2, 2);
title('Gradient orientation');
image(grad.orientation);
daspect([1 1 1]);
colormap(gray(256));

subplot(1, 2, 1);
title('Gradient magnitude');
image(grad.magnitude);
daspect([1 1 1]);

% Use associativity law for I_x = D_x * (G * I)
% First compute I_x = D_x * (G * I)
noise_reduc1.x_kernel = convoluteImage(gaussian_2D.mask, img.original, 'multiply');
noise_reduc1.x = convoluteImage(Dx, noise_reduc1.x_kernel, 'multiply');
noise_reduc1.y_kernel = convoluteImage(gaussian_2D.mask, img.original, 'multiply');
noise_reduc1.y = convoluteImage(Dy, noise_reduc1.y_kernel, 'multiply');

figure('Name', 'Exercise 3.c Noise Reduction');
colormap(gray(256));
subplot(1, 2, 1);
title('Noise reduction x-direction Grad*(Gauss*Image)');
image(noise_reduc1.x);
daspect([1 1 1]);

subplot(1, 2, 2);
title('Noise reduction y-direction Grad*(Gauss*Image)');
image(noise_reduc1.y);
daspect([1 1 1]);

% gradient magnitude
noise_reduc1.gradient_magnitude = noise_reduc1.x.^2 + noise_reduc1.y.^2;
noise_reduc1.gradient_magnitude = sqrt(noise_reduc1.gradient_magnitude);

% gradient orientation
noise_reduc1.gradient_orientation = 180 / pi * atan2(noise_reduc1.y, noise_reduc1.y);
figure('Name', 'Exercise 3.d Grad*(Gauss*Image)');
subplot(1, 2, 2);
title('Gradient orientation');
image(noise_reduc1.gradient_orientation);
daspect([1 1 1]);
colormap(gray(256));

subplot(1, 2, 1);
image(noise_reduc1.gradient_magnitude);
title('Gradient magnitude');
daspect([1 1 1]);


% Use associativity law for I_x = D_x * (G * I)
% To get I_x = (D_x * G) * I
noise_reduc2.x_kernel = convolution(gaussian_2D.mask, Dx, 'multiply');
noise_reduc2.x = convoluteImage(noise_reduc2.x_kernel, img.original, 'multiply');
noise_reduc2.y_kernel = convolution(gaussian_2D.mask, Dy, 'multiply');
noise_reduc2.y = convoluteImage(noise_reduc2.y_kernel, img.original, 'multiply');

figure('Name', 'Exercise 3.c (Grad*Gauss)*Image');
colormap(gray(256));
subplot(1, 2, 1);
image(noise_reduc2.x);
title('Noise reduction x-direction');
daspect([1 1 1]);
subplot(1, 2, 2);
image(noise_reduc2.y);
title('Noise reduction y-direction');
daspect([1 1 1]);

% gradient magnitude
noise_reduc2.gradient_magnitude = noise_reduc2.x.^2 + noise_reduc2.y.^2;
noise_reduc2.gradient_magnitude = sqrt(noise_reduc2.gradient_magnitude);

% gradient orientation
noise_reduc2.gradient_orientation = 180 / pi * atan2(noise_reduc2.y, noise_reduc2.x);
figure('Name', 'Exercise 3.d (Grad*Gauss)*Image orientation/magnitude');
subplot(1, 2, 2);
title('Gradient orientation');
image(noise_reduc2.gradient_orientation);
daspect([1 1 1]);
colormap(gray(256));

subplot(1, 2, 1);
title('Gradient magnitude');
image(noise_reduc2.gradient_magnitude);
daspect([1 1 1]);