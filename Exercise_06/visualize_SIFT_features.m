% compute the SIFT frames (keypoints) and descriptors of scene J
[f_S,d_S] = vl_sift(S);
% visualize a random selection of 100 features
imagesc(J);
perm = randperm(size(f_J,2));
sel = perm(1:100);
h_J_1 = vl_plotframe(f_J(:,sel));
h_J_2 = vl_plotframe(f_J(:,sel));
set(h_J_1,'color','r','linewidth',2);
set(h_J_2,'color','y','linewidth',2);
% overlay the descriptors d 
h3 = vl_plotsiftdescriptor(d_J(:,sel),f_J(:,sel));
set(h3,'color','g');