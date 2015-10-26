sigma = 3;
% dimension? 2D for exercise 2a), 1D for 2b)
dimGauss = 2;
s = floor(3 * sigma / 2);
u = -s;
v = -s;
grid on;
% Load image 
I = imread('lena.gif');
% define Gaussian filter
if dimGauss == 2
    G2D = zeros(3 * sigma);
    for u = -s:1:s
        for v = -s:1:s
            g = 1 / (2 * pi * sigma^2) * exp(-1/2 * (u^2 + v^2) / (sigma^2));
            G2D(u+s+1, v+s+1) = g;
            v = v + 1;
        end
        u = u + 1;
    end
    mesh(G2D);
    %pause;
elseif dimGauss == 1
    for u = -s:1:s
        g = 1 / sqrt(2 * pi * sigma^2) * exp(-1/2 * (u^2) / (sigma^2));
        G1D(u+s+1) = g;
        u = u + 1;
    end
    G1Dtrans = transpose(G1D);
    plot(G1D);
    %pause;
else display('dimGauss needs to be set to either 1 or 2')
end
% apply Gaussian filter via J = convoluteImage(H, I, border)
% where H is the mask, I is the image, border is the boarder handling
tic;
if dimGauss == 2
    J = convoluteImage(G, I, 'mirror');
elseif dimGauss == 1
    J1 = convoluteImage(G1D, I, 'mirror');
    J = convoluteImage(G1Dtrans, J1, 'mirror');
else
end
elapsed_time = toc
imagesc(J);