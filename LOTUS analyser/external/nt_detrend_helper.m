%% Original version of detrend (no windows) is called by new version (windows)
function [y,w,r]=nt_detrend_helper(x,order,w,basis,thresh,niter)
%[y,w,r]=nt_detrend(x,order,w,basis,thresh,niter) - robustly remove trend
% 
%  y: detrended data
%  w: updated weights
%  r: basis matrix used
%
%  x: raw data
%  order: order of polynomial or number of sin/cosine pairs
%  w: weights
%  basis: 'polynomials' [default] or 'sinusoids', or user-provided matrix
%  thresh: threshold for outliers [default: 3 sd]
%  niter: number of iterations [default: 3]
%
% Noise tools
% See nt_regw().
%
% The data are fit to the basis using weighted least squares. The weight is
% updated by setting samples for which the residual is greater than 'thresh' 
% times its std to zero, and the fit is repeated at most 'niter'-1 times.
%
% The choice of order (and basis) determines what complexity of the trend
% that can be removed.  It may be useful to first detrend with a low order
% to avoid fitting outliers, and then increase the order.
%
% Examples:
% Fit linear trend, ignoring samples > 3*sd from it, and remove:
%   y=nt_detrend(x,1); 
% Fit/remove polynomial order=5 with initial weighting w, threshold = 4*sd:
%   y=nt_detrend(x,5,w,[],4);
% Fit/remove linear then 3rd order polynomial:
%   [y,w]=nt_detrend(x,1);
%   [yy,ww]=nt_detrend(y,3);
%
% nt_greetings;

% arguments
if nargin<2; error('!'); end
if nargin<3; w=[]; end
if nargin<4||isempty(basis); basis='polynomials'; end
if nargin<5||isempty(thresh); thresh=3; end
if nargin<6||isempty(niter); niter=3; end

if thresh==0; error('thresh=0 is not what you want...'); end % common mistake

dims=size(x);
x=x(:,:); % concatenates dims >= 2
w=w(:,:);

if size(w,2)==1; w=repmat(w,1,size(x,2)); end

%% regressors
if isnumeric(basis)
    r=basis;
else
    switch basis
        case 'polynomials'
            r=zeros(size(x,1),numel(order));
            lin=linspace(-1,1,size(x,1));
            for k=1:order
                r(:,k)=lin.^k;
            end
        case 'sinusoids'
            r=zeros(size(x,1),numel(order)*2);
            lin=linspace(-1,1,size(x,1));
            for k=1:order
                r(:,2*k-1)=sin(2*pi*k*lin/2);
                r(:,2*k)=cos(2*pi*k*lin/2);
            end
        otherwise
            error('!');
    end
end


% remove trends
% The tricky bit is to ensure that weighted means are removed before
% calculating the regression (see nt_regw).

for iIter=1:niter
    
    % weighted regression on basis
    [~,y]=nt_regw(x,r,w);
    
    % find outliers
    d=x-y; 
    if ~isempty(w); d=bsxfun(@times,d,w); end
    ww=ones(size(x));
    ww(find(abs(d)>thresh*repmat(std(d),size(x,1),1))) = 0;
     
    % update weights
    if isempty(w); 
        w=ww;
    else
        w=min(w,ww);
    end
    clear ww;    
end
y=x-y;
y=reshape(y,dims);
w=reshape(w,dims);

end
