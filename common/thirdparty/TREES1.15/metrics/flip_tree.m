% FLIP_TREE   flips a tree around one axis.
% (trees package)
%
% tree = flip_tree (intree, DIM, options)
% ---------------------------------------
%
% flips tree around dimension DIM
%
% Input
% -----
% - intree::integer:index of tree in trees or structured tree
% - DIM::1, 2 or 3: dimension to be flipped {DEFAULT: 1, x-axis}
% - options::string: {DEFAULT: ''}
%     '-s' : show before and after
%
% Output
% -------
% if no output is declared the tree is changed in the trees structure
% - tree:: structured output tree
%
% Example
% -------
% flip_tree (sample_tree, [], '-s')
%
% See also tran_tree rot_tree scale_tree
% Uses ver_tree X Y Z
%
% the TREES toolbox: edit, visualize and analyze neuronal trees
% Copyright (C) 2009  Hermann Cuntz

function varargout = flip_tree (intree, DIM, options)

% trees : contains the tree structures in the trees package
global trees

if (nargin < 1)||isempty(intree),
    intree = length (trees); % {DEFAULT tree: last tree in trees cell array}
end;

ver_tree (intree); % verify that input is a tree structure

% use full tree for this function
if ~isstruct (intree),
    tree = trees {intree};
else
    tree = intree;
end

if (nargin < 2)||isempty(DIM),
    DIM = 1; % {DEFAULT: flip over x dimension}
end;

if (nargin < 3)||isempty(options),
    options = ''; % {DEFAULT: no option}
end

switch DIM
    case 1
        tree.X = 2 * tree.X (1) - tree.X;
    case 2
        tree.Y = 2 * tree.Y (1) - tree.Y;
    case 3
        tree.Z = 2 * tree.Z (1) - tree.Z;
    otherwise
        warning ('TREES:wronginputs','DIM not the right number');
end

if strfind (options, '-s') % show option
    clf; shine; hold on; plot_tree (intree); plot_tree (tree, [1 0 0]);
    HP(1) = plot (1, 1, 'k-'); HP(2) = plot (1, 1, 'r-');
    legend (HP, {'before', 'after'}); set (HP, 'visible', 'off');
    title  ('flip a tree');
    xlabel ('x [\mum]'); ylabel ('y [\mum]'); zlabel ('z [\mum]');
    if DIM == 3,
        view ([0 0]);
    else
        view (2);
    end
    grid on; axis image;
end

if (nargout > 0||(isstruct(intree)))
    varargout {1}  = tree; % if output is defined then it becomes the tree
else
    trees {intree} = tree; % otherwise add to end of trees cell array
end