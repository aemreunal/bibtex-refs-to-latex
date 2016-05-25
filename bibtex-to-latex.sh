#!/bin/sh

####################################################
#                                                  #
# BibTeX to LaTeX \bibitem converter               #
#                                                  #
####################################################
#                                                  #
# This script converts a file containing           #
# BibTeX entries to a list of \bibitems,           #
# suitable for use in LaTeX.                       #
#                                                  #
# Author:                                          #
# A. Emre Unal                                     #
# aeu@aeu.io                                       #
#                                                  #
# Special thanks to this blog post:                #
# http://timothyandrewbarber.blogspot.com/2011 ->  #
#    /08/fundamental-thinking-convert-bibtex.html  #
# for pointing me in the correct direction         #
# and giving the instruction on how to do          #
# this.                                            #
#                                                  #
####################################################

# 1) Check if refs.bib exists, exit if not
if [ ! -f refs.bib ]; then
    echo "'refs.bib' file not found!"
    exit
fi

# 2) Check if dummy.tex exists, delete if so
if [ -f dummy.tex ]; then
    rm dummy.tex
fi

# 3) Re-create dummy.tex
printf '\\documentclass{article}\n' >> dummy.tex
printf '\\begin{document}\n' >> dummy.tex
printf '\\nocite{*}\n' >> dummy.tex
printf '\\bibliography{refs}\n' >> dummy.tex
printf '\\bibliographystyle{plain}\n' >> dummy.tex
printf '\\end{document}\n' >> dummy.tex

# 4) Create references
latex dummy &>/dev/null
bibtex dummy &>/dev/null
bibtex dummy &>/dev/null
latex dummy &>/dev/null

# 5) Cleanup
rm dummy.aux
rm dummy.blg
rm dummy.dvi
rm dummy.log

echo "References created!"
echo "Find them in: dummy.bbl"
