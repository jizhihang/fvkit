function isp = ispath(CPath)
    % A kind of ismember function for the matlab path
    % Input: CPath is a cell containing strings for the path
    %
    % Part of FVKit - initial release
    % Copyright, 2013-2018
    % Thomas Mensink, University of Amsterdam
    % thomas.mensink@uva.nl
        
    if ~iscell(CPath),
        tmp     = CPath;CPath = cell(1);
        CPath{1}= tmp;
    end
    
    ps      = pathsep;
    cmdirs  = regexp([matlabpath ps],['.[^' ps ']*' ps],'match')';
    
    for i=1:numel(CPath),
        CPath{i} = [CPath{i} ':'];
    end
    
    isp     = ismember(CPath,cmdirs);
    
end