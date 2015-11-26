function evaluation = evaluateBox(x, y, xn, yn, zn, s, img)
    img_size = size(img);
    % Precalculate values as there are only 4 varying operations
    xps = x + xn + s;
    xms = x + xn - s;
    yps = y + yn + s;
    yms = y + yn - s;
    % color channel is fucked up: 0 - B; 1 - G; 2 - R; 1 - R
    switch zn
        case 0
            zn = 3;
        case 1
            zn = 2;
        case 2
        case 3
            zn = 1;
    end

    % Deduce each part of formula
    if (xps <= 0 || xps > img_size(2) || yms <= 0 || yms > img_size(1))
        e1 = 0;
    else
        e1 = img(yms, xps, zn);
    end

    if (xms <= 0 || xms > img_size(2) || yps <= 0 || yps > img_size(1))
        e2 = 0;
    else
        e2 = img(yps, xms, zn);    
    end

    if (xps <= 0 || xps > img_size(2) || yms <= 0 || yms > img_size(1))
        e3 = 0;
    else
        e3 = img(yms, xps, zn);
    end
    
    if (xms <= 0 || xms > img_size(2) || yms <= 0 || yms > img_size(1))
        e4 = 0;
    else
        e4 = img(yms, xms, zn);
    end
    % Formula for evaluation
    evaluation = e1 - e2 - e3 + e4;
end