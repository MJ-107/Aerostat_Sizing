function candidates = filter_smallestSA(spheroids, candidates)

    % If there is no candidates, assign to blank array
    if nargin < 2  % if second argument not provided
        candidates = [];
    end

    % *** Ensure column 1 always contains spheroid indices
    
    % If candidates is empty, initialize with all spheroids
    if isempty(candidates)
        candidates = (1:length(spheroids))';
    end

    % If input has multiple columns, keep only column 1 (indices)
    if size(candidates,2) > 1
        candidates = candidates(:,1);
    end

    % Build matrix [spheroid_idx  surfaceArea]
    temp = [];
    i = 1;

    while i <= length(candidates)
        spheroid_idx = candidates(i);
        SA = spheroids(spheroid_idx).surfaceArea;
        temp = [temp; spheroid_idx, SA];
        i = i + 1;
    end

    % Find minimum SA

    minSA = temp(1,2);

    i = 2;
    while i <= size(temp,1)

        if temp(i,2) < minSA
            minSA = temp(i,2);
        end
        
        i = i + 1;
    end

    % Keep only rows with minimum SA
    newCandidates = [];
    
    % Collect all min SA instances
    j = 1;

    while j <= size(temp,1)

        if temp(j,2) == minSA
            newCandidates = [newCandidates; temp(j,:)];
        end

        j = j + 1;
    end

    candidates = newCandidates;

end