#! /bin/bash -l

mkdir -p machines

for file in ./_data/machine_files/*yml; do
	if [[ $file != *"comment"* ]]; then
		machine=$(echo $file | sed 's/\.yml//; s/.*\///')
		echo '---' > machines/${machine}.md
		echo "machine: ${machine}" >> machines/${machine}.md
		echo '---' >> machines/${machine}.md
		echo '' >> machines/${machine}.md
		echo "{% include template_machinefile.md file=site.data.machine_files.${machine} %}" >> machines/${machine}.md
	fi
done
