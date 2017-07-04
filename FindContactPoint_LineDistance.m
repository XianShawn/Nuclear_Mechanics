function [contactPointIndex] = FindContactPoint_LineDistance(xData, yData)
% Finds intersection point of the curve and line connected the first and last point. 
% curveStartIndex, contactPointIndex andcurveEndIndex are 0 if no intersection exists.
%
% Example

    curveStartIndex = 0;
    contactPointIndex = 0;
    curveEndIndex = 0;
    xSize = max(size(xData));
    ySize = max(size(yData));
    %if(xSize == ySize)

    %Method for contact point is subtract the line connected the first and last point from all points in the curve, and use the lowest point
    slope = (yData(ySize) - yData(1))/ (xData(xSize) - xData(1));
    minY = 0;
    for i = 1:ySize
        yVal = yData(i) - slope * xData(i);
        if (i == 1 || yVal < minY )
            minY = yVal;
            contactPointIndex = i;
        end
    end
    %Determine direction of curve. Method assumes end of the contact region is higher that the non-contact region
    if (yData(1)> yData(ySize))
        curveStartIndex = ySize;
        curveEndIndex = 1;
    else
        curveStartIndex = 1;
        curveEndIndex = ySize;
    end;
    %Method is find highest point after contact point
    if curveEndIndex > contactPointIndex
        increment = 1;
    else
        increment = -1;
    end
    maxY = 0;
    i= contactPointIndex + increment;
    while i * increment <= curveEndIndex * increment
        if yData(i) > maxY
            maxY = yData(i);
        end
        i = i + increment;
    end
    targetMaxY = (maxY - yData(contactPointIndex)) + yData(contactPointIndex);
    maxIndex = contactPointIndex;
    i= contactPointIndex + increment
    while i * increment <= curveEndIndex * increment
        if (yData(i) > targetMaxY)
            break;
        end
        maxIndex = i;
        i = i + increment;
    end
    curveEndIndex = maxIndex;
end

