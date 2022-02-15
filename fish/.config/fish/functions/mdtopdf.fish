function mdtopdf -a infile outfile
    pandoc --from=markdown_mmd+yaml_metadata_block+smart --standalone --to=html -V css="/home/nathan/.config/fish/functions/style.css" $infile | wkhtmltopdf --enable-local-file-access -B 25mm -T 25mm -L 25mm -R 25mm -q -s Letter - $outfile
end
