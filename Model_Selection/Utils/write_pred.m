function [ ] = write_pred( Labels, filename)
    pred = fopen(filename','w');

    for s = 1:numel(Labels) 

        predictions = Labels(s).pred;
        z= 0;
        M=[];
        while  z < numel(predictions) -1
            z=z+1;
            if predictions(z)~=0
                M(end+1,1)=predictions(z);
                M(end,2)=z;
                while predictions(z+1) ==  M(end,1) && z < numel(predictions)-1
                    z=z+1;
                end
                M(end,3)=z;
            end
        end

        if ~isempty(M)
            M(end,3) = Labels(s).nFrames;           
        else
            M = [1, Labels(s).nFrames, randi(249)];
        end
        
        tline = [];
        tline = [Labels(s).FolderID, '/', Labels(s).FileID];
        for i = 1:size(M,1)
            tline = [tline, ' ', num2str(M(i,2)), ',', num2str(M(i,3)), ':', num2str(M(i,1))];
        end
        fprintf(pred,'%s\n',tline);
    end

    fclose(pred); 

end

