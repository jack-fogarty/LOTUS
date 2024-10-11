function [C] = sparseMatrixMultiplication(A,B,splitSize,altSplitSize)
% [C] = sparseMatrixMultiplication (A, B, splitSize,[altSplitSize])
% memory-efficient implementation of sparse-matrix multiplication
%
% A = (sparse) left matrix
% B = (sparse) right matrix
% splitSize = size of the split the matrices are decomposed into
% altSplitSize = [optional] alternate split size. When this input is
% provided, splitSize refers to rows, altSplitSize refers to cols. This
% input is optional and usefull in very particular situation, where 
% matrix C is very asymmetric (e.g., rows >> cols).
% 
% C = sparse matrix resulting from A*B
%
% e.g.:
% A=sparse(rand(1038,1000));
% B=sparse(rand(1000,1038));
% C=sparseMatrixMultiplication(A,B,10);
% C=sparseMatrixMultiplication(A,B,10,5);
if (~issparse(A) || ~issparse(B))
    warning ('matrices should be sparse!');
end
if (size(A,2)~=size(B,1))
    error ('cols of A differs from rows of B!');
end
if nargin==3
    splitSizeCol=splitSize;
    splitSizeRow=splitSize;
else
    splitSizeRow=splitSize;
    splitSizeCol=altSplitSize;
end
rows=size(A,1);
cols=size(B,2);
if (splitSizeRow>rows)
    warning ('splitSizeRow cannot be greater than matrixes size');
    splitSizeRow=rows;
end
if (splitSizeCol>cols)
    warning ('splitSizeCol cannot be greater than matrixes size');
    splitSizeCol=cols;
end
%C=sparse(rows,cols);
rowsplits = ceil(rows/splitSizeRow);
colsplits = ceil(cols/splitSizeCol);
% tic;
totsplits=rowsplits*colsplits;
C=[];
for i=1:rowsplits
    maxNumOfRows=min([i*splitSizeRow,rows]);
    rowsIndexes=splitSizeRow*(i-1)+1:maxNumOfRows;
    E=[];
    for j=1:colsplits
        maxNumOfCols=min([j*splitSizeCol,cols]);
        colsIndexes=splitSizeCol*(j-1)+1:maxNumOfCols;
        
        %C(rowsIndexes,colsIndexes)=sparse(full(A(rowsIndexes,:))*full(B(:,colsIndexes)));        
        %C(rowsIndexes,colsIndexes)=((A(rowsIndexes,:))*(B(:,colsIndexes)));        
        tmp=((A(rowsIndexes,:))*(B(:,colsIndexes)));        
        E=[E,tmp]; 
        % t((i-1)*colsplits+j) =toc;
        % currentSplit=((i-1)*colsplits+j);
        % remainingSplits=totsplits-currentSplit;
        % if (length(t)>1)
        %     display([num2str(t(end)-t(end-1)),' - est. remaining time (',num2str(remainingSplits),'/',num2str(totsplits),'): ', num2str(remainingSplits*mean(diff(t)))]);
        % end
    end
    C=[C;E];
end
end