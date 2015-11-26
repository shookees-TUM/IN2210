% Reads text file into tree
% The first line of the file shows how many nodes there are - n
% next n lines have the following format:
% i c_L c_R t x_0 y_0 z_0 x_1 y_1 z_1 s
%%%
% i - node id,
% c_L - left child,
% c_R - right child,
% t - treshold,
% x_0, y_0 - first box feature center location offset,
% x_1, y_1 - second box feature center location offset,
% z_0, z_1 - color channel.
% s - size of the two boxes
% If c_L or c_R are < 1, then a leaf node is reached.
%%%
% After reading n nodes, next line shows how many leaves there are - m
% next m lines have the following format:
% j p_x p_y
%%%
% j - leaf id,
% p_x, p_y - mean vote offset for this leaf.
%%%
% The returning data structure is as follows:
% tree.nodes - array of nodes
% tree.leaves - array of leaves
%%%
% node structure:
% node.id - identification number for the node
% node.cl - left child
% node.cr - right child
% node.t - treshold
% node.x and node.y - two element array for box feature center location offsets
% node.z - two element array with color channels
% node.s - size of two boxes
%%%
% leaf structure:
% leaf.id - identification number for the leaf
% leaf.px and leaf.py - mean vote offset for this leaf.
%%%
function tree = readTreeFromFile(filepath)
    % open a file for reading
    fid = fopen(filepath);
    % str2num convert string to a number
    n = str2num(fgets(fid));
    % read nodes
    for i = 1: n
        tmp = strread(fgets(fid));
        node.cl = tmp(2);
        node.cr = tmp(3);
        node.t = tmp(4);
        node.x(1) = tmp(5);
        node.y(1) = tmp(6);
        node.z(1) = tmp(7);
        node.x(2) = tmp(8);
        node.y(2) = tmp(9);
        node.z(2) = tmp(10);
        node.s = tmp(11);
        tree.nodes(tmp(1) + 1) = node;
    end
    % read leaves
    m = str2num(fgets(fid));
    for i = 1: m
        tmp = strread(fgets(fid));
        leaf.px = tmp(2);
        leaf.py = tmp(3);
        tree.leaves(tmp(1) + 1) = leaf;
    end
end