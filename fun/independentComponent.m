function pc = independentComponent(net)
[U, comp] = graphconncomp(net);
pc = getClust(comp);
s = getClusterSizes(pc);
pc = [pc(s > 1) merge(pc(s == 1))];