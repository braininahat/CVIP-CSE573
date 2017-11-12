function [stitched] = stitch(im1, im2, H)

    [h1, w1, color1] = size(im1);
    [h2, w2, color2] = size(im2);
    
    vertices = [ 1 1 1;
                w1 1 1;
                w1 h1 1;
                1 h1 1];
    
    homoCoord = vertices * H;
    dimension = size(homoCoord) - 1;
    normCoord = bsxfun(@rdivide,homoCoord,homoCoord(:,end));
    new_vertices = normCoord(:,1:dimension);        

    minX = min( min(new_vertices(:,1)), 1);
    maxX = max( max(new_vertices(:,1)), w2);
    minY = min( min(new_vertices(:,2)), 1);
    maxY = max( max(new_vertices(:,2)), h2);

    xResRange = minX : maxX;
    yResRange = minY : maxY;

    [x,y] = meshgrid(xResRange,yResRange) ;
    Hinv = inv(H);

    warpedHomoScaleFactor = Hinv(1,3) * x + Hinv(2,3) * y + Hinv(3,3);
    warpX = (Hinv(1,1) * x + Hinv(2,1) * y + Hinv(3,1)) ./ warpedHomoScaleFactor ;
    warpY = (Hinv(1,2) * x + Hinv(2,2) * y + Hinv(3,2)) ./ warpedHomoScaleFactor ;


    if color1 == 1
        blendedLeftHalf = interp2( im2double(im1), warpX, warpY, 'cubic') ;
        blendedRightHalf = interp2( im2double(im2), x, y, 'cubic') ;
    else
        blendedLeftHalf = zeros(length(yResRange), length(xResRange), 3);
        blendedRightHalf = zeros(length(yResRange), length(xResRange), 3);
        for i = 1:3
            blendedLeftHalf(:,:,i) = interp2( im2double( im1(:,:,i)), warpX, warpY, 'cubic');
            blendedRightHalf(:,:,i) = interp2( im2double( im2(:,:,i)), x, y, 'cubic');
        end
    end
    blendWeight = ~isnan(blendedLeftHalf) + ~isnan(blendedRightHalf) ;
    blendedLeftHalf(isnan(blendedLeftHalf)) = 0 ;
    blendedRightHalf(isnan(blendedRightHalf)) = 0 ;
    stitched = (blendedLeftHalf + blendedRightHalf) ./ blendWeight ;
end