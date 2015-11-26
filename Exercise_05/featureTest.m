% Does a feature test on integral image with specific x and y values on specific node
% returns true if < t; false if >= t
function result = featureTest(x, y, node, img)
    %    evaluateBox(x, y, xn, yn, zn, s, img)
    b1 = evaluateBox(x, y, node.x(1), node.y(1), node.z(1), node.s, img);
    b2 = evaluateBox(x, y, node.x(2), node.y(2), node.z(2), node.s, img);
    f = b1 - b2;
    result = f < node.t;
end