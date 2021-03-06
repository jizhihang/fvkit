function fvo = gmm_fv_opts(fvo,enc)
    % Set FV options
    %
    % Part of FVKit - initial release
    % Copyright, 2013-2018
    % Thomas Mensink, University of Amsterdam
    % thomas.mensink@uva.nl

    if nargin < 1 || isempty(fvo),   fvo                    = struct;           end
    
    if ~isfield(fvo,'opts'),         fvo.opts               = struct;           end
    if ~isfield(fvo.opts,'gWeight'), fvo.opts.gWeight       = false;            end
    if ~isfield(fvo.opts,'gMean'),   fvo.opts.gMean         = true;             end
    if ~isfield(fvo.opts,'gVar'),    fvo.opts.gVar          = true;             end
    if ~isfield(fvo.opts,'pfunc'),   fvo.opts.pfunc         = @gmm_fv;          end
    if ~isfield(fvo.opts,'pfuncinit'),fvo.opts.pfuncinit    = @gmm_fv_init;     end
    if ~isfield(fvo.opts,'FIM'),     fvo.opts.FIM           = 'CFA';            end
    if ~isfield(fvo.opts,'sparse'),  fvo.opts.sparse        = 0;                end
    
    fvo.opts.NrDim= (fvo.opts.gWeight + (fvo.opts.gMean + fvo.opts.gWeight) * enc.pca.pdim) * enc.prob.k;
    
    bname                           = sprintf('%s_',fvo.opts.FIM);
    if fvo.opts.gWeight,  bname   = [bname 'w'];      end
    if fvo.opts.gMean,    bname   = [bname 'm'];      end
    if fvo.opts.gVar,     bname   = [bname 'v'];      end
    
    if fvo.opts.sparse > 0,
        bname = sprintf('%s_s%02d',bname,fvo.opts.sparse);
    end
    
    fvo.path = sprintf('%s/%s/%s_%s',enc.prob.path,enc.prob.name,func2str(fvo.opts.pfunc),bname);
end