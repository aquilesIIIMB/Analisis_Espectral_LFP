function struct_merged = mergeStructureLFP(A,B,injured_area)

bandas_eval = [{'delta', 'theta','alpha','beta_low','beta_high','beta','beta_parkinson','gamma_low','gamma_high','gamma'}; ...
    {[1, 4], [4, 8], [8, 12], [12, 20], [20, 30], [12, 30], [8, 30], [30, 60], [60, 90], [30, 90]}]';

if isempty(B)
    if strcmp(injured_area, 'L')
        struct_merged.register_checked = string(A.register_checked);
        struct_merged.injured = A.left;
        struct_merged.uninjured = A.right;
    elseif strcmp(injured_area, 'R')
        struct_merged.register_checked = string(A.register_checked);
        struct_merged.injured = A.right;
        struct_merged.uninjured = A.left;
    else
        warning('Unknowed hemisphere')
    end
    
else
    struct_merged = A;
    struct_merged.register_checked = [struct_merged.register_checked; B.register_checked];
    if strcmp(injured_area, 'L')
        for i = 1:size(bandas_eval,1)
            for j = 1:length(A.injured.power_band)
                % Izquierda

                if ~strcmp(A.injured.power_band(j).area, B.left.power_band(j).area)
                    warning('Not same area in left hemisphere')
                    continue;
                end
                if ~strcmp(A.injured.power_band(j).oscillations(i).band, B.left.power_band(j).oscillations(i).band)
                    warning('Not same oscillations band in left hemisphere')
                    continue;
                end
                if A.injured.power_band(j).oscillations(i).freq ~= B.left.power_band(j).oscillations(i).freq
                    warning('Not same oscillations freq in left hemisphere')
                    continue;
                end

                struct_merged.injured.power_band(j).oscillations(i).pre = [A.injured.power_band(j).oscillations(i).pre, B.left.power_band(j).oscillations(i).pre];
                struct_merged.injured.power_band(j).oscillations(i).on = [A.injured.power_band(j).oscillations(i).on, B.left.power_band(j).oscillations(i).on];
                struct_merged.injured.power_band(j).oscillations(i).post = [A.injured.power_band(j).oscillations(i).post, B.left.power_band(j).oscillations(i).post];

                struct_merged.injured.power_band(j).oscillations(i).pre_norm = [A.injured.power_band(j).oscillations(i).pre_norm, B.left.power_band(j).oscillations(i).pre_norm];
                struct_merged.injured.power_band(j).oscillations(i).on_norm = [A.injured.power_band(j).oscillations(i).on_norm, B.left.power_band(j).oscillations(i).on_norm];
                struct_merged.injured.power_band(j).oscillations(i).post_norm = [A.injured.power_band(j).oscillations(i).post_norm, B.left.power_band(j).oscillations(i).post_norm];

                if ~strcmp(A.injured.power_band(j).fractals(i).band, B.left.power_band(j).fractals(i).band)
                    warning('Not same fractals band in left hemisphere')
                    continue;
                end
                if A.injured.power_band(j).fractals(i).freq ~= B.left.power_band(j).fractals(i).freq
                    warning('Not same fractals freq in left hemisphere')
                    continue;
                end

                struct_merged.injured.power_band(j).fractals(i).pre = [A.injured.power_band(j).fractals(i).pre, B.left.power_band(j).fractals(i).pre];
                struct_merged.injured.power_band(j).fractals(i).on = [A.injured.power_band(j).fractals(i).on, B.left.power_band(j).fractals(i).on];
                struct_merged.injured.power_band(j).fractals(i).post = [A.injured.power_band(j).fractals(i).post, B.left.power_band(j).fractals(i).post];

                struct_merged.injured.power_band(j).fractals(i).pre_norm = [A.injured.power_band(j).fractals(i).pre_norm, B.left.power_band(j).fractals(i).pre_norm];
                struct_merged.injured.power_band(j).fractals(i).on_norm = [A.injured.power_band(j).fractals(i).on_norm, B.left.power_band(j).fractals(i).on_norm];
                struct_merged.injured.power_band(j).fractals(i).post_norm = [A.injured.power_band(j).fractals(i).post_norm, B.left.power_band(j).fractals(i).post_norm];

                % Derecha

                if ~strcmp(A.uninjured.power_band(j).area, B.right.power_band(j).area)
                    warning('Not same area in right hemisphere')
                    continue;
                end
                if ~strcmp(A.uninjured.power_band(j).oscillations(i).band, B.right.power_band(j).oscillations(i).band)
                    warning('Not same oscillations band in right hemisphere')
                    continue;
                end
                if A.uninjured.power_band(j).oscillations(i).freq ~= B.right.power_band(j).oscillations(i).freq
                    warning('Not same oscillations freq in right hemisphere')
                    continue;
                end
               
                struct_merged.uninjured.power_band(j).oscillations(i).pre = [A.uninjured.power_band(j).oscillations(i).pre, B.right.power_band(j).oscillations(i).pre];
                struct_merged.uninjured.power_band(j).oscillations(i).on = [A.uninjured.power_band(j).oscillations(i).on, B.right.power_band(j).oscillations(i).on];
                struct_merged.uninjured.power_band(j).oscillations(i).post = [A.uninjured.power_band(j).oscillations(i).post, B.right.power_band(j).oscillations(i).post];

                struct_merged.uninjured.power_band(j).oscillations(i).pre_norm = [A.uninjured.power_band(j).oscillations(i).pre_norm, B.right.power_band(j).oscillations(i).pre_norm];
                struct_merged.uninjured.power_band(j).oscillations(i).on_norm = [A.uninjured.power_band(j).oscillations(i).on_norm, B.right.power_band(j).oscillations(i).on_norm];
                struct_merged.uninjured.power_band(j).oscillations(i).post_norm = [A.uninjured.power_band(j).oscillations(i).post_norm, B.right.power_band(j).oscillations(i).post_norm];
                
                if ~strcmp(A.uninjured.power_band(j).fractals(i).band, B.right.power_band(j).fractals(i).band)
                    warning('Not same fractals band in right hemisphere')
                    continue;
                end
                if A.uninjured.power_band(j).fractals(i).freq ~= B.right.power_band(j).fractals(i).freq
                    warning('Not same fractals freq in right hemisphere')
                    continue;
                end

                struct_merged.uninjured.power_band(j).fractals(i).pre = [A.uninjured.power_band(j).fractals(i).pre, B.right.power_band(j).fractals(i).pre];
                struct_merged.uninjured.power_band(j).fractals(i).on = [A.uninjured.power_band(j).fractals(i).on, B.right.power_band(j).fractals(i).on];
                struct_merged.uninjured.power_band(j).fractals(i).post = [A.uninjured.power_band(j).fractals(i).post, B.right.power_band(j).fractals(i).post];

                struct_merged.uninjured.power_band(j).fractals(i).pre_norm = [A.uninjured.power_band(j).fractals(i).pre_norm, B.right.power_band(j).fractals(i).pre_norm];
                struct_merged.uninjured.power_band(j).fractals(i).on_norm = [A.uninjured.power_band(j).fractals(i).on_norm, B.right.power_band(j).fractals(i).on_norm];
                struct_merged.uninjured.power_band(j).fractals(i).post_norm = [A.uninjured.power_band(j).fractals(i).post_norm, B.right.power_band(j).fractals(i).post_norm];

            end

            for j = 1:length(A.injured.coherence)

                % Izquierda

                if ~strcmp(A.injured.coherence(j).area1, B.left.coherence(j).area1)
                    warning('Not same area1 in left hemisphere')
                    continue;
                end
                if ~strcmp(A.injured.coherence(j).area2, B.left.coherence(j).area2)
                    warning('Not same area2 in left hemisphere')
                    continue;
                end
                if ~strcmp(A.injured.coherence(j).sum_MSC(i).band, B.left.coherence(j).sum_MSC(i).band)
                    warning('Not same sum MSC band in left hemisphere')
                    continue;
                end
                if A.injured.coherence(j).sum_MSC(i).freq ~= B.left.coherence(j).sum_MSC(i).freq
                    warning('Not same sum MSC freq in left hemisphere')
                    continue;
                end                
                %struct_merged.left.coherence(j).area1 = areas_sync_izq(j,1);
                %struct_merged.left.coherence(j).area2 = areas_sync_izq(j,2);
                %struct_merged.left.coherence(j).sum_MSC(i).band = bandas_eval{i,1};
                %struct_merged.left.coherence(j).sum_MSC(i).freq = bandas_eval{i,2};
                
                struct_merged.injured.coherence(j).sum_MSC(i).pre = [A.injured.coherence(j).sum_MSC(i).pre, B.left.coherence(j).sum_MSC(i).pre];
                struct_merged.injured.coherence(j).sum_MSC(i).on = [A.injured.coherence(j).sum_MSC(i).on, B.left.coherence(j).sum_MSC(i).on];
                struct_merged.injured.coherence(j).sum_MSC(i).post = [A.injured.coherence(j).sum_MSC(i).post, B.left.coherence(j).sum_MSC(i).post];

                if ~strcmp(A.injured.coherence(j).coupling_strength(i).band, B.left.coherence(j).coupling_strength(i).band)
                    warning('Not same sum MSC band in left hemisphere')
                    continue;
                end
                if A.injured.coherence(j).coupling_strength(i).freq ~= B.left.coherence(j).coupling_strength(i).freq
                    warning('Not same sum MSC freq in left hemisphere')
                    continue;
                end
                %struct_merged.left.coherence(j).coupling_strength(i).band = bandas_eval{i,1};
                %struct_merged.left.coherence(j).coupling_strength(i).freq = bandas_eval{i,2};
                
                struct_merged.injured.coherence(j).coupling_strength(i).pre = [A.injured.coherence(j).coupling_strength(i).pre, B.left.coherence(j).coupling_strength(i).pre];
                struct_merged.injured.coherence(j).coupling_strength(i).on = [A.injured.coherence(j).coupling_strength(i).on, B.left.coherence(j).coupling_strength(i).on];
                struct_merged.injured.coherence(j).coupling_strength(i).post = [A.injured.coherence(j).coupling_strength(i).post, B.left.coherence(j).coupling_strength(i).post];

                if ~strcmp(A.injured.coherence(j).delay(i).band, B.left.coherence(j).delay(i).band)
                    warning('Not same sum MSC band in left hemisphere')
                    continue;
                end
                if A.injured.coherence(j).delay(i).freq ~= B.left.coherence(j).delay(i).freq
                    warning('Not same sum MSC freq in left hemisphere')
                    continue;
                end
                %struct_merged.left.coherence(j).delay(i).band = bandas_eval{i,1};
                %struct_merged.left.coherence(j).delay(i).freq = bandas_eval{i,2};
                
                struct_merged.injured.coherence(j).delay(i).pre = [A.injured.coherence(j).delay(i).pre, B.left.coherence(j).delay(i).pre];
                struct_merged.injured.coherence(j).delay(i).on = [A.injured.coherence(j).delay(i).on, B.left.coherence(j).delay(i).on];
                struct_merged.injured.coherence(j).delay(i).post = [A.injured.coherence(j).delay(i).post, B.left.coherence(j).delay(i).post];

                % Derecha

                if ~strcmp(A.uninjured.coherence(j).area1, B.right.coherence(j).area1)
                    warning('Not same area1 in left hemisphere')
                    continue;
                end
                if ~strcmp(A.uninjured.coherence(j).area2, B.right.coherence(j).area2)
                    warning('Not same area2 in left hemisphere')
                    continue;
                end
                if ~strcmp(A.uninjured.coherence(j).sum_MSC(i).band, B.right.coherence(j).sum_MSC(i).band)
                    warning('Not same sum MSC band in left hemisphere')
                    continue;
                end
                if A.uninjured.coherence(j).sum_MSC(i).freq ~= B.right.coherence(j).sum_MSC(i).freq
                    warning('Not same sum MSC freq in left hemisphere')
                    continue;
                end  
                %struct_merged.right.coherence(j).area1 = areas_sync_der(j,1);
                %struct_merged.right.coherence(j).area2 = areas_sync_der(j,2);
                %struct_merged.right.coherence(j).sum_MSC(i).band = bandas_eval{i,1};
                %struct_merged.right.coherence(j).sum_MSC(i).freq = bandas_eval{i,2};
                
                struct_merged.uninjured.coherence(j).sum_MSC(i).pre = [A.uninjured.coherence(j).sum_MSC(i).pre, B.right.coherence(j).sum_MSC(i).pre];
                struct_merged.uninjured.coherence(j).sum_MSC(i).on = [A.uninjured.coherence(j).sum_MSC(i).on, B.right.coherence(j).sum_MSC(i).on];
                struct_merged.uninjured.coherence(j).sum_MSC(i).post = [A.uninjured.coherence(j).sum_MSC(i).post, B.right.coherence(j).sum_MSC(i).post];

                if ~strcmp(A.uninjured.coherence(j).coupling_strength(i).band, B.right.coherence(j).coupling_strength(i).band)
                    warning('Not same sum MSC band in left hemisphere')
                    continue;
                end
                if A.uninjured.coherence(j).coupling_strength(i).freq ~= B.right.coherence(j).coupling_strength(i).freq
                    warning('Not same sum MSC freq in left hemisphere')
                    continue;
                end
                %struct_merged.right.coherence(j).coupling_strength(i).band = bandas_eval{i,1};
                %struct_merged.right.coherence(j).coupling_strength(i).freq = bandas_eval{i,2};
                
                struct_merged.uninjured.coherence(j).coupling_strength(i).pre = [A.uninjured.coherence(j).coupling_strength(i).pre, B.right.coherence(j).coupling_strength(i).pre];
                struct_merged.uninjured.coherence(j).coupling_strength(i).on = [A.uninjured.coherence(j).coupling_strength(i).on, B.right.coherence(j).coupling_strength(i).on];
                struct_merged.uninjured.coherence(j).coupling_strength(i).post = [A.uninjured.coherence(j).coupling_strength(i).post, B.right.coherence(j).coupling_strength(i).post];

                if ~strcmp(A.uninjured.coherence(j).delay(i).band, B.right.coherence(j).delay(i).band)
                    warning('Not same sum MSC band in left hemisphere')
                    continue;
                end
                if A.uninjured.coherence(j).delay(i).freq ~= B.right.coherence(j).delay(i).freq
                    warning('Not same sum MSC freq in left hemisphere')
                    continue;
                end
                %struct_merged.right.coherence(j).delay(i).band = bandas_eval{i,1};
                %struct_merged.right.coherence(j).delay(i).freq = bandas_eval{i,2};
                
                struct_merged.uninjured.coherence(j).delay(i).pre = [A.uninjured.coherence(j).delay(i).pre, B.right.coherence(j).delay(i).pre];
                struct_merged.uninjured.coherence(j).delay(i).on = [A.uninjured.coherence(j).delay(i).on, B.right.coherence(j).delay(i).on];
                struct_merged.uninjured.coherence(j).delay(i).post = [A.uninjured.coherence(j).delay(i).post, B.right.coherence(j).delay(i).post];
            end

        end

        for j = 1:length(A.injured.power_total)

            % Izquierda

            if ~strcmp(A.injured.power_total(j).area, B.left.power_total(j).area)
                warning('Not same area total in left hemisphere')
                continue;
            end
            %struct_merged.left.power_total(j).area = [];
            struct_merged.injured.power_total(j).oscillations.pre = [A.injured.power_total(j).oscillations.pre, B.left.power_total(j).oscillations.pre];
            struct_merged.injured.power_total(j).oscillations.on = [A.injured.power_total(j).oscillations.on, B.left.power_total(j).oscillations.on];
            struct_merged.injured.power_total(j).oscillations.post = [A.injured.power_total(j).oscillations.post, B.left.power_total(j).oscillations.post];

            struct_merged.injured.power_total(j).oscillations.pre_norm = [A.injured.power_total(j).oscillations.pre_norm, B.left.power_total(j).oscillations.pre_norm];
            struct_merged.injured.power_total(j).oscillations.on_norm = [A.injured.power_total(j).oscillations.on_norm, B.left.power_total(j).oscillations.on_norm];
            struct_merged.injured.power_total(j).oscillations.post_norm = [A.injured.power_total(j).oscillations.post_norm, B.left.power_total(j).oscillations.post_norm];

            struct_merged.injured.power_total(j).fractals.pre = [A.injured.power_total(j).fractals.pre, B.left.power_total(j).fractals.pre];
            struct_merged.injured.power_total(j).fractals.on = [A.injured.power_total(j).fractals.on, B.left.power_total(j).fractals.on];
            struct_merged.injured.power_total(j).fractals.post = [A.injured.power_total(j).fractals.post, B.left.power_total(j).fractals.post];

            struct_merged.injured.power_total(j).fractals.pre_norm = [A.injured.power_total(j).fractals.pre_norm, B.left.power_total(j).fractals.pre_norm];
            struct_merged.injured.power_total(j).fractals.on_norm = [A.injured.power_total(j).fractals.on_norm, B.left.power_total(j).fractals.on_norm];
            struct_merged.injured.power_total(j).fractals.post_norm = [A.injured.power_total(j).fractals.post_norm, B.left.power_total(j).fractals.post_norm];

            struct_merged.injured.power_total(j).beta_exponent.pre = [A.injured.power_total(j).beta_exponent.pre, B.left.power_total(j).beta_exponent.pre];
            struct_merged.injured.power_total(j).beta_exponent.on = [A.injured.power_total(j).beta_exponent.on, B.left.power_total(j).beta_exponent.on];
            struct_merged.injured.power_total(j).beta_exponent.post = [A.injured.power_total(j).beta_exponent.post, B.left.power_total(j).beta_exponent.post];

            % Derecha

            if ~strcmp(A.uninjured.power_total(j).area, B.right.power_total(j).area)
                warning('Not same area total in left hemisphere')
                continue;
            end
            %struct_merged.right.power_total(j).area = areas_power_der(j);
            struct_merged.uninjured.power_total(j).oscillations.pre = [A.uninjured.power_total(j).oscillations.pre, B.right.power_total(j).oscillations.pre];
            struct_merged.uninjured.power_total(j).oscillations.on = [A.uninjured.power_total(j).oscillations.on, B.right.power_total(j).oscillations.on];
            struct_merged.uninjured.power_total(j).oscillations.post = [A.uninjured.power_total(j).oscillations.post, B.right.power_total(j).oscillations.post];

            struct_merged.uninjured.power_total(j).oscillations.pre_norm = [A.uninjured.power_total(j).oscillations.pre_norm, B.right.power_total(j).oscillations.pre_norm];
            struct_merged.uninjured.power_total(j).oscillations.on_norm = [A.uninjured.power_total(j).oscillations.on_norm, B.right.power_total(j).oscillations.on_norm];
            struct_merged.uninjured.power_total(j).oscillations.post_norm = [A.uninjured.power_total(j).oscillations.post_norm, B.right.power_total(j).oscillations.post_norm];

            struct_merged.uninjured.power_total(j).fractals.pre = [A.uninjured.power_total(j).fractals.pre, B.right.power_total(j).fractals.pre];
            struct_merged.uninjured.power_total(j).fractals.on = [A.uninjured.power_total(j).fractals.on, B.right.power_total(j).fractals.on];
            struct_merged.uninjured.power_total(j).fractals.post = [A.uninjured.power_total(j).fractals.post, B.right.power_total(j).fractals.post];

            struct_merged.uninjured.power_total(j).fractals.pre_norm = [A.uninjured.power_total(j).fractals.pre_norm, B.right.power_total(j).fractals.pre_norm];
            struct_merged.uninjured.power_total(j).fractals.on_norm = [A.uninjured.power_total(j).fractals.on_norm, B.right.power_total(j).fractals.on_norm];
            struct_merged.uninjured.power_total(j).fractals.post_norm = [A.uninjured.power_total(j).fractals.post_norm, B.right.power_total(j).fractals.post_norm];

            struct_merged.uninjured.power_total(j).beta_exponent.pre = [A.uninjured.power_total(j).beta_exponent.pre, B.right.power_total(j).beta_exponent.pre];
            struct_merged.uninjured.power_total(j).beta_exponent.on = [A.uninjured.power_total(j).beta_exponent.on, B.right.power_total(j).beta_exponent.on];
            struct_merged.uninjured.power_total(j).beta_exponent.post = [A.uninjured.power_total(j).beta_exponent.post, B.right.power_total(j).beta_exponent.post];

        end
        
    elseif strcmp(injured_area,'R')
        for i = 1:size(bandas_eval,1)
            for j = 1:length(A.uninjured.power_band)
                % Izquierda

                if ~strcmp(A.uninjured.power_band(j).area, B.left.power_band(j).area)
                    warning('Not same area in left hemisphere')
                    continue;
                end
                if ~strcmp(A.uninjured.power_band(j).oscillations(i).band, B.left.power_band(j).oscillations(i).band)
                    warning('Not same oscillations band in left hemisphere')
                    continue;
                end
                if A.uninjured.power_band(j).oscillations(i).freq ~= B.left.power_band(j).oscillations(i).freq
                    warning('Not same oscillations freq in left hemisphere')
                    continue;
                end

                struct_merged.uninjured.power_band(j).oscillations(i).pre = [A.uninjured.power_band(j).oscillations(i).pre, B.left.power_band(j).oscillations(i).pre];
                struct_merged.uninjured.power_band(j).oscillations(i).on = [A.uninjured.power_band(j).oscillations(i).on, B.left.power_band(j).oscillations(i).on];
                struct_merged.uninjured.power_band(j).oscillations(i).post = [A.uninjured.power_band(j).oscillations(i).post, B.left.power_band(j).oscillations(i).post];

                struct_merged.uninjured.power_band(j).oscillations(i).pre_norm = [A.uninjured.power_band(j).oscillations(i).pre_norm, B.left.power_band(j).oscillations(i).pre_norm];
                struct_merged.uninjured.power_band(j).oscillations(i).on_norm = [A.uninjured.power_band(j).oscillations(i).on_norm, B.left.power_band(j).oscillations(i).on_norm];
                struct_merged.uninjured.power_band(j).oscillations(i).post_norm = [A.uninjured.power_band(j).oscillations(i).post_norm, B.left.power_band(j).oscillations(i).post_norm];

                if ~strcmp(A.uninjured.power_band(j).fractals(i).band, B.left.power_band(j).fractals(i).band)
                    warning('Not same fractals band in left hemisphere')
                    continue;
                end
                if A.uninjured.power_band(j).fractals(i).freq ~= B.left.power_band(j).fractals(i).freq
                    warning('Not same fractals freq in left hemisphere')
                    continue;
                end

                struct_merged.uninjured.power_band(j).fractals(i).pre = [A.uninjured.power_band(j).fractals(i).pre, B.left.power_band(j).fractals(i).pre];
                struct_merged.uninjured.power_band(j).fractals(i).on = [A.uninjured.power_band(j).fractals(i).on, B.left.power_band(j).fractals(i).on];
                struct_merged.uninjured.power_band(j).fractals(i).post = [A.uninjured.power_band(j).fractals(i).post, B.left.power_band(j).fractals(i).post];

                struct_merged.uninjured.power_band(j).fractals(i).pre_norm = [A.uninjured.power_band(j).fractals(i).pre_norm, B.left.power_band(j).fractals(i).pre_norm];
                struct_merged.uninjured.power_band(j).fractals(i).on_norm = [A.uninjured.power_band(j).fractals(i).on_norm, B.left.power_band(j).fractals(i).on_norm];
                struct_merged.uninjured.power_band(j).fractals(i).post_norm = [A.uninjured.power_band(j).fractals(i).post_norm, B.left.power_band(j).fractals(i).post_norm];

                % Derecha

                if ~strcmp(A.injured.power_band(j).area, B.right.power_band(j).area)
                    warning('Not same area in right hemisphere')
                    continue;
                end
                if ~strcmp(A.injured.power_band(j).oscillations(i).band, B.right.power_band(j).oscillations(i).band)
                    warning('Not same oscillations band in right hemisphere')
                    continue;
                end
                if A.injured.power_band(j).oscillations(i).freq ~= B.right.power_band(j).oscillations(i).freq
                    warning('Not same oscillations freq in right hemisphere')
                    continue;
                end
               
                struct_merged.injured.power_band(j).oscillations(i).pre = [A.injured.power_band(j).oscillations(i).pre, B.right.power_band(j).oscillations(i).pre];
                struct_merged.injured.power_band(j).oscillations(i).on = [A.injured.power_band(j).oscillations(i).on, B.right.power_band(j).oscillations(i).on];
                struct_merged.injured.power_band(j).oscillations(i).post = [A.injured.power_band(j).oscillations(i).post, B.right.power_band(j).oscillations(i).post];

                struct_merged.injured.power_band(j).oscillations(i).pre_norm = [A.injured.power_band(j).oscillations(i).pre_norm, B.right.power_band(j).oscillations(i).pre_norm];
                struct_merged.injured.power_band(j).oscillations(i).on_norm = [A.injured.power_band(j).oscillations(i).on_norm, B.right.power_band(j).oscillations(i).on_norm];
                struct_merged.injured.power_band(j).oscillations(i).post_norm = [A.injured.power_band(j).oscillations(i).post_norm, B.right.power_band(j).oscillations(i).post_norm];
                
                if ~strcmp(A.injured.power_band(j).fractals(i).band, B.right.power_band(j).fractals(i).band)
                    warning('Not same fractals band in right hemisphere')
                    continue;
                end
                if A.injured.power_band(j).fractals(i).freq ~= B.right.power_band(j).fractals(i).freq
                    warning('Not same fractals freq in right hemisphere')
                    continue;
                end

                struct_merged.injured.power_band(j).fractals(i).pre = [A.injured.power_band(j).fractals(i).pre, B.right.power_band(j).fractals(i).pre];
                struct_merged.injured.power_band(j).fractals(i).on = [A.injured.power_band(j).fractals(i).on, B.right.power_band(j).fractals(i).on];
                struct_merged.injured.power_band(j).fractals(i).post = [A.injured.power_band(j).fractals(i).post, B.right.power_band(j).fractals(i).post];

                struct_merged.injured.power_band(j).fractals(i).pre_norm = [A.injured.power_band(j).fractals(i).pre_norm, B.right.power_band(j).fractals(i).pre_norm];
                struct_merged.injured.power_band(j).fractals(i).on_norm = [A.injured.power_band(j).fractals(i).on_norm, B.right.power_band(j).fractals(i).on_norm];
                struct_merged.injured.power_band(j).fractals(i).post_norm = [A.injured.power_band(j).fractals(i).post_norm, B.right.power_band(j).fractals(i).post_norm];

            end

            for j = 1:length(A.uninjured.coherence)

                % Izquierda

                %struct_merged.uninjured.coherence(j).area1 = areas_sync_izq(j,1);
                %struct_merged.uninjured.coherence(j).area2 = areas_sync_izq(j,2);
                %struct_merged.uninjured.coherence(j).sum_MSC(i).band = bandas_eval{i,1};
                %struct_merged.uninjured.coherence(j).sum_MSC(i).freq = bandas_eval{i,2};
                
                struct_merged.uninjured.coherence(j).sum_MSC(i).pre = [A.uninjured.coherence(j).sum_MSC(i).pre, B.left.coherence(j).sum_MSC(i).pre];
                struct_merged.uninjured.coherence(j).sum_MSC(i).on = [A.uninjured.coherence(j).sum_MSC(i).on, B.left.coherence(j).sum_MSC(i).on];
                struct_merged.uninjured.coherence(j).sum_MSC(i).post = [A.uninjured.coherence(j).sum_MSC(i).post, B.left.coherence(j).sum_MSC(i).post];

                %struct_merged.uninjured.coherence(j).coupling_strength(i).band = bandas_eval{i,1};
                %struct_merged.uninjured.coherence(j).coupling_strength(i).freq = bandas_eval{i,2};
                
                struct_merged.uninjured.coherence(j).coupling_strength(i).pre = [A.uninjured.coherence(j).coupling_strength(i).pre, B.left.coherence(j).coupling_strength(i).pre];
                struct_merged.uninjured.coherence(j).coupling_strength(i).on = [A.uninjured.coherence(j).coupling_strength(i).on, B.left.coherence(j).coupling_strength(i).on];
                struct_merged.uninjured.coherence(j).coupling_strength(i).post = [A.uninjured.coherence(j).coupling_strength(i).post, B.left.coherence(j).coupling_strength(i).post];

                %struct_merged.uninjured.coherence(j).delay(i).band = bandas_eval{i,1};
                %struct_merged.uninjured.coherence(j).delay(i).freq = bandas_eval{i,2};
                
                struct_merged.uninjured.coherence(j).delay(i).pre = [A.uninjured.coherence(j).delay(i).pre, B.left.coherence(j).delay(i).pre];
                struct_merged.uninjured.coherence(j).delay(i).on = [A.uninjured.coherence(j).delay(i).on, B.left.coherence(j).delay(i).on];
                struct_merged.uninjured.coherence(j).delay(i).post = [A.uninjured.coherence(j).delay(i).post, B.left.coherence(j).delay(i).post];

                % Derecha

                %struct_merged.injured.coherence(j).area1 = areas_sync_der(j,1);
                %struct_merged.injured.coherence(j).area2 = areas_sync_der(j,2);
                %struct_merged.injured.coherence(j).sum_MSC(i).band = bandas_eval{i,1};
                %struct_merged.injured.coherence(j).sum_MSC(i).freq = bandas_eval{i,2};
                
                struct_merged.injured.coherence(j).sum_MSC(i).pre = [A.injured.coherence(j).sum_MSC(i).pre, B.right.coherence(j).sum_MSC(i).pre];
                struct_merged.injured.coherence(j).sum_MSC(i).on = [A.injured.coherence(j).sum_MSC(i).on, B.right.coherence(j).sum_MSC(i).on];
                struct_merged.injured.coherence(j).sum_MSC(i).post = [A.injured.coherence(j).sum_MSC(i).post, B.right.coherence(j).sum_MSC(i).post];

                %struct_merged.injured.coherence(j).coupling_strength(i).band = bandas_eval{i,1};
                %struct_merged.injured.coherence(j).coupling_strength(i).freq = bandas_eval{i,2};
                
                struct_merged.injured.coherence(j).coupling_strength(i).pre = [A.injured.coherence(j).coupling_strength(i).pre, B.right.coherence(j).coupling_strength(i).pre];
                struct_merged.injured.coherence(j).coupling_strength(i).on = [A.injured.coherence(j).coupling_strength(i).on, B.right.coherence(j).coupling_strength(i).on];
                struct_merged.injured.coherence(j).coupling_strength(i).post = [A.injured.coherence(j).coupling_strength(i).post, B.right.coherence(j).coupling_strength(i).post];

                %struct_merged.injured.coherence(j).delay(i).band = bandas_eval{i,1};
                %struct_merged.injured.coherence(j).delay(i).freq = bandas_eval{i,2};
                
                struct_merged.injured.coherence(j).delay(i).pre = [A.injured.coherence(j).delay(i).pre, B.right.coherence(j).delay(i).pre];
                struct_merged.injured.coherence(j).delay(i).on = [A.injured.coherence(j).delay(i).on, B.right.coherence(j).delay(i).on];
                struct_merged.injured.coherence(j).delay(i).post = [A.injured.coherence(j).delay(i).post, B.right.coherence(j).delay(i).post];
            end

        end

        for j = 1:length(A.uninjured.power_total)

            % Izquierda

            %struct_merged.uninjured.power_total(j).area = [];
            struct_merged.uninjured.power_total(j).oscillations.pre = [A.uninjured.power_total(j).oscillations.pre, B.left.power_total(j).oscillations.pre];
            struct_merged.uninjured.power_total(j).oscillations.on = [A.uninjured.power_total(j).oscillations.on, B.left.power_total(j).oscillations.on];
            struct_merged.uninjured.power_total(j).oscillations.post = [A.uninjured.power_total(j).oscillations.post, B.left.power_total(j).oscillations.post];

            struct_merged.uninjured.power_total(j).oscillations.pre_norm = [A.uninjured.power_total(j).oscillations.pre_norm, B.left.power_total(j).oscillations.pre_norm];
            struct_merged.uninjured.power_total(j).oscillations.on_norm = [A.uninjured.power_total(j).oscillations.on_norm, B.left.power_total(j).oscillations.on_norm];
            struct_merged.uninjured.power_total(j).oscillations.post_norm = [A.uninjured.power_total(j).oscillations.post_norm, B.left.power_total(j).oscillations.post_norm];

            struct_merged.uninjured.power_total(j).fractals.pre = [A.uninjured.power_total(j).fractals.pre, B.left.power_total(j).fractals.pre];
            struct_merged.uninjured.power_total(j).fractals.on = [A.uninjured.power_total(j).fractals.on, B.left.power_total(j).fractals.on];
            struct_merged.uninjured.power_total(j).fractals.post = [A.uninjured.power_total(j).fractals.post, B.left.power_total(j).fractals.post];

            struct_merged.uninjured.power_total(j).fractals.pre_norm = [A.uninjured.power_total(j).fractals.pre_norm, B.left.power_total(j).fractals.pre_norm];
            struct_merged.uninjured.power_total(j).fractals.on_norm = [A.uninjured.power_total(j).fractals.on_norm, B.left.power_total(j).fractals.on_norm];
            struct_merged.uninjured.power_total(j).fractals.post_norm = [A.uninjured.power_total(j).fractals.post_norm, B.left.power_total(j).fractals.post_norm];

            struct_merged.uninjured.power_total(j).beta_exponent.pre = [A.uninjured.power_total(j).beta_exponent.pre, B.left.power_total(j).beta_exponent.pre];
            struct_merged.uninjured.power_total(j).beta_exponent.on = [A.uninjured.power_total(j).beta_exponent.on, B.left.power_total(j).beta_exponent.on];
            struct_merged.uninjured.power_total(j).beta_exponent.post = [A.uninjured.power_total(j).beta_exponent.post, B.left.power_total(j).beta_exponent.post];

            % Derecha

            %struct_merged.injured.power_total(j).area = areas_power_der(j);
            struct_merged.injured.power_total(j).oscillations.pre = [A.injured.power_total(j).oscillations.pre, B.right.power_total(j).oscillations.pre];
            struct_merged.injured.power_total(j).oscillations.on = [A.injured.power_total(j).oscillations.on, B.right.power_total(j).oscillations.on];
            struct_merged.injured.power_total(j).oscillations.post = [A.injured.power_total(j).oscillations.post, B.right.power_total(j).oscillations.post];

            struct_merged.injured.power_total(j).oscillations.pre_norm = [A.injured.power_total(j).oscillations.pre_norm, B.right.power_total(j).oscillations.pre_norm];
            struct_merged.injured.power_total(j).oscillations.on_norm = [A.injured.power_total(j).oscillations.on_norm, B.right.power_total(j).oscillations.on_norm];
            struct_merged.injured.power_total(j).oscillations.post_norm = [A.injured.power_total(j).oscillations.post_norm, B.right.power_total(j).oscillations.post_norm];

            struct_merged.injured.power_total(j).fractals.pre = [A.injured.power_total(j).fractals.pre, B.right.power_total(j).fractals.pre];
            struct_merged.injured.power_total(j).fractals.on = [A.injured.power_total(j).fractals.on, B.right.power_total(j).fractals.on];
            struct_merged.injured.power_total(j).fractals.post = [A.injured.power_total(j).fractals.post, B.right.power_total(j).fractals.post];

            struct_merged.injured.power_total(j).fractals.pre_norm = [A.injured.power_total(j).fractals.pre_norm, B.right.power_total(j).fractals.pre_norm];
            struct_merged.injured.power_total(j).fractals.on_norm = [A.injured.power_total(j).fractals.on_norm, B.right.power_total(j).fractals.on_norm];
            struct_merged.injured.power_total(j).fractals.post_norm = [A.injured.power_total(j).fractals.post_norm, B.right.power_total(j).fractals.post_norm];

            struct_merged.injured.power_total(j).beta_exponent.pre = [A.injured.power_total(j).beta_exponent.pre, B.right.power_total(j).beta_exponent.pre];
            struct_merged.injured.power_total(j).beta_exponent.on = [A.injured.power_total(j).beta_exponent.on, B.right.power_total(j).beta_exponent.on];
            struct_merged.injured.power_total(j).beta_exponent.post = [A.injured.power_total(j).beta_exponent.post, B.right.power_total(j).beta_exponent.post];

        end

                
    else
        warning('Unknowed hemisphere')
        
    end

    
end






end