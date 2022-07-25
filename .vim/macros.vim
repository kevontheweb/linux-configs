" SNIPPETS
" Groff
autocmd Filetype groff inoremap <leader>new    <ESC>:read ~/Templates/groff.ms<CR>ggi
autocmd Filetype groff inoremap <leader>h    .XN <++> "<++>"<CR>
autocmd Filetype groff inoremap <leader>e    .EQ<CR><++><CR>.EN<CR>
autocmd Filetype groff inoremap <leader>r    <CR>.[<CR><++><CR>.]<CR><ESC>kki
autocmd Filetype groff inoremap <leader>p    .PSPIC "<++>"<CR>.nr fig_index +1<CR>.ce<CR>Figure \n[fig_index]: <++><CR>
autocmd Filetype groff inoremap <leader>f    .fig "<++>" "<++>"
autocmd Filetype groff inoremap <leader>l    .nr list_index 0<CR>.nl<CR><++>
autocmd Filetype groff inoremap <leader>v    .CW "<++>"<CR>


" markdown
autocmd Filetype markdown inoremap <leader>i	![<++>](<++>)
autocmd Filetype markdown inoremap <leader>l	[<++>](<++>)
autocmd Filetype markdown inoremap <leader>c	```<++><ESC>o<++><ESC>o```

" Latex
" math
autocmd Filetype tex,latex,markdown inoremap ;frac      \frac{<++>}{<++>}
autocmd Filetype tex,latex,markdown inoremap ;int       \int_{<++>}^{<++>}
autocmd Filetype tex,latex,markdown inoremap ;sum       \sum_{<++>}^{<++>}
autocmd Filetype tex,latex,markdown  inoremap $ $$<left>

" formatting
autocmd Filetype tex,latex  inoremap ;doc       \documentclass[a4page, 12pt]{article}<Enter><++><Enter>\begin{document}<Enter><++><Enter>\end{document}
autocmd Filetype tex,latex  inoremap ;rep      <ESC>:read ~/.config/nvim/snippets/latex/tuks.tex<CR>
autocmd Filetype tex,latex  inoremap ;sec       \section{<++>}<Enter><Tab>
autocmd Filetype tex,latex  inoremap ;sub       \subsection{<++>}<Enter><Tab>
autocmd Filetype tex,latex  inoremap ;ssub       \subsubsection{<++>}<Enter><Tab>
autocmd Filetype tex,latex  inoremap ;eq        \begin{equation}<Enter><Tab><++><Enter><BS>\label{eq:<++>}<Enter>\end{equation}
autocmd Filetype tex,latex  inoremap ;fig       \begin{figure}[h]<Enter><Tab>\centering<Enter>\includegraphics[width=0.7\textwidth]{<++>}<Enter>\caption{<++>}<Enter>\label{fig:<++>}<Enter><BS>\end{figure}
autocmd Filetype tex,latex  inoremap ;pb        \pagebreak<Enter>
autocmd Filetype tex,latex  inoremap ;toc       \tableofcontents<Enter>
autocmd Filetype tex,latex  inoremap ;pkg       \usepackage{<++>}<Enter>
autocmd Filetype tex,latex  inoremap ;er      	\eqref{eq:<++>}<ESC>2b
autocmd Filetype tex,latex  inoremap ;c			\cite{<++>}<ESC>2b


