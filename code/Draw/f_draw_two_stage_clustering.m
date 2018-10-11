function f_draw_two_stage_clustering()
% This function is for drawing the schematic diagram of the two-stage 
% fuzzy clustering algorithm.
% The mpt toolbox is used in this function.

addpath('../DOE');
addpath('../Tools');
addpath('../ClusteringAlgorithm');

nSample = 30;
nRBF = 10;
h0 = 0;
h1 = 1.5;
h2 = 2.5;
h3 = 4;
h4 = 5;

sample = DOE_latin( [0 1; 0 1], nSample );

[ RBF, U, idx1 ] = f_fkm( sample, nRBF, 0 );
[ L, U, idx2 ] = f_fkm( RBF, 2, 1 );
idx2 = softPartition(0.4);

pbound = Polyhedron([0 0; 0 1;1 0;1 1]);
V = mpt_voronoi(RBF', 'bound',pbound);

plotClusters(idx2);
hold on;
plot(sample, RBF, L);

    function [clusterTable] = softPartition(lambda)
        clusterTable = zeros(1, nRBF);
        
%         thr = (1-lambda)/2;           % good
        thr = (1-lambda^(1/2))/2;       % better

        for col = 1 : nRBF
            colData = U(:, col);
            [~, maxCId] = max(colData);
            add2Cluster(maxCId, col);

            for row = 1:2
                if row == maxCId
                    continue;
                end
                if colData(row) > thr
                    add2Cluster(row, col);
                end
            end
        end
        
            function add2Cluster(cId, sId)
                clusterTable(sId) = clusterTable(sId) + cId;
            end
    end

    function plotClusters(clusterTable)
        face = [0.871 0.49 0.0; 
            0.302 0.745 0.933; 
            0.467 0.675 0.188];
        
        for pointId = 1 : nRBF
            loop = f_minimal_convex_polygon(V.Set(pointId, 1).V')';
            drawBlocks(loop, clusterTable(pointId));
        end
        
        function drawBlocks(loop, id)
            tt([loop h0*ones(size(loop,1),1)]);
            
            function tt(t)
                fill3(t(:,1), t(:,2), t(:,3), face(id,:)); hold on;
            end
            
        end
        
        axis([0 1 0 1]);
    end

    function plot(sample, RBF, L)
        
        plot_i(1);
        plot_i(2);
        plot_i(3);
        plotBlock(h1);
        plotBlock(h3);
        
        function plotBlock(h)
            points = [0 0 h;
                0 1 h;
                1 1 h;
                1 0 h;
                0 0 h;
                ];
            c = [0.5 0.5 0.5];
            fill3(points(:,1), points(:,2), points(:,3), c);
        end
        
        function plot_i(LRBFN_id)
            
            color = [0.871 0.49 0.0; 
                0.302 0.745 0.933; 
                0.467 0.675 0.188];
            color1 = color(LRBFN_id, :);

            if LRBFN_id~= 3
                scatter3(L(LRBFN_id, 1), L(LRBFN_id, 2), h4);
            end
            RBF1 = [];
            sample1 = [];
            for rbf_id = 1:nRBF
                if idx2(rbf_id) == LRBFN_id
                    
                    if LRBFN_id == 3
                        f_drawline3([L(1,:) h4], [RBF(rbf_id, :) h3], 'k', color1);
                        f_drawline3([L(2,:) h4], [RBF(rbf_id, :) h3], 'k', color1);
                    else
                        f_drawline3([L(LRBFN_id,:) h4], [RBF(rbf_id, :) h3], 'k', color1);
                    end
                    
                    RBF1 = [RBF1; RBF(rbf_id, :)];

                    for point_id = 1:nSample
                        if idx1(point_id) == rbf_id
                            f_drawline3([sample(point_id,:) h1], [RBF(rbf_id, :) h2], 'k', color1);
                            sample1 = [sample1; sample(point_id,:)];
                        end
                    end
                end
            end
            f_draw_vertical_lines(RBF1, h2, h3, ':k', color1);
            f_draw_vertical_lines(sample1, h0, h1, '--k', color1);
            scatter3(RBF1(:,1), RBF1(:,2), h2*ones(size(RBF1,1), 1), 'ko', 'filled', 'g');
            scatter3(RBF1(:,1), RBF1(:,2), h3*ones(size(RBF1,1), 1), 'ko', 'filled', 'g');
            scatter3(sample1(:,1), sample1(:,2), h0*ones(size(sample1,1), 1), 'o', 'filled', 'g');
            scatter3(sample1(:,1), sample1(:,2), h1*ones(size(sample1,1), 1), 'ko', 'filled', 'g');
        end

    end

end
