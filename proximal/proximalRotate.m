function proximalRotate(input, angle, angleType, output)
    image = imread(input);
    [m, n, nrColors] = size(image);

    if angleType == 2
        angle = pi * angle / 180;
    end

    c = cos(angle);
    s = sin(angle);

    T = [c, -s; s, c];

    R = zeros(m, n, nrColors);

    for z = 1 : nrColors
        for y = 0 : m - 1
            for x = 0 : n - 1
                rez = T \ [x; y];
                rez = rez + 1;
                xp = rez(1);
                yp = rez(2);

                x1 = floor(xp);
                x2 = floor(xp + 1);
                y1 = floor(yp);
                y2 = floor(yp + 1);

                if round(x1) >= n
                    x2 = n;
                    x1 = n-1;
                end
                if round(y1) >= m
                    y2 = m;
                    y1 = m - 1;
                end

                if x1 < 1 || x2 >= n|| y1 < 1 || y2 >= m
                    R(y + 1, x + 1, z) = 0;
                else
                    M = [1, x1, y1, x1*y1; 1, x1, y2, x1*y2; 1, x2, y1, ...
                        x2*y1; 1, x2, y2, x2*y2];

                    Rez = [image(y1, x1, z); image(y2, x1, z); ... 
                        image(y1, x2, z); image(y2, x2, z)];

                    Rez = double(Rez);
                    a = M \ Rez;

                    R(y+1, x+1, z) = a(1) + a(2)*xp + a(3)*yp + a(4)*xp*yp;
                end
            end
        end
    end

    R = uint8(R);
    imshow(R);
end