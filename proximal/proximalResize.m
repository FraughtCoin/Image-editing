function proximalResize(input, p, q, output)
    image = imread(input);
    [m, n, nrColors] = size(image);
    sx = (q-1)/(n-1);
    sy = (p-1)/(m-1);

    Tinv = [1 / sx, 0; 0, 1 / sy];

    R = zeros(p, q, nrColors);
    for z = 1: nrColors  
        for y = 0: p - 1
            for x = 0: q - 1
                rez = Tinv * [x; y];
                rez = rez + 1;
                rez = round(rez);
                R(y + 1, x + 1, z) = image(rez(2), rez(1), z);
            end
        end
    end
    
    R = uint8(R);
    imwrite(R, output);
end