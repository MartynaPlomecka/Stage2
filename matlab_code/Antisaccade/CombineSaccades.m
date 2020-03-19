function out = CombineSaccades(saccadesBlocks, protocol)
out = [];
for i = 1:min(size(saccadesBlocks, 2),size(protocol,2))
    if protocol(i) == 1
        out = horzcat(out, saccadesBlocks(i).block);
    end
end
end
