% Goes to the leaf of the tree for (x, y) pixel o (img) image
function prediction = treePrediction(x, y, tree, img)
    leaf_reached = false;
    current_node_id = 0;
    while (~leaf_reached)
        % if true, take left child; else - right
        if (featureTest(x, y, tree.nodes(current_node_id + 1), img) == true)
            current_node_id = tree.nodes(current_node_id + 1).cl;
        else
            current_node_id = tree.nodes(current_node_id + 1).cr;
        end
        if (current_node_id < 1)
            leaf_reached = true;
        end
    end
    leaf_id = abs(current_node_id);
    prediction.x = tree.leaves(leaf_id + 1).px;
    prediction.y = tree.leaves(leaf_id + 1).py;
end