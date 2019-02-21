% this is enother implementation of EM
%generate sets 
clear
clc

% Get the dataset
DD = load('clusterdata');

% expected number of clusters (estimating the number)
K=8;
best = Inf;
for i=1:8
    [clusters, centroids] = kmeans(DD, i);
    total = 0;
    for c=1:i
        data = DD(clusters == c);
        mu = centroids(c, :);
        diff = data - mu;
        d = norm(diff, 2) / length(data);
        if d < best
            best = d;
            K = i;
        end
    end
end

estim_mu=randn(K,2);
cPi=ones(K)*1/K;
[rows,~]=size(DD);
% generate initial  responsibilities pi and sigma matrices for each cluster
%centroids 
orient=[1,3;4,2];
radiuses = [3,0 ;0, 2];

for k=1:K
    estim(k).sigma = orient*radiuses*orient';
end

fh(1)=figure(1);
exit_flag=50;
while(exit_flag > 0)
    clf(fh(1))
    scatter(DD(:,1),DD(:,2))
    hold on
    %E-step
    for i=1:rows
        for k=1:K
            cpikp(k)=cPi(k)*mvnpdf(DD(i,:),estim_mu(k,:),estim(k).sigma);
        end
        sum_cpikp=sum(cpikp);
        if (sum_cpikp == 0)
            r(i,:) = 1/K;
        else
            for k=1:K
                r(i,k)=cpikp(k)/sum_cpikp;
            end
        end

    end
    
    % M-step
    for k=1:K
        cPi(k)=sum(r(:,k))/rows;
        
        rxx = zeros(2,2);
        for i=1:rows
            rx(i,:)=DD(i,:).*r(i,k);
            rxx=rxx+DD(i,:)'*DD(i,:)*r(i,k);
        end
        estim_mu(k,:)=sum(rx)/sum(r(:,k));
        estim(k).sigma=rxx./sum(r(:,k))-estim_mu(k,:)'*estim_mu(k,:);
        
        ellipse = iso_contour(estim(k).sigma, estim_mu(k, :), 3);
        plot(ellipse(:,1),ellipse(:,2), 'r', 'LineWidth', 1);
        hold on
        plot(estim_mu(k,1),estim_mu(k,2),'o','MarkerFaceColor','magenta','MarkerEdgeColor','green','MarkerSize',10)
        result = ellipse;
        clear ellipse
    end
    exit_flag = exit_flag - 1;
    pause(0.1)
end

cl = [];
for i=1:length(DD)
    cl = [cl; find(r(i, :) == max(r(i, :)))];
end

% Apply k-means (assuming that there are 5 distributions)
[clusters, centroids] = kmeans(DD, K);

% Mean and covariance matrix estimation
covariance_matrix_estimates = zeros(2, 2, K);
mu_estimates = centroids;
for i=1:K
    data = DD(clusters == i, :);
    N = length(data);
    diff = data - mu_estimates(i);
    covariance_matrix_estimates(:, :, i) = cov(data);%transpose(diff) * diff / N;
end

% Calculate distribution's iso contours
% Plot the ellips
for i=1:K
    ellips = iso_contour(covariance_matrix_estimates(:, :, i), centroids(i, :), 3);
    plot(ellips(:, 1), ellips(:, 2), 'g', 'LineWidth', 1);
    hold on;
end
            
     