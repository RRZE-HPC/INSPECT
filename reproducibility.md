
[« go home](index)

## Reproducibility

- Anzahl der eingeloggten User auf dem System (users, w, ...)
- Aktuelles CPUset (procfs oder likwid-pin -p)
- CPU Frequenz auf eine bestimmte Frequenz gepinnt? Turbo? (likwid-setFrequencies)
- Uncore Frequenzgrenzen oder gepinnt? (likwid-setFrequencies)
- Prefetcher (likwid-features)
- Topologie (likwid-topology, lscpu, numactl, ...)
- Numa Balancing? (procfs)
- Huge pages (procfs)
- Aktuelle Load (falls noch andere Prozesse laufen)
- Energielimits (sysfs)
- Performance energy bias (likwid-powermeter -i)
