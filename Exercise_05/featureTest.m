% returns true if < t; false if >= t
function result = featureTest(x, y, node, img)
    f = evaluateBox(x, y, node.x(1), node.y(1), node.z(1), node.s, img) - evaluateBox(x, y, node.x(2), node.y(2), node.z(2), node.s, img);
    result = f < node.t;
end