function f_draw_space_division()
% This function is for drawing the figure of different space-division 
% schemes using different expansion factors.
% The mpt toolbox of voronoi diagram is used in this function

addpath('../ClusteringAlgorithm');
addpath('../DOE');
addpath('../Tools');

nRBF = 40;
nLocalRegion = 2;

sample = DOE_latin( [0 1;0 1], nRBF );

[ L, U, ~ ] = f_fkm( sample, nLocalRegion, 1 );

pbound=Polyhedron([0 0; 0 1;1 0;1 1]);
V = mpt_voronoi(sample', 'bound',pbound);

% different expansion factors
clusterTable0 = softPartition(0);
clusterTable3 = softPartition(0.3);
clusterTable6 = softPartition(0.6);
clusterTable10 = softPartition(1);

subplot(2,2,1); plotClusters(clusterTable0);
subplot(2,2,2); plotClusters(clusterTable3);
subplot(2,2,3); plotClusters(clusterTable6);
subplot(2,2,4); plotClusters(clusterTable10);

    function [clusterTable] = softPartition(lambda)
        clusterTable = zeros(1, nRBF);
        
        thr = (1-lambda^(1/2))/2; % threshold

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
        scatter(L(:,1), L(:,2), 'ro'); hold on;
        face = [0.871 0.49 0.0; 
            0.302 0.745 0.933; 
            0.467 0.675 0.188];
        
        for pointId = 1 : nRBF
            switch clusterTable(pointId)
                case 1
                    loop = f_minimal_convex_polygon(V.Set(pointId, 1).V')';
                    fill(loop(:,1), loop(:,2), face(1,:)); hold on;
                case 2
                    loop = f_minimal_convex_polygon(V.Set(pointId, 1).V')';
                    fill(loop(:,1), loop(:,2), face(2,:)); hold on;
                case 3
                    loop = f_minimal_convex_polygon(V.Set(pointId, 1).V')';
                    fill(loop(:,1), loop(:,2), face(3,:)); hold on;
            end
        end
        
        for pointId = 1 : nRBF
            switch clusterTable(pointId)
                case 1
                    scatter(sample(pointId,1), sample(pointId,2), 'kd'); hold on;
                case 2
                    scatter(sample(pointId,1), sample(pointId,2), 'kx'); hold on;
                case 3
                    scatter(sample(pointId,1), sample(pointId,2), 'kd'); hold on;
                    scatter(sample(pointId,1), sample(pointId,2), 'kx'); hold on;
            end
        end
        
        axis([0 1 0 1]);
    end

end
